//
//  JournalListView.swift
//  JRNL_SwiftUI
//
//  Created by Chung Wussup on 5/28/24.
//

import SwiftUI
import SwiftData

struct JournalListView: View {
    @State private var searchText = ""
    @State private var isShowAddJournal = false
    @Query(sort: \JournalEntry.date) var journalEntries: [JournalEntry]

    var filterdJournalEntries: [JournalEntry] {
        if searchText.isEmpty {
            return journalEntries
        } else {
            return journalEntries.filter { $0.entryTitle.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filterdJournalEntries) { journal in
                NavigationLink(value: journal) {
                    JournalCell(journalEntry: journal)
                         .navigationDestination(for: JournalEntry.self) { journalEntries in
                             JournalEntryDetailView(journalEntry: journalEntries)
                         }
                }
               
            }
            .navigationTitle("Journal List")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isShowAddJournal = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowAddJournal) {
                AddJournalEntryView()
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer)
        }
        
    }
}

#Preview {
    JournalListView()
        .modelContainer(for: JournalEntry.self, inMemory: true)
}
