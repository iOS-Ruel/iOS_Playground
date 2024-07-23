//
//  PostViewModel.swift
//  Socially
//
//  Created by Chung Wussup on 7/23/24.
//

import Combine
import FirebaseFirestore

class PostViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    private var databaseReference = Firestore.firestore().collection("Posts")
    
}
