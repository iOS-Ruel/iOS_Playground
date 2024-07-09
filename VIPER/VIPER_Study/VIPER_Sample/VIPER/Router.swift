//
//  Router.swift
//  VIPER_Sample
//
//  Created by Chung Wussup on 5/20/24.
//

import Foundation
import UIKit
//object
// Entry Point


typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    static func start() -> AnyRouter
}


class UserRouter: AnyRouter {

    var entry: EntryPoint?
    
    static func start() -> any AnyRouter {
        let router = UserRouter()
        
        var view: AnyView = UserViewController()
        var presenter: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
//        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
