//
//  ViewController.swift
//  RxSwift_Sample1
//
//  Created by Chung Wussup on 8/15/24.
//

import UIKit
import RxSwift
import RxCocoa
let disposeBag = DisposeBag()

class ViewController: UIViewController {

    
    let textField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "입력"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        binding()
    }
    
    func setupUI() {
        [textField, label].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.heightAnchor.constraint(equalToConstant: 200),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    
    func binding() {
        textField.rx.text.orEmpty
            .map { "Hello, \($0)" }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
    }

}

