//
//  ViewController.swift
//  KeyBoardHandling
//
//  Created by Chung Wussup on 5/23/24.
//

import UIKit

class ViewController: UIViewController {

    let textField = UITextField()
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        textField.borderStyle = .roundedRect
        textField.placeholder = "여기에 입력하세요"
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        

        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, 
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view.removeGestureRecognizer(tapGesture)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let height = keyboardSize.height
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= height
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }

    @objc func tapHandler(_ sender: UIView) {
        textField.resignFirstResponder()
    }
    
}

