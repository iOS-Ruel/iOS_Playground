//
//  MainRouter.swift
//  VIPER_Study2
//
//  Created by Chung Wussup on 7/17/24.
//

import Foundation
import UIKit

protocol MainRouterProtocol: AnyObject {
    func startMainScene(window: UIWindow)
}


class MainRouter: MainRouterProtocol {
    
    ///앱 시작시 window Root 설정
    func startMainScene(window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = CandyViewRouter.start()
    }
    
}
