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
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    var contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    var presenter: TodoDetailPresenterProtocol?
    
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
        
        let deleteButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteTapped))
        
        
        navigationItem.rightBarButtonItems = [deleteButton, editButton]
    }
    
    @objc func deleteTapped() {
        presenter?.deleteTodo()
    }
    
    @objc func editTapped() {
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
