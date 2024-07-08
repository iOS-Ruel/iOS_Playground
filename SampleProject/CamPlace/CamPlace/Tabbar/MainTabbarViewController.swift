//
//  MainTabbarViewController.swift
//  CamPlace
//
//  Created by Chung Wussup on 6/15/24.
//

import UIKit

class MainTabbarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabbar()
    }
    
    
    private func setUpTabbar() {
        let firstViewController = MainMapViewController()
        firstViewController.tabBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "map"), tag: 0)
        
        let secondViewController = LocationFavoriteViewController()
        secondViewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "star"), tag: 1)
        
        tabBar.backgroundColor = .white
        
        self.viewControllers = [firstViewController, secondViewController]
    }
}

//#Preview {
//    UINavigationController(rootViewController: MainTabbarViewController())
//}
