//
//  RecordTestView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/15.
//

import SwiftUI
import Combine

struct RecordTestView: View {
    @StateObject private var viewModel = CombineViewModel()
    
    var body: some View {
        VStack {
            Button("testRecord") { self.viewModel.testRecord() }
        }
    }
}

struct RecordTestView_Previews: PreviewProvider {
    static var previews: some View {
        RecordTestView()
    }
}

class CombineViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    let emptyPublisher = Empty<Int, Never>(completeImmediately: false)
    
    func testRecord() {
        Record<Int, Never>(output: [1,2,3], completion: .finished)
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
