//
//  PostViewModel.swift
//  Socially
//
//  Created by Chung Wussup on 7/23/24.
//

import Combine
import FirebaseFirestore
import FirebaseStorage

class PostViewModel: ObservableObject {
    @Published var posts = [Post]()
    
    private var databaseReference = Firestore.firestore().collection("Posts")
    let storageReference = Storage.storage().reference().child("\(UUID().uuidString)")
    
    
    func addData(description: String, datePublished: Date, data: Data, completion: @escaping (Error?) -> Void) {
        
        storageReference.putData(data, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                completion(error)
                return
            }
            
            self.storageReference.downloadURL { url, error in
                guard let downloadUrl = url else {
                    completion(error)
                    return
                }
                
                self.databaseReference.addDocument(data: [
                    "description": description,
                    "datePublished": datePublished,
                    "imageUrl": downloadUrl.absoluteString
                ]) { error in
                    completion(error)
                }
                
                
            }
        }
    }
    
}
