//
//  ObservableObjectTestView.swift
//  Swift-Combine
//
//  Created by k2hoon on 2023/02/11.
//

import SwiftUI
import Combine

struct ObservableObjectTestView: View {
    @StateObject private var person = Person(name: "Kevin", age: 24)
    @StateObject private var manual = ManualViewModel()
    
    @State private var cancellable: AnyCancellable? = nil
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            // Publish
            VStack {
                Text("Publish")
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                
                Text("Input name")
                    .font(.subheadline).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    TextField("Enter your name", text: $name)
                        .textFieldStyle(.roundedBorder)
                    
                    Button("Change name") {
                        self.person.changeName(name: self.name)
                        self.name = ""
                    }
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("name: \(self.person.name)")
                        Text("age: \(self.person.age)")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button("Increase age") {
                        let age = self.person.haveBirthday()
                        print("\(age) has returned")
                    }
                }
                
                Divider()
            }
            .onAppear {
                self.subscribePerson()
            }
            
            // Manually
            VStack {
                Text("Manually publish")
                    .font(.title3).bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                
                Text("test value: \(self.manual.textValue)")
                Button("Change text value") {
                    self.manual.setTextValue(value: "Changed")
                }
                
            }
        }
        .padding()
    }
    
    func subscribePerson() {
        self.cancellable = self.person.objectWillChange
            .sink { _ in
                print("\(self.person.name) will change")
                print("\(self.person.age) will change")
            }
    }
}

struct ObservableObjectTestView_Previews: PreviewProvider {
    static var previews: some View {
        ObservableObjectTestView()
    }
}

extension ObservableObjectTestView {
    class Person: ObservableObject {
        @Published var name: String
        @Published var age: Int {
            willSet {
                print ("age willSet: \(newValue)")
            }
        }
        
        init(name: String, age: Int) {
            self.name = name
            self.age = age
        }
        
        func changeName(name: String) {
            self.name = name
        }
        
        func haveBirthday() -> Int {
            age += 1
            return age
        }
    }
    
    class ManualViewModel: ObservableObject {
        var textValue = "hello" {
            willSet {
                self.objectWillChange.send()
            }
        }
        
        func setTextValue(value: String) {
            self.textValue = value
        }
    }
}
