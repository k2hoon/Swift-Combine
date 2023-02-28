//
//  ThrottleView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/03/01.
//

import SwiftUI

struct ThrottleView: View {
    @StateObject private var viewModel = ControlTimingViewModel()
    
    var body: some View {
        VStack {
            Text("Throttle")
                .font(.headline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button("Start throttle") { self.viewModel.throttle() }
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct ThrottleView_Previews: PreviewProvider {
    static var previews: some View {
        ThrottleView()
    }
}
