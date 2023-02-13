//
//  FutureTestView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/14.
//

import SwiftUI
import Combine

struct FutureTestView: View {
    @StateObject private var viewModel = CombineViewModel()
    
    var body: some View {
        VStack {
            Button("testFuture") { self.viewModel.testFuture() }
        }
    }
}

struct FutureTestView_Previews: PreviewProvider {
    static var previews: some View {
        FutureTestView()
    }
}

extension FutureTestView {
    class CombineViewModel: ObservableObject {
        private var subscriptions = Set<AnyCancellable>()
        
        deinit {
            print("CombineViewModel::deinit")
        }
        
        func testFuture() -> Void {
            let future = futureIncrement(integer: 1, afterDelay: 3)
            future
                .sink(
                    receiveCompletion: { print("first", $0) },
                    receiveValue: { print("first", $0) }
                )
                .store(in: &subscriptions)
            
            future
                .sink(
                    receiveCompletion: { print("second", $0) },
                    receiveValue: { print("second", $0) }
                )
                .store(in: &subscriptions)
            
            future
                .sink(
                    receiveCompletion: { print("third", $0) },
                    receiveValue: { print("third", $0) }
                )
                .store(in: &subscriptions)
            
        }
        
        private func futureIncrement(integer: Int, afterDelay delay: TimeInterval) -> Future<Int, Never> {
            Future { promise in
                print("futureIncrement")
                DispatchQueue.global().asyncAfter(deadline: .now() + delay) {
                    promise(.success(integer + 1))
                }
            }
        }
    }
}
