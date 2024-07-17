//
//  TodoDetailPresenter.swift
//  VIPER_Study4_Todo
//
//  Created by Chung Wussup on 7/17/24.
//

import Foundation

class TodoDetailPresenter: TodoDetailPresenterProtocol {
    weak var view: TodoDetailViewProtocol?
    var interactor: TodoDetailInteractorInputProtocol?
    var router: TodoDetailRouterProtocol?
    
    func viewDidLoad() {
        if let todoItem = interactor?.todoItem {
            view?.showToDo(todoItem)
        }
    }
    
    func editTodo(title: String, content: String) {
        interactor?.editTodo(title: title, content: content)
    }
    
    func deleteTodo() {
        interactor?.deleteTodo()
    }
    
    
}

extension TodoDetailPresenter: TodoDetailInteractorOutputProtocol {
    func didDeleteTodo() {
        if let view = view {
            router?.navigationBackToListViewController(from: view)
        }
    }
    
    func didEditTodo(_ todo: TodoItem) {
        view?.showToDo(todo)
    }
    
    
}
