//
//  UserProfileScreen.swift
//  SwiftUI_StateManagement
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

struct UserProfileScreen: View {
    @EnvironmentObject var profile: UserProfile
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Form{
                Section(header: Text("User Profile")) {
                    TextField("name", text: $profile.name)
                    TextField("Favorite Programming Language", text: $profile.favouriteProgrammingLanguage)
                    ColorPicker("Favorite Color", selection: $profile.favouriteColor)
                }
            }
        }
        .navigationTitle("User Profile")
    }
}

#Preview {
    NavigationStack {
        UserProfileScreen()
    }
    .environmentObject(UserProfile(name: "Peter", favouriteProgrammingLanguage: "Swift", favouriteColor: .pink))
}
