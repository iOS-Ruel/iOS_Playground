//
//  OrderDetailViewModelTests.swift
//  AlbertosTests
//
//  Created by Jungman Bae on 7/12/24.
//

import XCTest

@testable import Albertos

final class OrderDetailViewModelTests: XCTestCase {
    
    func testCheckoutButtonTappedStartsPaymentProcessingFlow() {
        // Arrange
        let orderController = OrderController()
        orderController.addToOrder(item: .fixture(name: "name", price: 1.0))
        orderController.addToOrder(item: .fixture(name: "other name", price: 2.0))
        
        let paymentProcessingSpy = PaymentProcessingSpy()
        let viewModel = OrderDetail.ViewModel(
            orderController: orderController,
            paymentProcessor: paymentProcessingSpy, onAlertDismiss: {})
        viewModel.checkout()
        XCTAssertEqual(paymentProcessingSpy.receivedOrder, orderController.order)
    }

    func testWhenPaymentFailsUpdatesPropertyToShowErrorAlertThatCallsDismissCallback() {
        var called = false
        let viewModel = OrderDetail.ViewModel(
            orderController: OrderController(),
            paymentProcessor: PaymentProcessingStub(returning: .failure(TestError(id: 123))),
            onAlertDismiss: { called = true }
        )

        let predicate = NSPredicate { _, _ in viewModel.alertToShow != nil }
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: .none)

        viewModel.checkout()

        wait(for: [expectation], timeout: timeoutForPredicateExpectations)

        XCTAssertEqual(viewModel.alertToShow?.title, "")
        XCTAssertEqual(
            viewModel.alertToShow?.message,
            "There's been an error with your order. Please contact a waiter."
        )
        XCTAssertEqual(viewModel.alertToShow?.buttonText, "Ok")

        viewModel.alertToShow?.buttonAction?()
        XCTAssertTrue(called)
    }

}
