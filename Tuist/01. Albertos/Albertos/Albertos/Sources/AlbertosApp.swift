//
//  AlbertosApp.swift
//  Albertos
//
//  Created by Jungman Bae on 7/10/24.
//

import SwiftUI

@main
struct AlbertosApp: App {
    let orderController = OrderController()
    let paymentProcessor = PaymentProcessingProxy()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MenuList(viewModel: .init(menuFetching: MenuFetcher(networkFetching: URLSession.shared)))
            }
            OrderButton(viewModel: OrderButton.ViewModel(orderController: orderController))
                .padding(6)
        }
        .environmentObject(orderController)
        .environmentObject(paymentProcessor)
    }
}
