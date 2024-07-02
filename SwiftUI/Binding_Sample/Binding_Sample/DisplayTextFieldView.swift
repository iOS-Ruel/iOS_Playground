//
//  DisplayTextFieldView.swift
//  Binding_Sample
//
//  Created by Chung Wussup on 7/2/24.
//

import SwiftUI

struct DisplayTextFieldView: View {
    @Binding var newVariable: String
    
    var body: some View {
        HStack {
            Text("Send a greating: ")
            TextField("Type ad message here", text: $newVariable)
        }
    }
}

#Preview {
    DisplayTextFieldView(newVariable: .constant("Ruel"))
}
