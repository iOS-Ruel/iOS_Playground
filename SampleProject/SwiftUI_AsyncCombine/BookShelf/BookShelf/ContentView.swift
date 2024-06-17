//
//  ContentView.swift
//  BookShelf
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

struct ContentView: View {
    var books : [Book] = Book.sampleBooks
    
    var body: some View {
        
        List(books, id: \.isbn) { book in
            BookRowView(book: book)
        }
        .listStyle(.plain)
    }
}


//(traits: .sizeThatFitsLayout) : Selectable View에만 동작함
#Preview(traits: .sizeThatFitsLayout) {
    ContentView()
}
