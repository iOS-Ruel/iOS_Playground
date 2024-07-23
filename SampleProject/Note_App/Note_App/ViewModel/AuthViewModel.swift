//
//  AuthViewModel.swift
//  Note_App
//
//  Created by Chung Wussup on 7/23/24.
//

import SwiftUI
import FirebaseAuth
import Firebase

final class AuthViewModel: ObservableObject {
    @Published var user: User?
    
    func listenToAuthState() {
        Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else {
                return
            }
            
            self.user = user 
            
        }
    }
    
    func signIn(emailAddress: String, password: String) {
        Auth.auth().signIn(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            }
        }
    }
    
    func signUp(emailAddress: String, password: String) {
        Auth.auth().createUser(withEmail: emailAddress, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                return
            } else {
            
                guard let uid = result?.user.uid else {
                    return
                }
                
                Firestore.firestore().collection("Users").document(uid).setData(["email": emailAddress, "uid": uid]) { err in
                    if let err = err {
                        return
                    }
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError.localizedDescription)
        }
    }
    
    func resetPassword(emailAddress: String) {
        Auth.auth().sendPasswordReset(withEmail: emailAddress) { error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            }
            
        }
    }
}
