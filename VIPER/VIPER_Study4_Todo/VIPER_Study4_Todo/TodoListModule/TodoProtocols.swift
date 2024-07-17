//
//  TodoProtocols.swift
//  VIPER_Study4_Todo
//
//  Created by Chung Wussup on 7/17/24.
//

import UIKit


protocol TodoListViewProtocol: AnyObject {
    var preseter: TodoListPresenterProtocol { get set }
    
    //Presenter -> View
    func showTodos(_ todos: [TodoItem])
    func showErrorMessage(_ message: String)
}


protocol TodoListPresenterProtocol: AnyObject {
    var view: TodoListViewProtocol? { get set }
    var interactor: TodoListInteractorInputProtocol? { get set }
    var router: TodoListRouterProtocol? { get set }
    
    //View -> Presenter
    func viewWillAppear()
    func showTodoDetail(_ todo: TodoItem)
    func addTodo(_ todo: TodoItem)
    func removeTodo(_ todo: TodoItem)
}


protocol TodoListInteractorInputProtocol: AnyObject {
    var presenter: TodoListInteractorInputProtocol? { get set }
    
    
    //Presenter -> Interactor
    func retrieveTodos()
    func saveTodo(_ todo: TodoItem)
    func deleteTodo(_ todo: TodoItem)
}

protocol TodoListInteractorOutputProtocol: AnyObject {
    // Interactor -> Presenter
    func didAddTodo(_ todo: TodoItem)
    func didRemoveTodo(_ todo: TodoItem)
    func didRetrieveTodos(_ todos: [TodoItem])
    func onError(message: String)
}


protocol TodoListRouterProtocol: AnyObject {
    static func createTodoListModule() -> UIViewController
    
    //Presenter -> Router
    func presentTodoDetailScreen(from view: TodoListViewProtocol, for todo: TodoItem)
}
