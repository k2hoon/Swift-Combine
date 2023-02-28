//
//  DelayView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/03/01.
//

import SwiftUI

struct DelayView: View {
    @StateObject var viewModel = ControlTimingViewModel()
    
    var body: some View {
        VStack {
            Text("Date time with delay")
                .font(.headline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button("Start delay") { self.viewModel.delay() }
                .frame(maxWidth: .infinity, alignment: .leading)
            
            List(self.viewModel.delayResults, id: \.self) { result in
                Text(result)
            }
            .listStyle(.plain)
        }
        .padding()
    }
}

struct DelayView_Previews: PreviewProvider {
    static var previews: some View {
        DelayView()
    }
}
