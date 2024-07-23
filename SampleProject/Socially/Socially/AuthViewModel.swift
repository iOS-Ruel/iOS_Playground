//
//  AuthViewModel.swift
//  Socially
//
//  Created by Chung Wussup on 7/23/24.
//

import SwiftUI
import FirebaseAuth
import AuthenticationServices
import CryptoKit

class AuthViewModel: ObservableObject {
    
    @Published var user: User?
    var currentNonce: String?
    /* firebase 클라이언트 apple 3자 통신으로
     3자가 주고 받을때 탈취 위험이 있기 때문에 Nonce Number라는 난수를 설정함
     즉, 인증 과정을 위한 임의의 랜덤 난수
     */
    
    func randomNonceString(length: Int = 32) -> String { precondition(length > 0)
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)" )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        return result
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap { String(format: "%02x", $0) }.joined()
        
        //복호화가 불가능한 Hash키 생성
        return hashString
    }
    
}
