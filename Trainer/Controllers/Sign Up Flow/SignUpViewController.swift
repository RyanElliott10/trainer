//
//  SignUpViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/5/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    
    private let SIDE_PADDING: CGFloat = 16
    
    // MARK: - UI
    
    private let avatarImageView: SelectAvatarView = {
        let imageView = SelectAvatarView()
        return imageView
    }()
    
    // TODO: - Will need to add textfields to a view and set that as the avoidingView
    
    private var firstNameField: UITextField!
    private var lastNameField: UITextField!
    private var emailField: UITextField!
    private var passwordField: UITextField!
    private var confirmPasswordField: UITextField!
    
    // MARK: - Init
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        firstNameField = generateField(withPlaceholder: "First Name", isSecure: false, keyboardType: .default, capitalization: .sentences, autocorrection: .no)
        lastNameField = generateField(withPlaceholder: "Last Name", isSecure: false, keyboardType: .default, capitalization: .sentences, autocorrection: .no)
        emailField = generateField(withPlaceholder: "Email", isSecure: false, keyboardType: .emailAddress, capitalization: .none, autocorrection: .no)
        passwordField = generateField(withPlaceholder: "Password", isSecure: true, keyboardType: .default, capitalization: .none, autocorrection: .no)
        confirmPasswordField = generateField(withPlaceholder: "Confirm Password", isSecure: true, keyboardType: .default, capitalization: .none, autocorrection: .no)
    }
    
    private func generateField(withPlaceholder placeholder: String, isSecure: Bool, keyboardType: UIKeyboardType, capitalization: UITextAutocapitalizationType, autocorrection: UITextAutocorrectionType) -> UITextField {
        let field = UITextField()
        field.placeholder = placeholder
        field.isSecureTextEntry = isSecure
        field.keyboardType = keyboardType
        field.autocapitalizationType = capitalization
        field.autocorrectionType = autocorrection
        return field
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubViews()
    }
    
    private func configureSubViews() {
        configureImageView()
        configureNameViews()
        configureEmailView()
        configurePasswordViews()
    }
    
    private func configureImageView() {
        view.addSubview(avatarImageView)
        avatarImageView.anchor(top: view.topAnchor, leading: nil, bottom: nil, trailing: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 120)
        avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func configureNameViews() {
        view.addSubview(firstNameField)
        view.addSubview(lastNameField)
        firstNameField.anchor(top: avatarImageView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.centerXAnchor, paddingTop: 40, paddingLeft: SIDE_PADDING, paddingBottom: 0, paddingRight: SIDE_PADDING, width: 0, height: 40)
        lastNameField.anchor(top: firstNameField.topAnchor, leading: view.centerXAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: SIDE_PADDING, paddingBottom: 0, paddingRight: SIDE_PADDING, width: 0, height: 40)
    }
    
    private func configureEmailView() {
        view.addSubview(emailField)
        emailField.anchor(top: firstNameField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: SIDE_PADDING, paddingBottom: 0, paddingRight: SIDE_PADDING, width: 0, height: 40)
    }
    
    private func configurePasswordViews() {
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        passwordField.anchor(top: emailField.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.centerXAnchor, paddingTop: 8, paddingLeft: SIDE_PADDING, paddingBottom: 0, paddingRight: SIDE_PADDING, width: 0, height: 40)
        confirmPasswordField.anchor(top: emailField.bottomAnchor, leading: view.centerXAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: SIDE_PADDING, paddingBottom: 0, paddingRight: SIDE_PADDING, width: 0, height: 40)
    }
    
}
