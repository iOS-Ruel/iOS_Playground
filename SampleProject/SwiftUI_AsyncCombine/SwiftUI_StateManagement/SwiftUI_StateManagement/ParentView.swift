//
//  ContentView.swift
//  SwiftUI_StateManagement
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

struct ParentView: View {
    @State var favouriteNumber: Int = 0
    
    var body: some View {
        VStack {
          Text("Your favourite number is \(favouriteNumber)")
            ChildView(number: $favouriteNumber)
        }
        .padding()
    }
}

struct ChildView: View {
    @Binding var number: Int
    var body: some View {
        Stepper("\(number)", value: $number, in: 0...100)
    }
}

#Preview {
    ParentView()
}



