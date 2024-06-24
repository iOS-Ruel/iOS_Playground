//
//  WordDetailView.swift
//  WordBrowser_Async
//
//  Created by Chung Wussup on 6/24/24.
//

import SwiftUI

struct WordDetailView: View {
    @StateObject var viewModel = WordDetailViewModel()
    @State var word: String
    
    var body: some View {
        ZStack {
            if viewModel.isSearching {
                ProgressView("Fetching...")
            } else {
                List {
                    Section("Definitions") {
                        ForEach(viewModel.definitions) { definition in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("(\(definition.partOfSpeech))")
                                        .font(.caption)
                                    Text(definition.definition)
                                }
                                Spacer()
                            }
                        }
                        .lineLimit(2)
                    }
                }
            }
        }
        .navigationTitle(word)
        .task  {
            await viewModel.excuteQuery(for: word)
        }
    }
}

#Preview {
    NavigationStack {
        WordDetailView(word: "Swift")
    }
}
