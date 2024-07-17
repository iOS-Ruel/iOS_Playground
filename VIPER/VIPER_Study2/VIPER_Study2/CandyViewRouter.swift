//
//  CandyViewRouter.swift
//  VIPER_Study2
//
//  Created by Chung Wussup on 7/17/24.
//

import Foundation
import UIKit

protocol CandyViewRouterInput: AnyObject {
    //화면전환에 필요한 메서드 Push, present
}

class CandyViewRouter: CandyViewRouterInput {
    
    //View
    weak var candyView: CandyViewController!
    
    static func start() -> UIViewController {
        let view = CandyViewController()
        let presenter = CandyViewPresenter()
        let interactor = CandyViewInteractor()
        let router = CandyViewRouter()
        
        view.presenter = presenter
        
        interactor.output = presenter
        
        presenter.view = view
        presenter.routerInput = router
        presenter.interface = interactor
        
        router.candyView = view
        
        
        return view
    }
    
}
