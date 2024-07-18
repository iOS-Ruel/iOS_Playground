//
//  LoginViewController.swift
//  ServerConnectApp_UIKit
//
//  Created by Chung Wussup on 7/18/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private var mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "main")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private var mainTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Create stunning social\ngraphics in seconds"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var snsLoginStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.alignment = .center
        sv.spacing = 12
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private var googleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue With Google", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "loginButtonColor")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    private var fbLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue With Facebook", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "loginButtonColor")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    private var appleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Continue With Apple", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "loginButtonColor")
        button.layer.cornerRadius = 10
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    private var signupButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up for free", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Have an account already? Log in", for: .normal)
        button.setTitleColor(UIColor(named: "subTextColor"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(accountLoginButtonTouch), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        title = "Entry"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        view.backgroundColor = UIColor(named: "mainColor")
        view.addSubview(mainStackView)
        
        [mainImageView, mainTitleLabel].forEach {
            mainStackView.addArrangedSubview($0)
        }
        
        view.addSubview(snsLoginStackView)
        [googleLoginButton,fbLoginButton,appleLoginButton,signupButton].forEach {
            snsLoginStackView.addArrangedSubview($0)
        }
        
        view.addSubview(loginButton)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.56),
            mainTitleLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.26),
            
            snsLoginStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 12),
            snsLoginStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            snsLoginStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            googleLoginButton.widthAnchor.constraint(equalTo: snsLoginStackView.widthAnchor),
            googleLoginButton.heightAnchor.constraint(equalToConstant: 40),
            fbLoginButton.widthAnchor.constraint(equalTo: snsLoginStackView.widthAnchor),
            fbLoginButton.heightAnchor.constraint(equalToConstant: 40),
            appleLoginButton.widthAnchor.constraint(equalTo: snsLoginStackView.widthAnchor),
            appleLoginButton.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.topAnchor.constraint(equalTo: snsLoginStackView.bottomAnchor),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 37)
            
            
            
        ])
    }
    
    
    @objc func accountLoginButtonTouch() {
        let loginView = AccounLoginViewController()
        
        self.navigationController?.pushViewController(loginView, animated: true)
    }
}


#Preview() {
    UINavigationController(rootViewController: LoginViewController())
}
