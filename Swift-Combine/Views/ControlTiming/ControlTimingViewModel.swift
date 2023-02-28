//
//  ControlTimingViewModel.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/25.
//

import Foundation
import Combine

class ControlTimingViewModel: ObservableObject {
    @Published var debounceResults = [String]()
    @Published var debounceText = ""
    @Published var inputText = ""
    @Published var delayResults = [String]()
    
    private var cancellables = Set<AnyCancellable>()
    private let debounceSubject = PassthroughSubject<Int, Never>()
    private let bounces:[(Int,TimeInterval)] = [
        (0, 0),
        (1, 0.25),  // 0.25s interval since last index
        (2, 1),     // 0.75s interval since last index
        (3, 1.25),  // 0.25s interval since last index
        (4, 1.5),   // 0.25s interval since last index
        (5, 2)      // 0.5s interval since last index
    ]
    private let delaySubject = CurrentValueSubject<Bool, Never>(false)
    
    
    init() {
        self.setSampleBounce()
        self.setTextDebounce()
    }
    
    // MARK: Debounce
    func debounce() {
        for bounce in bounces {
            DispatchQueue.main.asyncAfter(deadline: .now() + bounce.1) {
                self.debounceSubject.send(bounce.0)
            }
        }
    }
    
    private func setSampleBounce() {
        debounceSubject
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] index in
                self?.debounceResults.append(String(index))
            }
            .store(in: &cancellables)
    }
    
    private func setTextDebounce() {
        self.$inputText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink { [weak self] text in
                self?.debounceText = text
            }
            .store(in: &cancellables)
    }
    
    // MARK: Throttle
    func throttle() {
        Timer.publish(every: 3.0, on: .main, in: .default)
            .autoconnect()
            .print("\(Date().description)")
            .throttle(for: 10.0, scheduler: RunLoop.main, latest: true)
            .sink(
                receiveCompletion: { print ("Completion: \($0).") },
                receiveValue: { print("Received Timestamp \($0).") }
            )
            .store(in: &cancellables)
    }
    
    // MARK: Delay
    func delay() {
        self.setSampleDelay()
    }
    
    private func setSampleDelay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .none
        dateFormatter.timeStyle = .long
        
        Timer.publish(every: 1.0, on: .main, in: .default)
            .autoconnect()
            .handleEvents(receiveOutput: { date in
                print ("Sending Timestamp \'\(dateFormatter.string(from: date))\' to delay()")
            })
            .delay(for: .seconds(3), scheduler: RunLoop.main, options: .none)
            .sink(
                receiveCompletion: { print ("completion: \($0)", terminator: "\n") },
                receiveValue: { [weak self] value in
                    let now = Date()
                    let result = "At \(dateFormatter.string(from: now)) received  Timestamp \'\(dateFormatter.string(from: value))\' sent: \(String(format: "%.2f", now.timeIntervalSince(value))) secs ago"
                    self?.delayResults.append(result)
                    
                }
            )
            .store(in: &cancellables)
    }
    
    // MARK: Time out
    func timeout() {
        let WAIT_TIME : Int = 2
        let TIMEOUT_TIME : Int = 5
        
        let subject = PassthroughSubject<String, Never>()
        subject
            .timeout(.seconds(TIMEOUT_TIME), scheduler: DispatchQueue.main, options: nil, customError:nil)
            .sink(
                receiveCompletion: { print ("completion: \($0) at \(Date())") },
                receiveValue: { print ("value: \($0) at \(Date())") }
            )
            .store(in: &cancellables)
        
        print ("start at \(Date())")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(WAIT_TIME),
                                      execute: { subject.send("Some data - sent after a delay of \(WAIT_TIME) seconds") } )
        
    }
    
    // MARK: Measure Interval
    func measureInterval() {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .measureInterval(using: RunLoop.main)
            .sink { print("\($0)", terminator: "\n") }
            .store(in: &cancellables)
    }
}
