//
//  ContentView.swift
//  SwiftUI_ListView
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List{
            Text("Hello, World!")
            Text("Hello, SwifTUI")
        }
        .listStyle(.plain)
    }
}

#Preview {
    ContentView()
}
