//
//  RootRouter.swift
//  VIPER_Study3
//
//  Created by Chung Wussup on 6/9/24.
//

import Foundation
import UIKit

protocol RootWireframe: AnyObject {
    func presentArticlesScreen(in window: UIWindow)
}


class RootRouter: RootWireframe {
    func presentArticlesScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = PokeListWireframe.start()
    }
}
