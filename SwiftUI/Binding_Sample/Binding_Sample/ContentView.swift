//
//  ContentView.swift
//  Binding_Sample
//
//  Created by Chung Wussup on 7/2/24.
//

import SwiftUI

struct ContentView: View {
    @State private var message = ""
    
    var body: some View {
        VStack {
            Text("Hello, \(message)")
            DisplayTextFieldView(newVariable: $message)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

