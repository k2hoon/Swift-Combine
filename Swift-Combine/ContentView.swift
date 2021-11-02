//
//  ContentView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2021/11/02.
//

import SwiftUI

struct ContentView: View {
    @State var isNavgateCombineTimer = false
    @State var isNavgateCombineSubscriber = false
    @State var isNavgateTest = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(isActive: $isNavgateCombineTimer) {
                    CombineTimerView()
                } label: {
                    Button(action: {
                        self.isNavgateCombineTimer.toggle()
                    }) {
                        Text("CombineTimerView")
                    }
                }
                
                NavigationLink(isActive: $isNavgateCombineSubscriber) {
                    CombineSubscriberView()
                } label: {
                    Button(action: {
                        self.isNavgateCombineSubscriber.toggle()
                    }) {
                        Text("CombineSubscriberView")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
