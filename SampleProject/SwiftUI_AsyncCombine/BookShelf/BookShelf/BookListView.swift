//
//  ContentView.swift
//  BookShelf
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

class BooksViewModel: ObservableObject {
    @Published var books: [Book] = Book.sampleBooks
}

struct BookListView: View {
    
    @StateObject var booksViewModel = BooksViewModel()
    
    var body: some View {
        NavigationStack {
            List($booksViewModel.books) { $book in
                NavigationLink(destination: BookDetailView(book: $book)) {
                    BookRowView(book: book)
                }
                
            }
            .listStyle(.plain)
            .navigationTitle("Books")
        }
    }
}


//(traits: .sizeThatFitsLayout) : Selectable View에만 동작함
#Preview(traits: .sizeThatFitsLayout) {
    BookListView()
}
