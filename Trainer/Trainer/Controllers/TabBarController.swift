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
        tabBar.isTranslucent = false
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem.image = #imageLiteral(resourceName: "home")
        
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        searchViewController.tabBarItem.image = #imageLiteral(resourceName: "search")
        
        let progressViewController = UINavigationController(rootViewController: ProgressViewController())
        progressViewController.tabBarItem.image = #imageLiteral(resourceName: "bar-chart")
        
        let profileViewController = UINavigationController(rootViewController: ProfileViewController())
        profileViewController.tabBarItem.image = #imageLiteral(resourceName: "user")
        
        viewControllers = [homeViewController, searchViewController, progressViewController, profileViewController]
//        viewControllers = [profileViewController, homeViewController, searchViewController, progressViewController]
        
        // Center tab bar items
        if let tabBarItems = tabBar.items {
            for tabItem in tabBarItems {
                tabItem.title = nil
                tabItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            }
        }
    }
}
