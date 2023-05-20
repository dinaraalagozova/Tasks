//
//  MainTabBarController.swift
//  TaskTwo
//
//  Created by Dinara Alagozova on 19.05.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
            let homeViewController = HomeViewController()
            let favoritesViewController = FavoritesViewController()
            
            homeViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
            favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
            
            viewControllers = [homeViewController, favoritesViewController]
        }

}
