//
//  EmptyPublisher.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/15.
//

import SwiftUI
import Combine

struct EmptyTestView: View {
    @StateObject private var viewModel = CombineViewModel()
    
    var body: some View {
        VStack {
            Button("testEmpty") { self.viewModel.testEmpty() }
            Button("emptyNotImmediately") { self.viewModel.testEmptyNotImmediately() }
        }
    }
}

struct EmptyPublisher_Previews: PreviewProvider {
    static var previews: some View {
        EmptyTestView()
    }
}

extension EmptyTestView {
    class CombineViewModel: ObservableObject {
        private var cancellables = Set<AnyCancellable>()
        let emptyPublisher = Empty<Int, Never>(completeImmediately: false)
        
        func testEmpty() {
            Empty<Int, Never>()
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
        
        func testEmptyNotImmediately() {
            emptyPublisher
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
