//
//  TimeoutView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/03/01.
//

import SwiftUI

struct TimeoutView: View {
    @StateObject var viewModel = ControlTimingViewModel()
    
    var body: some View {
        VStack {
            Text("Time out")
                .font(.headline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button("Start timeout") { self.viewModel.timeout() }
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct TimeoutView_Previews: PreviewProvider {
    static var previews: some View {
        TimeoutView()
    }
}
