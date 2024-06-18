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
    
    private lazy var isUsernamLengthValidPublisher: AnyPublisher<Bool, Never> = {
        $username
            .map { $0.count >= 3 }
            .eraseToAnyPublisher()
    }()
    
    
    init() {
        isUsernamLengthValidPublisher
            .assign(to: &$isValid)
        
        isUsernamLengthValidPublisher
            .map {
                $0 ? "" : "Username must be at least three chararcters!"
            }
            .assign(to: &$usernameMessage)
    }
    
}
