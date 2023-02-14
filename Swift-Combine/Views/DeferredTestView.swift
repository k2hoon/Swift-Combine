//
//  DeferredTestView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/14.
//

import SwiftUI
import Combine

struct DeferredTestView: View {
    @StateObject private var viewModel = CombineViewModel()
    
    var body: some View {
        VStack {
            Button("testDeffered") { self.viewModel.testDeferred() }
            Button("testRandomNumbers") { self.viewModel.testRandomNumbers() }
        }
    }
}

struct DeferredTestView_Previews: PreviewProvider {
    static var previews: some View {
        DeferredTestView()
    }
}

extension DeferredTestView {
    class CombineViewModel: ObservableObject {
        private var cancellables = Set<AnyCancellable>()
        
        private lazy var deferredPublisher = Deferred {
            return self.stringPublisher()
        }
        
        init() {
            // for without Defferd publisher test.
            _ = self.randomPublisher()
        }
        
        func testDeferred() {
            self.deferredPublisher
                .sink(
                    receiveCompletion: { completion in
                        print("Completion: \(completion)")
                    },
                    receiveValue: { value in
                        print("Value: \(value)")
                    }
                )
                .store(in: &cancellables)
        }
        
        func testRandomNumbers() {
            randomNumbersPublisher(count: 3)
                .sink { numbers in
                    print("Subscription 1: \(numbers)")
                }
                .store(in: &cancellables)
            
            randomNumbersPublisher(count: 5)
                .sink { numbers in
                    print("Subscription 2: \(numbers)")
                }
                .store(in: &cancellables)
        }
        
        private func stringPublisher() -> AnyPublisher<String, Error> {
            print("stringPublisher")
            return Just("Hello, World!")
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        private func randomNumbersPublisher(count: Int) -> AnyPublisher<[Int], Never> {
            Deferred {
                Future { promise in
                    var numbers: [Int] = []
                    for _ in 1...count {
                        numbers.append(Int.random(in: 1...100))
                    }
                    promise(.success(numbers))
                }
            }
            .eraseToAnyPublisher()
        }
        
        private func randomPublisher() -> AnyPublisher<[Int], Error> {
            Future { promise in
                var numbers: [Int] = []
                for _ in 1...10 {
                    numbers.append(Int.random(in: 1...100))
                }
                print("randomPublisher: \(numbers)")
                promise(.success(numbers))
                
            }
            .eraseToAnyPublisher()
        }
        
    }
}
