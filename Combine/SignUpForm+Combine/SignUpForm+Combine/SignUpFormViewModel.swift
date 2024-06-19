//
//  SignUpFormViewModel.swift
//  SignUpForm+Combine
//
//  Created by Chung Wussup on 6/18/24.
//

import Foundation
import Combine

extension Publisher {
    func asResult() -> AnyPublisher<Result<Output,Failure>, Never> {
        self.map(Result.success)
            .catch { error in
                Just(.failure(error))
            }
            .eraseToAnyPublisher()
    }
}

class SignUpFormViewModel: ObservableObject {
    typealias Avaliable = Result<Bool, Error>
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    
    @Published var usernameMessage: String = ""
    @Published var passwordMessage: String = ""
    @Published var isValid: Bool = false
    
    
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
            .map { isUsernamLengthValid, isUsernameAvailable, isPasswordValid in
                
                switch isUsernameAvailable {
                case .success(let isAvailabe) :
                    return isUsernamLengthValid && isAvailabe && isPasswordValid
                case .failure:
                    return false
                }
                
            }
            .eraseToAnyPublisher()
    }()
    
    private lazy var isUsernameAvailablePublisher: AnyPublisher<Avaliable, Never> = {
        $username.debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap { userName -> AnyPublisher<Avaliable, Never> in
                self.authenticationService.checkUserNameAvailable(userName: userName)
                    .asResult()
            }
            .receive(on: DispatchQueue.main)
            .share()
            .print("share")
            .eraseToAnyPublisher()
    }()
    
    init() {
        
        isFormValidPublisehr
            .assign(to: &$isValid)
        
        Publishers.CombineLatest(isUsernamLengthValidPublisher, isUsernameAvailablePublisher)
            .map { isUsernameLengthValid, isUserNameAvailable in
                switch (isUsernameLengthValid, isUserNameAvailable) {
                case (false, _):
                    return "Username must be at least three characters!"
                case (_, .failure(let error)):
                    if case APIError.transportError(_) = error {
                        return  "인터넷 연결 확인하세요"
                    }
                    return "Error checking username availability: \(error.localizedDescription)"
                case (_, .success(false)):
                    return "This username is already taken."
                default:
                    return ""
                }
            }
            .assign(to: &$usernameMessage)
        
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
}
