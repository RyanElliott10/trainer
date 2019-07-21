//
//  HomeViewController+NavBar.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

extension HomeViewController {
    
    func setupNavBarItems() {
        configureLeftNavBarItem()
        configureRightNavBarItem()
        navigationItem.title = "Timeline"
    }
    
    private func configureLeftNavBarItem() {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "zac_perna").withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 18
        button.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 36, height: 36)
        button.addTarget(self, action: #selector(navigationProfileImageOnPress), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    private func configureRightNavBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "post"), style: .plain, target: self, action: #selector(postOnPress))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
}
