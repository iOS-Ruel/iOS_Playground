//
//  AccounLoginViewController.swift
//  ServerConnectApp_UIKit
//
//  Created by Chung Wussup on 7/18/24.
//

import UIKit
import Combine

class AccounLoginViewController: UIViewController {
    
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in to your accont"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var textFieldStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .fill
        sv.spacing = 24
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "username", attributes: [.foregroundColor: UIColor(named: "subTextColor") ?? .lightGray])
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(named: "textFieldColor")
        tf.textColor = .white
        tf.autocapitalizationType = .none
        
        let leftInset: CGFloat = 10
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftInset, height: tf.frame.height))
        tf.leftView = leftView
        tf.leftViewMode = .always
        return tf
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor(named: "subTextColor") ?? .lightGray])
        tf.borderStyle = .roundedRect
        tf.backgroundColor = UIColor(named: "textFieldColor")
        tf.textColor = .white
        tf.isSecureTextEntry = true
        
        let leftInset: CGFloat = 10
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: leftInset, height: tf.frame.height))
        tf.leftView = leftView
        tf.leftViewMode = .always
        return tf
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(UIColor(named: "subTextColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let loginStackView: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 12
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .vertical
        return sv
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "buttonBlueColor")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTouch), for: .touchUpInside)
        return button
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New user? Sign Up", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    private func setupUI() {
        
        view.backgroundColor = UIColor(named: "mainColor")
        
        view.addSubview(mainTitleLabel)
        
        view.addSubview(textFieldStackView)
        [usernameTextField, passwordTextField].forEach {
            textFieldStackView.addArrangedSubview($0)
        }
        view.addSubview(forgotPasswordButton)
        view.addSubview(loginStackView)
        [loginButton, signUpButton].forEach {
            loginStackView.addArrangedSubview($0)
        }
        
        NSLayoutConstraint.activate([
            mainTitleLabel.heightAnchor.constraint(equalToConstant: 28),
            mainTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            mainTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textFieldStackView.topAnchor.constraint(equalTo: mainTitleLabel.bottomAnchor, constant: 24),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            usernameTextField.heightAnchor.constraint(equalToConstant: 56),
            passwordTextField.heightAnchor.constraint(equalToConstant: 56),
            forgotPasswordButton.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 16),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 21),
            loginStackView.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            loginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            loginStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 48),
            signUpButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.left")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(backButtonTouch))
        self.navigationItem.leftBarButtonItem?.tintColor = .white
        
    }
    
    @objc func backButtonTouch() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func loginButtonTouch() {
        guard let userName = usernameTextField.text, !userName.isEmpty else {
            showAlert(message: "Please enter your username")
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Please enter your password")
            return
        }
        
        let service = RealEntryService()
        service.login(username: userName, password: password)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] res in
                switch res {
                case .finished:
                    let entriesVC = EntriesViewController()
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let sceneDelegate = windowScene.delegate as? SceneDelegate {
                        sceneDelegate.switchToEntriesViewController(vc: entriesVC)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.showAlert(message: error.localizedDescription)
                }
                
            } receiveValue: { token in
                print("str: \(token)")
                
                
            }
            .store(in: &cancellables)
        
        
       
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

#Preview() {
    AccounLoginViewController()
    
}
