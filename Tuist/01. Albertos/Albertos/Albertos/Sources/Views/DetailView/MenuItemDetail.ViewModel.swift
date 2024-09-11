//
//  MenuItemDetailViewModel.swift
//  Albertos
//
//  Created by Jungman Bae on 7/12/24.
//
import Combine

extension MenuItemDetail {
    class ViewModel: ObservableObject {
        @Published private(set) var addOrRemoveFromOrderButtonText = "Remove from order"
        
        private let item: MenuItem
        private let orderController: OrderController
        
        private var cancellables = Set<AnyCancellable>()
        
        var name: String {
            item.name
        }
        
        var spicy: String? {
            item.spicy ? " 🌶" : nil
        }
        
        var price: String {
            "$\(String(format: "%.2f", item.price))"
        }
        
        init(item: MenuItem, orderController: OrderController) {
            self.item = item
            self.orderController = orderController
            
            self.orderController.$order
                .sink { [weak self] order in
                    if (order.items.contains { $0 == self?.item }){
                        self?.addOrRemoveFromOrderButtonText = "Remove from order"
                    } else {
                        self?.addOrRemoveFromOrderButtonText = "Add to order"
                    }
                }
                .store(in: &cancellables)
        }
        
        func addOrRemoveFromOrder() {
            if (orderController.order.items.contains { $0 == item }) {
                orderController.removeFromOrder(item: item)
            } else {
                orderController.addToOrder(item: item)
            }
        }
    }
}
