//
//  ExperimentalSignInWithApple.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/22/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit
import AuthenticationServices

class ExperimentalSignInWithApple: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        if #available(iOS 13, *) {
            let appleButton = ASAuthorizationAppleIDButton()
            appleButton.cornerRadius = 8
            appleButton.translatesAutoresizingMaskIntoConstraints = false
            appleButton.addTarget(self, action: #selector(didTapAppleButton), for: .touchUpInside)
            
            view.addSubview(appleButton)
            NSLayoutConstraint.activate([
                appleButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                appleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                appleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
            ])
        }
    }
    
    @available(iOS 13, *)
    @objc private func didTapAppleButton() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        
        controller.performRequests()
    }
    
}

extension ExperimentalSignInWithApple: ASAuthorizationControllerDelegate {
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credentials as ASAuthorizationAppleIDCredential:
            let user = AppleUser(credentials: credentials)
            print(user)
        default: break
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Something bad happened: \(error)")
    }
    
}

extension ExperimentalSignInWithApple: ASAuthorizationControllerPresentationContextProviding {
    
    @available(iOS 13.0, *)
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
    
}

@available(iOS 13, *)
fileprivate struct AppleUser {
    
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    
    init(credentials: ASAuthorizationAppleIDCredential) {
        id = credentials.user
        firstName = credentials.fullName?.givenName ?? ""
        lastName = credentials.fullName?.familyName ?? ""
        email = credentials.email ?? ""
    }
    
    
}
