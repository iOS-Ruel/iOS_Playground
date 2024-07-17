//
//  TodoDetailInteractor.swift
//  VIPER_Study4_Todo
//
//  Created by Chung Wussup on 7/17/24.
//

import Foundation

class TodoDetailInteractor: TodoDetailInteractorInputProtocol {
    weak var presenter: TodoDetailInteractorOutputProtocol?
    var todoItem: TodoItem?
    var todoStore = TodoStore.shared
    
    func deleteTodo() {
        guard let todoItem = todoItem else { return }
        todoStore.removeTodo(todoItem)
        presenter?.didDeleteTodo()
    }
    
    func editTodo(title: String, content: String) {
        guard let todoItem = todoItem else { return }
        todoItem.title = title
        todoItem.content = content
        
        presenter?.didEditTodo(todoItem)
    }
    
}
