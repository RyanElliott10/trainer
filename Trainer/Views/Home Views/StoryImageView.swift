//
//  StoryImageView.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/24/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class StoryImageView: UICollectionViewCell {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            addSubviews()
            configureViews()
        }
    }
    
    // MARK: - Views
    
    private let topImagePreviewView: UIImageView = {
        let container = UIView()
        container.dropShadow()
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        
        view.layer.cornerRadius = 6
        view.dropShadow()
        container.addSubview(view)
        
        return view
    }()
    
    private let userView: UIView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 6
        blurEffectView.alpha = 0.9
        
        let view = UIView()
        view.backgroundColor = .clear
        blurEffectView.frame = view.bounds
        view.addSubview(blurEffectView)
        
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "zac_perna"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH / 2
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        
        return view
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
//        contentView.addSubview(userView)
    }
    
    private func configureViews() {
        configureImageView()
        configureUserView()
    }
    
    private func configureImageView() {
        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        outerView.translatesAutoresizingMaskIntoConstraints = false
        outerView.dropShadow(withHeight: 2, opacity: 0.5, radius: 3)
        
        contentView.addSubview(outerView)
        outerView.addSubview(topImagePreviewView)
        topImagePreviewView.addSubview(userView)
        
        topImagePreviewView.image = user?.getStoryContent()[0]
        outerView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 160)
        topImagePreviewView.anchor(top: outerView.topAnchor, leading: outerView.leadingAnchor, bottom: outerView.bottomAnchor, trailing: outerView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func configureUserView() {
        userView.anchor(top: topImagePreviewView.topAnchor, leading: topImagePreviewView.leadingAnchor, bottom: topImagePreviewView.bottomAnchor, trailing: topImagePreviewView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        userView.addSubview(profileImageView)
        
        profileImageView.centerXAnchor.constraint(equalTo: userView.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: userView.centerYAnchor).isActive = true
        profileImageView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH, height: Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH)
        
        userView.addSubview(usernameLabel)
        usernameLabel.text = user?.getName()
        usernameLabel.anchor(top: profileImageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        usernameLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
    }
    
}
