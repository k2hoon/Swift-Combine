//
//  CombineTimerView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2021/11/02.
//

import SwiftUI

struct CombineTimerView: View {
    @State private var count = 0
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onReceive(timer) { time in
                    if self.count == 5 {
                        self.timer.upstream.connect().cancel()
                    } else {
                        self.count += 1
                    }   
                }
            Text("Counter: \(self.count)")
        }
    }
}

struct CombineTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CombineTimerView()
    }
}
