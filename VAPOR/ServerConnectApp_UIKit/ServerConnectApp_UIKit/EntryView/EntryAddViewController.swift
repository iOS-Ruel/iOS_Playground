//
//  EntryAddViewController.swift
//  ServerConnectApp_UIKit
//
//  Created by Chung Wussup on 7/18/24.
//

import UIKit

class EntryAddViewController: UIViewController {
    
    private let titleTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Title", attributes: [.foregroundColor: UIColor(named: "subTextColor") ?? .lightGray])
        tf.layer.cornerRadius = 10
        tf.backgroundColor = UIColor(named: "textFieldColor")
        tf.textColor = .white
        tf.autocapitalizationType = .none
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        let leftInset: CGFloat = 10
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftInset, height: tf.frame.height))
        tf.leftView = leftView
        tf.leftViewMode = .always
        return tf
    }()
    
    private let descriptionTextView: UITextView = {
       let tv = UITextView()
        tv.backgroundColor = UIColor(named: "textFieldColor")
        tv.textColor = .white
        tv.layer.cornerRadius = 10
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return tv
    }()
    
    private lazy var submitButton: UIButton = {
       let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "buttonBlueColor")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(submitButtonTouch), for: .touchUpInside)
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor(named: "mainColor")
        
        title = "New entry"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(closeButtonTouch))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        
        
        [titleTextField, descriptionTextView, submitButton].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleTextField.heightAnchor.constraint(equalToConstant: 56),
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 24),
            descriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            descriptionTextView.heightAnchor.constraint(equalToConstant: 144),
            submitButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 24),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            submitButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
    
    @objc func closeButtonTouch() {
        self.dismiss(animated: true)
    }
    
    @objc func submitButtonTouch() {
        self.dismiss(animated: true)
    }
}

#Preview() {
    UINavigationController(rootViewController: EntryAddViewController())
}
