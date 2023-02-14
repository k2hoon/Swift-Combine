//
//  FailTestView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/15.
//

import SwiftUI
import Combine

struct FailTestView: View {
    @StateObject private var viewModel = CombineViewModel()
    
    var body: some View {
        VStack {
            Button("testFail") { self.viewModel.testFail() }
        }
    }
}

struct FailTestView_Previews: PreviewProvider {
    static var previews: some View {
        FailTestView()
    }
}

extension FailTestView {
    class CombineViewModel: ObservableObject {
        private var cancellables = Set<AnyCancellable>()
        let emptyPublisher = Empty<Int, Never>(completeImmediately: false)
        
        func testFail() {
            let error = NSError(domain: "",
                                code: 0,
                                userInfo: [NSLocalizedDescriptionKey: "Hello, Error!"])
            Fail<Int, Error>(error: error)
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
    }
}
