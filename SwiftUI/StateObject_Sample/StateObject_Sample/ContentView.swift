//
//  ContentView.swift
//  StateObject_Sample
//
//  Created by Chung Wussup on 7/2/24.
//

import SwiftUI

class AnimalModel: ObservableObject {
    @Published var name: String = ""
    @Published var breed: String = ""
    @Published var age: Double = 0.0
    @Published var weight: Double = 0.0
}

struct ContentView: View {
    @StateObject var cat = AnimalModel()
    
    var body: some View {
        VStack {
            Text("Hello, \(cat.name)")
            Text("Hello, \(cat.breed)")
            Text("Hello, \(cat.age)")
            Text("Hello, \(cat.weight)")
            
            
            DisplayTextField(creature: cat)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
