//
//  ContentView.swift
//  SignUpForm+Combine
//
//  Created by Chung Wussup on 6/18/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = SignUpFormViewModel()
    
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $viewModel.username)
                    .textInputAutocapitalization(.none)
                    .autocorrectionDisabled()
            } footer: {
                Text(viewModel.usernameMessage)
                    .foregroundStyle(Color.red)
            }
            
            Section {
                SecureField("Password", text: $viewModel.password)
                SecureField("Repeat password", text: $viewModel.passwordConfirmation)
            } footer: {
                Text(viewModel.passwordMessage)
                    .foregroundStyle(Color.red)
            }
            
            Section {
                Button("Sign up") {
                    print("Signing up as \(viewModel.username)")
                }
                .disabled(!viewModel.isValid)
            }
            
        }
    }
}

#Preview {
    ContentView()
}
