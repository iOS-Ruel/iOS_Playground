//
//  ContentView.swift
//  SwiftUI_StateManagement
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

class  Counter: ObservableObject {
    @Published var count: Int = 0
    
}


struct StateStepper: View {
//    @StateObject var stateCounter = Counter()
    @ObservedObject var stateCounter = Counter()
    
    var body: some View {
        Section(header: Text("@StateObject")) {
            Stepper("counter: \(stateCounter.count)", value: $stateCounter.count)
        }
    }
}

struct ContentView: View {
    @State var color: Color = Color.accentColor
    
    
    var body: some View {
        VStack(alignment: .leading) {
            StateStepper()
            ColorPicker("Pick a color", selection: $color)
        }
        .foregroundStyle(color)
    }
}

#Preview {
    ContentView()
}
