//
//  MeasureIntervalView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/03/01.
//

import SwiftUI

struct MeasureIntervalView: View {
    @StateObject var viewModel = ControlTimingViewModel()
    
    var body: some View {
        VStack {
            Text("Measure Interval")
                .font(.headline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Button("Start measure") { self.viewModel.measureInterval() }
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
    }
}

struct MeasureIntervalView_Previews: PreviewProvider {
    static var previews: some View {
        MeasureIntervalView()
    }
}
