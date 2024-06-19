//
//  SignUpFormViewModel.swift
//  SignUpForm+Combine
//
//  Created by Chung Wussup on 6/18/24.
//

import Foundation
import Combine

class SignUpFormViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    
    @Published var usernameMessage: String = ""
    @Published var passwordMessage: String = ""
    @Published var isValid: Bool = false
    
//    @Published var isUserNameAvaliable: Bool = false
    
    private let authenticationService = AuthenticationService()
    private var cancelable: Set<AnyCancellable> = []
    
    private lazy var isUsernamLengthValidPublisher: AnyPublisher<Bool, Never> = {
        $username
            .map { $0.count >= 3 }
            .eraseToAnyPublisher()
    }()
    
    private lazy var isPasswordEmptyPublisher: AnyPublisher<Bool, Never> = {
        $password
            .map(\.isEmpty)
            .eraseToAnyPublisher()
    }()
    
    private lazy var isPasswordMatchingPublisher: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest($password, $passwordConfirmation)
            .map(==)
            .eraseToAnyPublisher()
    }()
    
    private lazy var isPasswordValidPublisher: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest(isPasswordEmptyPublisher, isPasswordMatchingPublisher)
            .map { !$0 && $1 }
            .eraseToAnyPublisher()
    }()
    
    private lazy var isFormValidPublisehr: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest3(isUsernamLengthValidPublisher, isUsernameAvailablePublisher, isPasswordValidPublisher)
            .map { $0 && $1 && $2 }
            .eraseToAnyPublisher()
    }()
     
    private lazy var isUsernameAvailablePublisher: AnyPublisher<Bool, Never> = {
        $username.debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { userName -> AnyPublisher<Bool, Never> in
                self.authenticationService.checkUserNameAvailableWithClosure(userName: userName)
            }
            .receive(on: DispatchQueue.main)
            .share()
            .print("share")
            .eraseToAnyPublisher()
    }()
    
    init() {
        
        
        
//            .sink { [weak self] userName in
//                self?.checkUserNameAvailable(userName)
//            }
//            .store(in: &cancelable)
        
        isFormValidPublisehr
            .assign(to: &$isValid)
        
        Publishers.CombineLatest(isUsernamLengthValidPublisher, isUsernameAvailablePublisher)
            .map { isUserNameLengthValid, isUserNameAvaliable in
                if !isUserNameLengthValid{
                    return "Username must be at least three chararcters!"
                } else if !isUserNameAvaliable {
                    return "This is userName already taken."
                }
                return ""
            }
            .assign(to: &$usernameMessage)
        
//        isUsernamLengthValidPublisher
//            .map {
//                $0 ? "" : "Username must be at least three chararcters!"
//            }
//            .assign(to: &$usernameMessage)
        
        Publishers.CombineLatest(isPasswordEmptyPublisher, isPasswordMatchingPublisher)
            .map { isPsswordEmpty, isPasswordMatching in
                if isPsswordEmpty {
                    return "Password must not be empty"
                } else if !isPasswordMatching {
                    return "Passwords do not match"
                } else {
                    return ""
                }
            }
            .assign(to: &$passwordMessage)
    }
    
    
//    func checkUserNameAvailable(_ userName: String) {
//        authenticationService.checkUserNameAvailableWithClosure(userName: userName) { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let isAvaliable):
//                    self?.isUserNameAvaliable = isAvaliable
//                case .failure(let error):
//                    print(error.localizedDescription)
//                    self?.isUserNameAvaliable = false
//                }
//            }
//        }
//    }
}
