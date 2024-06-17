//
//  ContentView.swift
//  SwiftUI_SimpleView
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    
    var body: some View {
        List {
            Label("Hello World", systemImage: "globe")
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(Color.accentColor)
                Text("Hellow World")
            }
            .font(.system(.body, design: .monospaced))
            
            TextField("TextField", text: $text)
            
            Button("Tap Me") {
                self.text = "You tapped Me!"
            }
            
        }
    }
}

#Preview {
    ContentView()
}
