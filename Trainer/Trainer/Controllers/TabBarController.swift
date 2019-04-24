//
//  TabBarController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    private func configureTabBar() {
        // Important to use UICollectionViewFlowLayout and not UICollectoinViewLayout
        tabBar.isTranslucent = false
        
        let homeViewController = HomeViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem.image = #imageLiteral(resourceName: "home")
        
        let searchViewController = SearchViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.tabBarItem.image = #imageLiteral(resourceName: "search")
        
        let progressViewController = UINavigationController(rootViewController: ProgressViewController())
        progressViewController.tabBarItem.image = #imageLiteral(resourceName: "bar-chart")
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem.image = #imageLiteral(resourceName: "user")
        
        viewControllers = [homeNavigationController, searchNavigationController, progressViewController, profileViewController]
    }
}
