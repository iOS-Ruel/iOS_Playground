//
//  NoteViewModel.swift
//  Note_App
//
//  Created by Chung Wussup on 7/22/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth
class NoteViewModel: ObservableObject {
    @Published var notes = [Note]()
    
    @Published var selectedNote = Note()
    
    private lazy var databaseReference: CollectionReference? =  {
        guard let user = Auth.auth().currentUser?.uid else { return nil}
        let ref = Firestore.firestore().collection("Users").document(user).collection("Posts")
        return ref
    }()
    
    
    func addData(title: String) {
        let docRef = databaseReference?.addDocument(data: ["title": title])
        dump(docRef)
    }
    
    func fetchData() {
        databaseReference?.addSnapshotListener { querySnapshot, error in
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
        databaseReference?.document(id).updateData(["title": title]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteData(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let note = notes[index]
            databaseReference?.document(note.id ?? "").delete { error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("Note with ID \(note.id ?? "") deleted")
                }
            }
        }
    }
}
