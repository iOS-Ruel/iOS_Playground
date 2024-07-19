//
//  RatingView.swift
//  JRNL_SwiftUI
//
//  Created by Chung Wussup on 5/29/24.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(0..<5) { index in
                Image(systemName: index < rating ? "star.fill" : "star")
                    .onTapGesture {
                        rating = index + 1
                    }
                
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

