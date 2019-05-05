//
//  PostCellView.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class PostCellView: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let profileImage = UIImageView(image: UIImage(named: "zac_perna"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.frame = CGRect(x: 0, y: 0, width: 8, height: 8)
        profileImage.clipsToBounds = true
        return profileImage
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "James Atlin"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Checkout my new training program! It’s a combination of a push/pull/legs split and a full body workout combined with HIIT training cause why not? http://zacperna.com.au/services/online-training-plans/"
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        return label
    }()
    
    let likesImage: UIImageView = {
        let likesImage = UIImageView()
        likesImage.image = #imageLiteral(resourceName: "thumbs-up")
        return likesImage
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "128 Likes"
        label.font = label.font.withSize(12)
        return label
    }()
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        configureProfileImage()
        configureUsernameLabel()
        configureBodyView()
        configureLikesView()
        
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
        }
        
        let borderColor = UIColor.rgb(red: 175, green: 175, blue: 175, alpha: 1)
        contentView.addBottomBorderWithColor(color: borderColor, height: 1)
    }
    
    private func configureProfileImage() {
        contentView.addSubview(profileImageView)
        profileImageView.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func configureUsernameLabel() {
        contentView.addSubview(usernameLabel)
        usernameLabel.anchor(top: contentView.topAnchor, left: profileImageView.rightAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func configureBodyView() {
        contentView.addSubview(bodyLabel)
        bodyLabel.anchor(top: usernameLabel.bottomAnchor, left: profileImageView.rightAnchor, bottom: nil, right: contentView.rightAnchor, paddingTop: 4, paddingLeft: 8, paddingBottom: 0, paddingRight: 16, width: 0, height: 0)
    }
    
    private func configureLikesView() {
        configureLikesImage()
        configureLikesLabel()
    }
    
    private func configureLikesImage() {
        contentView.addSubview(likesImage)
        likesImage.anchor(top: bodyLabel.bottomAnchor, left: contentView.leftAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func configureLikesLabel() {
        contentView.addSubview(likesLabel)
        likesLabel.anchor(top: bodyLabel.bottomAnchor, left: likesImage.rightAnchor, bottom: nil, right: nil, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
}
