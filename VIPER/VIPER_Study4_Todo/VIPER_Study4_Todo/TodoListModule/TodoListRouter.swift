//
//  TodoListRouter.swift
//  VIPER_Study4_Todo
//
//  Created by Chung Wussup on 7/17/24.
//

import UIKit

class TodoListRouter: TodoListRouterProtocol {
    
    static func createTodoListModule() -> UIViewController {
        let todoListViewController = TodoListViewController()
        let navController = UINavigationController(rootViewController: todoListViewController)
        let presenter: TodoListPresenterProtocol & TodoListInteractorOutputProtocol = TodoListPresenter()
        let interactor: TodoListInteractorInputProtocol = TodoListInteractor()
        let router = TodoListRouter()
        
        todoListViewController.presenter = presenter
        presenter.view = todoListViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return navController
        
    }
    
    func presentTodoDetailScreen(from view: any TodoListViewProtocol, for todo: TodoItem) {        
        let detailVC = TodoDetailRouter.createTodoDetailRouterModule(with: todo)
        
        guard let view = view as? UIViewController else {
            fatalError("Invalid View Protocol Type")
        }
        
        view.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
