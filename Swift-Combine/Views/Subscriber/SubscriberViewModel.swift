//
//  SubscriberViewModel.swift
//  Swift-Combine
//
//  Created by k2hoon on 2021/11/02.
//

import Foundation
import Combine

class SubscriberViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let center = NotificationCenter.default
    
    @Published var assignInt: Int = 0 {
        didSet {
            print("assignInt did set to: \(oldValue)", terminator: "; \n")
        }
        willSet {
            print("assignInt will set to: \(newValue)", terminator: "; \n")
        }
    }
    
    init() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(receiveNotify(notification:)),
                                               name: .hello,
                                               object: nil)
        
        NotificationCenter
            .default
            .publisher(for: .hello, object: nil)
            .sink { value in
                print("Received", value)
            }
            .store(in: &cancellables)
    }
    
    deinit {
        print("CombineSubscriberViewModel::deinit")
        NotificationCenter.default.removeObserver(self, name: .hello, object: nil)
    }
    
    func notify() -> Void {
        let userInfo = ["userInfo": "hello"]
        
        center.post(name: .hello, object: nil, userInfo: userInfo)
    }
    
    @objc func receiveNotify(notification: Notification) {
        guard let value = notification.userInfo?["userInfo"] as? String else {
            return
        }
        print("receiveNotify: \(value)")
    }
    
    func customSubscriber() {
        let intArray = [1,2,3,4,5,6,7,8,9]
        intArray.publisher.subscribe(CustomSubscriber())
    }
    
    func assignSubscriber() {
        let intArray = [1,2,3,4,5,6,7,8,9]
        
//        intArray.publisher
//            .assign(to: \.assignInt, on: self) // cycle retain
//            .store(in: &cancellables)
        
        intArray.publisher
            .assign(to: &$assignInt)
            
    }
    
    func sinkSubscriber() {
        let intArray = [1,2,3,4,5,6,7,8,9]
        intArray.publisher
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(_):
                        print("failure")
                    case .finished:
                        print("finished")
                    }
                },
                receiveValue: { value in
                    print(value)
                }
            )
            .store(in: &cancellables)
    }
}

class CustomSubscriber: Subscriber {
    // must specify the type of values
    typealias Input = Int
    typealias Failure = Never
    
    
    /// 1. Tells the subscriber that it has successfully subscribed to the publisher and may request items.
    /// - Parameter subscription: A subscription that represents the connection between publisher and subscriber.
    func receive(subscription: Subscription) {
        print("receive::subscription")
        subscription.request(.max(2))
    }
    
    /// 2. Tells the subscriber that the publisher has produced an element.
    /// - Parameter input: The published element.
    /// - Returns: A Subscribers.Demand instance indicating how many more elements the subscriber expects to receive.
    func receive(_ input: Int) -> Subscribers.Demand {
        print("receive::input: ", input)
//        return .none
//        return .max(1)
        return .unlimited
    }
    
    /// 3. Tells the subscriber that the publisher has completed publishing, either normally or with an error.
    /// - Parameter completion: A Subscribers.Completion case indicating whether publishing completed normally or with an error.
    func receive(completion: Subscribers.Completion<Never>) {
        print("receive::completion")
    }
}

fileprivate extension Notification.Name {
    static let hello = Notification.Name("helloNotification")
}
