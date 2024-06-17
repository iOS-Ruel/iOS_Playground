//
//  BookRowView.swift
//  BookShelf
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

struct BookRowView: View {
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

#Preview {
    BookRowView(book: Book(title: "SwiftUI for Absolute Beginners", author: "Jayant Varma",
                           isbn: "9781484255155", pages: 200))
}
