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
                    NavigationLink(destination: WordDetailView(word: word)) {
                        Text(word)
                        
                    }
                }
            }
        }
    }
}


struct ContentView: View {
    @StateObject var viewModel = LibraryViewModel()
    @State var isAddNewWordDialogPresented = false
    
    var body: some View {
        List {
            SectionView("Random Words", words: [viewModel.randomWord])
            SectionView("Peter's Tips", words: viewModel.filteredTips)
            SectionView("My favorite", words: viewModel.filteredFavorites)
        }
        .searchable(text: $viewModel.searchText)
        .textInputAutocapitalization(.never)
        .navigationTitle("Libary")
        .refreshable {
            
            print("\(#function) is on main thread Before await: \(Thread.isMainThread)")
            await viewModel.refresh()
            print("\(#function) is on main thread After await: \(Thread.isMainThread)")
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(action: {
                    isAddNewWordDialogPresented.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddNewWordDialogPresented) {
            NavigationStack {
                AddWordView { word in
                    print(word)
                    viewModel.addFavorite(word)
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
