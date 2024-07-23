//
//  HolderView.swift
//  Note_App
//
//  Created by Chung Wussup on 7/23/24.
//

import SwiftUI

struct HolderView: View {
    @EnvironmentObject private var authModel: AuthViewModel
    var body: some View {
        Group {
            if authModel.user == nil {
                SignUpView()
            } else {
                ContentView()
            }
        }
        .onAppear {
            authModel.listenToAuthState()
        }
    }
}

#Preview {
    HolderView()
        .environmentObject(AuthViewModel())
}
