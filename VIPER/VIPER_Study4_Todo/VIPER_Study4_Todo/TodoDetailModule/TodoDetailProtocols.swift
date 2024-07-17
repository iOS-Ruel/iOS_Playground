//
//  TodoDetailProtocols.swift
//  VIPER_Study4_Todo
//
//  Created by Chung Wussup on 7/17/24.
//

import UIKit

//Presenter <--> View
protocol TodoDetailViewProtocol: AnyObject {
    var presenter: TodoDetailPresenterProtocol? { get set }
    
    //presenter -> View
    func showToDo(_ todo: TodoItem)
}

protocol TodoDetailPresenterProtocol: AnyObject {
    var view: TodoDetailViewProtocol? { get set }
    var interactor: TodoDetailInteractorInputProtocol? { get set }
    var router: TodoDetailRouter? { get set }
    
    //View -> Presenter
    func viewDidLoad()
    func editTodo(title: String, content: String)
    func deleteTodo()
}


//Presenter <--> Interactor
protocol TodoDetailInteractorInputProtocol: AnyObject {
    var presenter: TodoDetailInteractorOutputProtocol? { get set }
    var todoItem: TodoItem? { get set }
   
    //Presenter -> Interactor
    func deleteTodo()
    func editTodo(title: String, content: String)
}

protocol TodoDetailInteractorOutputProtocol: AnyObject {
    
    // Interactor -> Presenter
    func didDeleteTodo()
    func didEditTodo(_ todo: TodoItem)
}



//Presenter <--> Router
protocol TodoDetailRouterProtocol: AnyObject {
    
    static func createTodoDetailRouterModule(with todo: TodoItem) -> UIViewController
    
    //Presenter -> Router
    func navigationBackToListViewController(from view: TodoDetailViewProtocol)
}
