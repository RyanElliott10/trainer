//
//  SelectAvatarView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/5/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SelectAvatarView: UIView {
    
    // MARK: - Properties
    
    // MARK: - UI
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let editImageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Photo", for: .normal)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        configureSubViews()
    }
    
    private func configureSubViews() {
        configureImageView()
        configureEditButton()
    }
    
    private func configureImageView() {
        addSubview(imageView)
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseImage)))
        imageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: frame.width - 20, height: frame.height - 20)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.layer.cornerRadius = (frame.width - 20) / 2
        imageView.backgroundColor = .red
    }
    
    private func configureEditButton() {
        addSubview(editImageButton)
        editImageButton.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
        editImageButton.anchor(top: imageView.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc private func chooseImage() {
        print("chooseImage")
    }
    
}
