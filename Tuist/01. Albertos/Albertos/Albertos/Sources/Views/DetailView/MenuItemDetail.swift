//
//  MenuItemDetail.swift
//  Albertos
//
//  Created by Jungman Bae on 7/12/24.
//

import SwiftUI

struct MenuItemDetail: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(viewModel.name)
                .fontWeight(.bold)
            
            if let spicy = viewModel.spicy {
                Text(spicy)
                    .font(Font.body.italic())
            }
            
            Text(viewModel.price)
            
            Button(viewModel.addOrRemoveFromOrderButtonText) {
                viewModel.addOrRemoveFromOrder()
            }
        }
    }
}
