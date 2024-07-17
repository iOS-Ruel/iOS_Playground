//
//  TodoDetailRouter.swift
//  VIPER_Study4_Todo
//
//  Created by Chung Wussup on 7/17/24.
//

import UIKit

class TodoDetailRouter: TodoDetailRouterProtocol {
    static func createTodoDetailRouterModule(with todo: TodoItem) -> UIViewController {
        let detailVC = TodoDetailViewController()
        
        let presenter: TodoDetailPresenter & TodoDetailInteractorOutputProtocol = TodoDetailPresenter()
        detailVC.presenter = presenter
        presenter.view = detailVC

        let interactor: TodoDetailInteractorInputProtocol = TodoDetailInteractor()
        interactor.todoItem = todo
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router: TodoDetailRouterProtocol = TodoDetailRouter()
        presenter.router = router
        
        
        return detailVC
    }
    
    func navigationBackToListViewController(from view: any TodoDetailViewProtocol) {
        guard let viewVC = view as? UIViewController else {
            fatalError("Invalid view protocol type")
        }
        
        viewVC.navigationController?.popViewController(animated: true)
        
    }
    
    
}
