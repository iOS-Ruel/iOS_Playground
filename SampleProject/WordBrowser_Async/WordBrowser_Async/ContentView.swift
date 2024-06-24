//
//  ContentView.swift
//  WordBrowser_Async
//
//  Created by Chung Wussup on 6/24/24.
//

import SwiftUI

struct SectionView: View {
    var title: String
    var words: [String]
    
    init(_ title: String, words: [String]) {
        self.title = title
        self.words = words
    }
    
    var body: some View {
        Section(title) {
            if words.isEmpty {
                Text("(No items match your filter criteria)")
            } else {
                ForEach(words, id: \.self) { word in
                    Text(word)
                }
            }
        }
    }
}


struct ContentView: View {
    @StateObject var viewModel = LibraryViewModel()
    
    var body: some View {
        List {
            SectionView("Random Words", words: [viewModel.randomWord])
            SectionView("Peter's Tops", words: viewModel.filteredTips)
            SectionView("My favorite", words: viewModel.filteredFavorites)
        }
        .searchable(text: $viewModel.searchText)
        .textInputAutocapitalization(.never)
        .navigationTitle("Libary")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {}) {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView()
    }
}
