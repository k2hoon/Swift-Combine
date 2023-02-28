//
//  DebounceView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/25.
//

import SwiftUI

struct DebounceView: View {
    @StateObject private var viewModel = ControlTimingViewModel()
    @State var debounceText = ""
    var body: some View {
        VStack {
            SampleDebounce(viewModel: self.viewModel)
 
            TextFieldWithDebounce(viewModel: self.viewModel)
        }
        .padding()
    }
    
    struct SampleDebounce: View {
        @ObservedObject var viewModel: ControlTimingViewModel
        
        var body: some View {
            VStack {
                Text("Sample")
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Button("debounce") { self.viewModel.debounce() }
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                List(self.viewModel.debounceResults, id: \.self) { result in
                    Text(result)
                }
                .listStyle(.plain)
                
                Divider()
            }
        }
    }
    
    struct TextFieldWithDebounce : View {
        @ObservedObject var viewModel: ControlTimingViewModel

        var body: some View {
            VStack {
                Text("Text filed with debounce")
                    .font(.headline)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("You entered: \(self.viewModel.debounceText)")
                    .padding()
                
                TextField("Search", text: $viewModel.inputText)
                    .frame(height: 30)
                    .padding(.leading, 5)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.blue, lineWidth: 1)
                    )
                    .padding(.horizontal, 20)
                Divider()
            }
        }
    }
}

struct DebounceView_Previews: PreviewProvider {
    static var previews: some View {
        DebounceView()
    }
}
