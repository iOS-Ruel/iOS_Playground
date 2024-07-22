//
//  NoteViewModel.swift
//  Note_App
//
//  Created by Chung Wussup on 7/22/24.
//

import Foundation
import FirebaseFirestore

class NoteViewModel: ObservableObject {
    @Published var notes = [Note]()
    
    private var databaseReference = Firestore.firestore().collection("Notes")
    
    
    func addData(title: String) {
        let docRef = databaseReference.addDocument(data: ["title": title])
        dump(docRef)
    }
    
    func fetchData() {
        databaseReference.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {
                print("No Documents")
                return
            }
            
            self.notes = documents.compactMap { docSnap -> Note? in
                return try? docSnap.data(as: Note.self) 
            }
        }
    }
    
    func updateData(title: String, id: String) {
        databaseReference.document(id).updateData(["title": title]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
            
        }
        
    }
}
