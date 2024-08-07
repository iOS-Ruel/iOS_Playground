//
//  FeedView.swift
//  Socially
//
//  Created by Chung Wussup on 7/23/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseAnalyticsSwift

struct FeedView: View {
    @FirestoreQuery(
            collectionPath: "Posts",
            predicates: [.order(by: "datePublished", descending: true)]
        ) var posts: [Post]
    
    @EnvironmentObject private var authModel: AuthViewModel
    
    @State var showingPost = false
    
    var body: some View {
        NavigationStack {
            List(posts) { post in
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: post.imageURL ?? "")) { phase in
                        switch phase {
                        case .empty:
                            EmptyView()
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 300, height: 200)
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(post.description ?? "")
                            .font(.headline)
                            .padding([.bottom, .top], 6)
                        Text("Published on the \(post.datePublished?.formatted() ?? "")")
                            .font(.caption)
                    }
                }
                .frame(minHeight: 100, maxHeight: 350)
            }
            .navigationTitle("Feed")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        authModel.signOut()
                    } label: {
                        Text("Sign out")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                         showingPost = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }
            .sheet(isPresented: $showingPost) {
                PostView()
                    .presentationDetents([.medium, .large])
            }
            
        }
        .analyticsScreen(name: "FeedView")
        
    }
}

#Preview {
    FeedView()
        .environmentObject(PostViewModel())
}
