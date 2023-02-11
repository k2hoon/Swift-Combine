//
//  CombineSubscriberView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2021/11/02.
//

import SwiftUI

struct CombineSubscriberView: View {
    @StateObject var viewModel = CombineSubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button(action: { self.viewModel.sinkSubscriber()}) {
                Text("sinkSubscriber")
            }
            
            Button(action: { self.viewModel.assignSubscriber() }) {
                Text("assignSubscriber")
            }
            
            Button(action: { self.viewModel.customSubscriber() }) {
                Text("customSubscriber")
            }
        }
    }
}

struct CombineSubscriberView_Previews: PreviewProvider {
    static var previews: some View {
        CombineSubscriberView()
    }
}
