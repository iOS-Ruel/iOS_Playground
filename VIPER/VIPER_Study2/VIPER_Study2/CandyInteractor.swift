//
//  CandyInteractor.swift
//  VIPER_Study2
//
//  Created by Chung Wussup on 5/24/24.
//

import Foundation

protocol CandyInteractorProtocol {
    func fetchCandy()
    func update(candyQuantity quantity:Int)
}

// Interactor의 안에 비즈니스 로직이 있어야한다.
// 네트워크 호출이나 데이터베이스 쿼리 등 데이터 수집 작업을 이곳에서 진행한다.

class CandyInteractor: CandyInteractorProtocol {
    
    private static let vat:Float = 6.5 // 세금 값이니 신경쓰지 않아도 된다.
    private var candyEntity:CandyEntity?
    private let apiWorker: CandyAPIWorkerProtocol
    
    required init(withApiWorker apiWorker: CandyAPIWorkerProtocol) {
        self.apiWorker = apiWorker
    }
    
    func fetchCandy() {
        
    }
    
    func update(candyQuantity quantity: Int) {
    
    }
}
