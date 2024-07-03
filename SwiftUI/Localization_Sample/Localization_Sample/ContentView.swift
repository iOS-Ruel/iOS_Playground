//
//  ContentView.swift
//  Localization_Sample
//
//  Created by Chung Wussup on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @State var changeColor = false
    @State var message = ""
    
    var placeHolder: LocalizedStringKey = "placeholder-label"
    
    let date = Date()
    //DateFormatter는 local을 알아서 정해줌
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey("greeting-label \(message)"))
            Text("greeting-label \(message)")
            Button("button-label") {
                changeColor.toggle()
            }
            
            TextField(placeHolder, text: $message)
            Text(date, formatter: dateFormatter)
        }
        .padding()
        .background(changeColor ? Color.red : Color.yellow)
    }
}

#Preview("기본 - 한국어") {
    ContentView()
}

#Preview("English") {
    ContentView()
        .environment(\.locale, .init(identifier: "en"))
}
#Preview("French") {
    ContentView()
        .environment(\.locale, .init(identifier: "fr"))
}
#Preview("Spenish") {
    ContentView()
        .environment(\.locale, .init(identifier: "es"))
}
