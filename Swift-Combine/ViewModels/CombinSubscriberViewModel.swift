//
//  CombinSubscriberViewModel.swift
//  Swift-Combine
//
//  Created by k2hoon on 2021/11/02.
//

import Foundation
import Combine

class CombineSubscriberViewModel: ObservableObject {
    var assignInt: Int = 0 {
        didSet {
            print("anInt was set to: \(assignInt)", terminator: "; \n")
        }
        willSet {
            print("anInt will set to: \(assignInt)", terminator: "; \n")
        }
    }
    
    
    func assignSubscriber() {
        let intArray = [1,2,3,4,5,6,7,8,9]
        _ = intArray.publisher.assign(to: \.assignInt, on: self)
    }
    
    func sinkSubscriber() {
        let intArray = [1,2,3,4,5,6,7,8,9]
        _ = intArray.publisher.sink { completion in
            switch completion {
            case .failure(_):
                print("failure")
            case .finished:
                print("finished")
            }
        } receiveValue: { value in
            print(value)
        }
    }
    
    func customSubscriber() {
        let intArray = [1,2,3,4,5,6,7,8,9]
        intArray.publisher.subscribe(CustomSubscriber())
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
        return .max(1)
    }
    
    /// 3. Tells the subscriber that the publisher has completed publishing, either normally or with an error.
    /// - Parameter completion: A Subscribers.Completion case indicating whether publishing completed normally or with an error.
    func receive(completion: Subscribers.Completion<Never>) {
        print("receive::completion")
    }
}
