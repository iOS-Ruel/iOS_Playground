//
//  ListView2.swift
//  SwiftUI_ListView
//
//  Created by Chung Wussup on 6/17/24.
//

import SwiftUI

struct ListView2: View {
    var body: some View {
        
        List {
            CustomRowView(title: "Apples", subTitle:"Eat one a day")
            CustomRowView(title: "Bananas", subTitle:"High in potassium")
        }
        
    }
}

#Preview {
    ListView2()
}

struct CustomRowView: View {
    var title: String
    var subTitle: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subTitle)
                    .font(.subheadline)
            }
        }
        
    }
}
