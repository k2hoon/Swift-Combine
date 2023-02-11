//
//  PublishedTestView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/11.
//

import SwiftUI
import Combine

struct PublishedTestView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("textValue: \(self.viewModel.textValue)")
            
            Text("dataValue: \(self.viewModel.dataValue)")
            
            Button("Change text") {
                self.viewModel.textValue = "changed"
            }
            
            Button("Change value") {
                self.viewModel.increateDataValue()
            }
        }
    }
}

struct PublishedTestView_Previews: PreviewProvider {
    static var previews: some View {
        PublishedTestView()
    }
}

extension PublishedTestView {
    class DataModel {
        @Published var title: String
        @Published var value: Double {
            willSet {
                print ("value willSet: \(newValue)")
            }
        }
        
        init(title: String, value: Double) {
            self.title = title
            self.value = value
        }
    }
    
    class ViewModel: ObservableObject {
        @Published var textValue = "hello"
        @Published var dataValue = 0.0
        
        private var cancellable: AnyCancellable? = nil
        private var data = DataModel(title: "Test", value: 20.0)
        
        init() {
            self.cancellable = self.data.$value
                .sink { [weak self] value in
                    print ("receive value now: \(value)")
                    self?.dataValue = value
                }
        }
        
        func setTextValue(value: String) {
            self.textValue = value
        }
        
        func increateDataValue() {
            self.data.value += 1
        }
    }
}
