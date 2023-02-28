//
//  ContentView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2021/11/02.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented = false
    
    var fullCover: AnyView? = nil
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ViewType.allCases, id: \.self) { view in
                    NavigationLink(view.rawValue) {
                        view.viewBuilder()
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

extension ContentView {
    enum ViewType: String, CaseIterable {
        case published = "Published test"
        case observable = "ObservableObject test"
        case timer = "CombineTimerView"
        case subscriber = "Subscriber"
        case just = "Just publisher"
        case future = "Future publisher"
        case deferred = "Deferred publisher"
        case empty = "Empty publisher"
        case fail = "Fail publisher"
        case record = "Record publisher"
        case delay = "Delay publisher"
        case timeout = "Timeout publisher"
        case debounce = "Deboune publisher"
        case throttle = "Throttle publisher"
        case measureInterval = "MeasureInterval publisher"
        
        @ViewBuilder func viewBuilder() -> some View {
            switch self {
            case .published: PublishedTestView()
            case .observable: ObservableObjectTestView()
            case .subscriber: SubscriberView()
            case .timer: CombineTimerView()
            case .just: JustTestView()
            case .future: FutureTestView()
            case .deferred: DeferredTestView()
            case .empty: EmptyTestView()
            case .fail: FailTestView()
            case .record: RecordTestView()
            case .delay: DelayView()
            case .timeout: TimeoutView()
            case .debounce: DebounceView()
            case .throttle: ThrottleView()
            case .measureInterval: MeasureIntervalView()
            }
        }
    }
}
