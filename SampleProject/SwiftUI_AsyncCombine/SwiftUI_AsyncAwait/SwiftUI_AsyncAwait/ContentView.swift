//
//  ContentView.swift
//  SwiftUI_AsyncAwait
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        List {
            CustomRowView(title: "Apples", subTitle:"Eat one a day")
            CustomRowView(title: "Bananas", subTitle:"High in potassium")
        }
        
    }
}

#Preview {
    ContentView()
}

struct CustomRowView: View {
    var title: String
    var subTitle: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subTitle)
                    .font(.subheadline)
            }
        }
        
    }
}
