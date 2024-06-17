//
//  EnviromentObjectView.swift
//  SwiftUI_StateManagement
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

class UserProfile: ObservableObject {
    @Published var name: String
    @Published var favouriteProgrammingLanguage: String
    @Published var favouriteColor: Color
    
    init(name: String, favouriteProgrammingLanguage: String, favouriteColor: Color) {
        self.name = name
        self.favouriteProgrammingLanguage = favouriteProgrammingLanguage
        self.favouriteColor = favouriteColor
    }
}

struct EnviromentObjectView: View {
    @StateObject var profile = UserProfile(name: "Peter", 
                                           favouriteProgrammingLanguage: "Swift",
                                           favouriteColor: .purple)
    @State var isSettingShown = false
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    EnviromentObjectView()
}
