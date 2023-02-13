//
//  JustTestView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/14.
//

import SwiftUI
import Combine

struct JustTestView: View {
    @StateObject private var viewModel = CombineViewModel()
    var body: some View {
        VStack {
            Button("testJust") { self.viewModel.testJust() }
            Button("testJustCatch") { self.viewModel.testJustCatch() }
        }
    }
}

struct JustTestView_Previews: PreviewProvider {
    static var previews: some View {
        JustTestView()
    }
}

extension JustTestView {
    class CombineViewModel: ObservableObject {
        private var cancellables = Set<AnyCancellable>()
        
        let future = Future<String, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Hello, Error!"])
                promise(.failure(error))
            }
        }
        
        deinit {
            print("CombineViewModel::deinit")
        }
        
        func testJust() {
            let helloJust = Just("Hello Just!")
            
            _ = helloJust
                .sink(
                    receiveCompletion: {
                        print("received completion", $0)
                    },
                    receiveValue: {
                        print("received value", $0)
                    }
                )
            
            _ = helloJust
                .sink(
                    receiveCompletion: {
                        print("received completion (2)", $0)
                    },
                    receiveValue: {
                        print("received value (2)", $0)
                    }
                )
        }
        
        
        func testJustCatch() {
            self.future
                .catch { error in
                    print("testJustCatch:: \(error)")
                    return Just("default value")
                }
                .sink { value in
                    print(value)
                }
                .store(in: &cancellables)
        }
        
    }
}
