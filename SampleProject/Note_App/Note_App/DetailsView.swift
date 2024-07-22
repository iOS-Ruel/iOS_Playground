//
//  DetailsView.swift
//  Note_App
//
//  Created by Chung Wussup on 7/22/24.
//

import SwiftUI

struct DetailsView: View {
    var note: Note
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text(note.title ?? "")
                        .font(.system(size: 22, weight: .regular))
                        .padding()
                    Spacer()
                }
            }
            .navigationTitle("Details")
        }
    }
}

#Preview {
    DetailsView(note: Note(title: "안니영"))
}
