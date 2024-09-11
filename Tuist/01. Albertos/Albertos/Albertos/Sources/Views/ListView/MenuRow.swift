//
//  MenuRow.swift
//  Albertos
//
//  Created by Jungman Bae on 7/11/24.
//

import SwiftUI

struct MenuRow: View {
    let viewModel: ViewModel
    
    var body: some View {
        Text(viewModel.text)
    }
}
