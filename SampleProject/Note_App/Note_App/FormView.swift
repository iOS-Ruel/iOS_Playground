//
//  FormView.swift
//  Note_App
//
//  Created by Chung Wussup on 7/22/24.
//

import SwiftUI

struct FormView: View {
    @Environment(\.dismiss) var dismiss
    @State var titleText = ""
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextEditor(text: $titleText)
                        .frame(minHeight: 200)
                }
                
                Section {
                    Button(action: {
                        
                    }, label: {
                        Text("Save now")
                    })
                    .disabled(titleText.isEmpty)
                    .foregroundStyle(.yellow)
                }
            }
            .navigationTitle("Publish")
            .toolbar {
                ToolbarItemGroup(placement: .destructiveAction) {
                    Button("Cancel"){
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    FormView()
}
