//
//  HomeViewController+NavBar.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

extension HomeViewController {
        
    func configureNavBarItems() {
//        configureLeftNavBarItem()
        configureRightNavBarItem()
        navigationItem.title = "Home"
    }
    
    private func configureLeftNavBarItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
    
    private func configureRightNavBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "post"), style: .plain, target: self, action: #selector(test))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
}
