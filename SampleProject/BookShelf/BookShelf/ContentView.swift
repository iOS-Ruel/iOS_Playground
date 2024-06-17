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
            BookRow(book: book)
        }
        .listStyle(.plain)
        
       
    }
}

struct BookRow: View {
    var book: Book
    
    var body: some View {
        HStack(alignment: .top){
            Image(book.mediumCoverImageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 90)
            
            VStack(alignment: .leading) {
                Text(book.title)
                    .font(.headline)
                Text("by \(book.author)")
                    .font(.subheadline)
                Text("\(book.pages) pages")
                    .font(.subheadline)
            }
            Spacer()
        }
    }
}

//(traits: .sizeThatFitsLayout) : Selectable View에만 동작함
#Preview(traits: .sizeThatFitsLayout) {
    ContentView()
}
