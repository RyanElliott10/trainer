//
//  NavigationBar.swift
//  Trainer
//
//  Created by Ryan Elliott on 8/4/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

protocol NavigationBarDelegate {
    
    func dismissView()
    
    func rightActionButtonOnTap()
    
    func navigationTitleOnTap()
    
}

class NavigationBar: UIView {
    
    // MARK: - Properties
    
    var delegate: NavigationBarDelegate!
    
    // MARK: - UI
    
    private var dismissButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.appPrimary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return button
    }()
    
    private var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.appPrimary, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New Workout"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupViews()
        
        backgroundColor = .white
    }
    
    private func setupViews() {
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addOnTap), for: .touchUpInside)
        
        addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            dismissButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
        ])
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        addSubview(addButton)
        NSLayoutConstraint.activate([
            addButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
    
    // MARK: - Selectors
    
    @objc private func dismissView() {
        delegate.dismissView()
    }
    
    @objc private func addOnTap() {
        delegate.rightActionButtonOnTap()
    }
    
    @objc private func navigationTitleOnTap() {
        delegate.navigationTitleOnTap()
    }
    
}

