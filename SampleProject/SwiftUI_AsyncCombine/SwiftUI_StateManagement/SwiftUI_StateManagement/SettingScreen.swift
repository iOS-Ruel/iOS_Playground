//
//  SettingScreen.swift
//  SwiftUI_StateManagement
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

struct SettingScreen: View {
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Setting")) {
                    NavigationLink(destination: UserProfileScreen()) {
                        Text("User Profile")
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingScreen()
    }
}
