//
//  ContentView.swift
//  Pseudolanguage_Sample
//
//  Created by Chung Wussup on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
                .background(Color.yellow)
            
            
            Text("This is a lot of text to display in a small amount of space to test how well Xcode can truncate large amounts of text.")
                .padding()
                .lineLimit(2)
                .background(Color.mint)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
