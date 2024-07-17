//
//  TodoListInteractor.swift
//  VIPER_Study4_Todo
//
//  Created by Chung Wussup on 7/17/24.
//

import Foundation

class TodoListInteractor: TodoListInteractorInputProtocol {
    weak var presenter: TodoListInteractorOutputProtocol?
    var todoStore = TodoStore.shared
    var todos: [TodoItem] {
        return todoStore.todos
    }
    
    func retrieveTodos() {
        presenter?.didRetrieveTodos(todos)
    }
    
    func saveTodo(_ todo: TodoItem) {
        todoStore.addTodo(todo)
        presenter?.didAddTodo(todo)
    }
    
    func deleteTodo(_ todo: TodoItem) {
        todoStore.removeTodo(todo)
        presenter?.didRemoveTodo(todo)
    }
}
