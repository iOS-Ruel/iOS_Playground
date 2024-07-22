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
}
