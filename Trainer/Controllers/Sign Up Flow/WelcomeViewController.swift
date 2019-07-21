//
//  WelcomeViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/4/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    // MARK: - UI
    
    private let appIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .appPrimary
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let welcomeToLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Trainer"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = .appPrimary
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubViews()
    }
    
    private func configureSubViews() {
        view.backgroundColor = .white
        configureAppIcon()
        configureWelcomeLabel()
    }
    
    private func configureAppIcon() {
        view.addSubview(appIcon)
        appIcon.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 150, paddingLeft: 40, paddingBottom: 0, paddingRight: 0, width: 90, height: 90)
    }
    
    private func configureWelcomeLabel() {
        view.addSubview(welcomeToLabel)
        welcomeToLabel.anchor(top: appIcon.bottomAnchor, leading: appIcon.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 16, paddingLeft: 0, paddingBottom: 0, paddingRight: 50, width: 0, height: 0)
    }
    
}
