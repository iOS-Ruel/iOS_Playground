//
//  ContentView.swift
//  Albertos
//
//  Created by Jungman Bae on 7/10/24.
//

import SwiftUI

struct MenuList: View {
    @EnvironmentObject var orderController: OrderController
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        switch viewModel.sections {
        case .success(let sections):
            List {
                ForEach(sections) { section in
                    Section(header: Text(section.category)) {
                        ForEach(section.items) { item in
                            NavigationLink(value: item, label: {
                                MenuRow(viewModel: .init(item: item))
                            })
                        }
                    }
                }
            }
            .navigationTitle("Alberto's 🇮🇹")
            .navigationDestination(for: MenuItem.self) { selectedItem in
                MenuItemDetail(
                    viewModel: .init(item: selectedItem,
                                     orderController: orderController))
            }

        case .failure(let error):
            Text("An error occurred:")
            Text(error.localizedDescription).italic()
        }
    }
}

#Preview {
    NavigationStack {
        MenuList(viewModel: .init(menuFetching: MenuFetcher(networkFetching: URLSession.shared)))
    }
}
