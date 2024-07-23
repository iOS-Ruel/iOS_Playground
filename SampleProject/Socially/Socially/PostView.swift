//
//  ContentView.swift
//  Socially
//
//  Created by Chung Wussup on 7/23/24.
//

import SwiftUI

struct PostView: View {
    @EnvironmentObject private var viewMoel: PostViewModel

    @State private var description = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Description", text: $description)
                }
                
                Section {
                    Button(action: {
                        
                        Task {
                            await self.viewMoel.addData(description:  description,datePublished: Date())
                        }
                        
                    }, label: {
                        Text("Post")
                    })
                }
            }
        }
    }
}

#Preview {
    PostView()
        .environmentObject(PostViewModel())
}
