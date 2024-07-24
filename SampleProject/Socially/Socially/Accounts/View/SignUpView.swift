//
//  SignUpView.swift
//  Socially
//
//  Created by Chung Wussup on 7/23/24.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth
import FirebaseFirestore
import FirebaseAnalyticsSwift

struct SignUpView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    
    
    var body: some View {
        VStack {
            SignInWithAppleButton(onRequest:
                authModel.signInWithAppleRequest(request:),
            onCompletion:
                authModel.signInWithAppleCompletion(result:)
            )
            .signInWithAppleButtonStyle(.black)
            .frame(width: 290, height: 45, alignment: .center)
        }
        .analyticsScreen(name: "SignUpView")
    }
}

#Preview {
    SignUpView()
}
