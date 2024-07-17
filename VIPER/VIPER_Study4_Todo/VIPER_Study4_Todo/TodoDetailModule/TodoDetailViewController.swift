//
//  TodoDetailViewController.swift
//  VIPER_Study4_Todo
//
//  Created by Chung Wussup on 7/17/24.
//

import UIKit

class TodoDetailViewController: UIViewController {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    var presenter: TodoDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        presenter?.deleteTodo()
    }
    
    @IBAction func editTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Edit Todo Item", message: "Enter title and content", preferredStyle: .alert)
        
        alertController.addTextField { $0.text = self.titleLabel.text }
        alertController.addTextField { $0.text = self.contentLabel.text }
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self](_) in
            let titleText = alertController.textFields![0].text ?? ""
            let contentText = alertController.textFields![1].text ?? ""
            guard !titleText.isEmpty else { return }
            self?.presenter?.editTodo(title: titleText, content: contentText)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
        
    }
}

extension TodoDetailViewController: TodoDetailViewProtocol {
    
    func showToDo(_ todo: TodoItem) {
        titleLabel.text = todo.title
        contentLabel.text = todo.content
    }
    
}
