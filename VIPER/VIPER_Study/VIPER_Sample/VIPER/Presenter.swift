//
//  Presenter.swift
//  VIPER_Sample
//
//  Created by Chung Wussup on 5/20/24.
//

import Foundation

//Object
//protocol
//ref to interactor , router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User], Error>)
    
}

class UserPresenter: AnyPresenter {
    
    
    var router: (any AnyRouter)?
    var interactor: (any AnyInteractor)? {
        didSet {
            interactor?.getUsers()
        }
    }
    var view: (any AnyView)?
    

    
    func interactorDidFetchUsers(with result: Result<[User], any Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: "Something went wrong")
        }
    }
    
}
