//
//  SubscriberView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2021/11/02.
//

import SwiftUI

struct SubscriberView: View {
    @StateObject private var viewModel = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Button("notify") { self.viewModel.notify() }
            
            Button("sinkSubscriber") { self.viewModel.sinkSubscriber() }
            
            Text("Assign: \(self.viewModel.assignInt)")
            Button("assignSubscriber") { self.viewModel.assignSubscriber() }
            
            Button("customSubscriber") { self.viewModel.customSubscriber() }
        }
    }
}

struct SubscriberView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriberView()
    }
}
