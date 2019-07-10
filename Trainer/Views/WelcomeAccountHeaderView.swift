//
//  WelcomeAccountHeaderView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/5/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class WelcomeAccountHeaderView: UIView {
    
    private let appIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let positionBar: UIView = {
        let view = UIView()
        return view
    }()
    
    var welcomeAccountDelegate: WelcomeAccountViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureSubViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configurePositionGradient()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePositionGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = positionBar.bounds
        gradientLayer.colors = [UIColor.appPrimaryColor.cgColor, UIColor.appSecondaryColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.0, 1.0]
        positionBar.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func configureSubViews() {
        backgroundColor = .white
        configureAppIcon()
        configureSignUpButton()
        configureLoginButton()
        configurePositionView()
    }
    
    private func configureAppIcon() {
        addSubview(appIcon)
        appIcon.backgroundColor = .appPrimaryColor
        // This is needed. You should probably figure out how to not need it lol
        appIcon.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        appIcon.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        appIcon.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        appIcon.widthAnchor.constraint(equalToConstant: 70).isActive = true
        appIcon.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    private func configureSignUpButton() {
        signUpButton.addTarget(self, action: #selector(switchToSignUp), for: .touchUpInside)
        addSubview(signUpButton)
        signUpButton.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 6, paddingRight: 0, width: 0, height: 40)
    }
    
    private func configureLoginButton() {
        loginButton.addTarget(self, action: #selector(switchToLogin), for: .touchUpInside)
        addSubview(loginButton)
        loginButton.anchor(top: nil, leading: centerXAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 6, paddingRight: 0, width: 0, height: 40)
    }
    
    private func configurePositionView() {
        addSubview(positionBar)
        positionBar.backgroundColor = .black
        positionBar.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
    }
    
    func updateBarPosition(to: WelcomeControllers) {
        // This should be fixed
        positionBar.removeFromSuperview()
        addSubview(positionBar)
        if to == .Login {
            positionBar.anchor(top: nil, leading: centerXAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
        } else {
            positionBar.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: centerXAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 2)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func switchToLogin() {
        welcomeAccountDelegate?.switchTo(viewController: .Login)
    }
    
    @objc private func switchToSignUp() {
        welcomeAccountDelegate?.switchTo(viewController: .SignUp)
    }
    
}
