//
//  PostCellView+SubviewConfig.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/4/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

extension PostCellView {
    
    // MARK: - Configurations
    
    func configureViews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews()
        configureProfileImage()
        configureUsernameLabel()
//        configureBodyView()
//        configureLikesCommentsView()
    }
    
    private func addSubviews() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(bodyView)
        contentView.addSubview(likesCommentsView)
        contentView.addSubview(bottomBorder)
        
        bottomBorder.anchor(top: nil, left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, right: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    private func configureProfileImage() {
        profileImageView.backgroundColor = .red
        profileImageView.anchor(top: contentView.topAnchor, left: contentView.leadingAnchor, bottom: nil, right: nil, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: Constants.PROFILE_IMAGE_VIEW_WIDTH, height: Constants.PROFILE_IMAGE_VIEW_WIDTH)
    }
    
    private func configureUsernameLabel() {
        usernameLabel.anchor(top: contentView.topAnchor, left: profileImageView.trailingAnchor, bottom: nil, right: contentView.trailingAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 20)
    }
    
    // MARK: - Body View
    
    func configureBodyView() {
        bodyView.anchor(top: usernameLabel.bottomAnchor, left: contentView.leadingAnchor, bottom: nil, right: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        contentView.addSubview(bodyLabel)
        bodyLabel.anchor(top: bodyView.topAnchor, left: profileImageView.trailingAnchor, bottom: nil, right: bodyView.trailingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        if (isImageCollectionViewNeeded) {
            configureImagesCollectionView()
            imagesCollectionView.anchor(top: bodyLabel.bottomAnchor, left: bodyView.leadingAnchor, bottom: nil, right: bodyView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: Constants.IMAGES_COLLECTION_VIEW_HEIGHT)
        }
        bodyView.setNeedsLayout()
        bodyView.layoutIfNeeded()
    }
    
    private func configureImagesCollectionView() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: imageCellID)
    }
    
    // MARK: - Likes and Comments View
    
    private func configureLikesCommentsView() {
        likesCommentsView.anchor(top: bodyView.bottomAnchor, left: contentView.leadingAnchor, bottom: contentView.bottomAnchor, right: contentView.trailingAnchor, paddingTop: 12, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, width: 0, height: 0)
        likesCommentsView.addSubview(likesImage)
        likesCommentsView.addSubview(likesLabel)
        likesCommentsView.addSubview(commentsImage)
        likesCommentsView.addSubview(commentsLabel)
        
        configureLikesView()
        configureCommentsView()
    }
    
    private func configureLikesView() {
        configureLikesImage()
        configureLikesLabel()
    }
    
    private func configureLikesImage() {
        likesImage.anchor(top: likesCommentsView.topAnchor, left: likesCommentsView.leadingAnchor, bottom: likesCommentsView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
    }
    
    private func configureLikesLabel() {
        likesLabel.anchor(top: likesCommentsView.topAnchor, left: likesImage.trailingAnchor, bottom: likesCommentsView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
    }
    
    private func configureCommentsView() {
        configureCommentsImage()
        configureCommentsLabel()
    }
    
    private func configureCommentsImage() {
        commentsImage.anchor(top: likesCommentsView.topAnchor, left: likesLabel.trailingAnchor, bottom: likesCommentsView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 16, height: 16)
    }
    
    private func configureCommentsLabel() {
        commentsLabel.anchor(top: likesCommentsView.topAnchor, left: commentsImage.trailingAnchor, bottom: likesCommentsView.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
    }
    
    // Required for cell auto-sizing
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        return layoutAttributes
    }
    
}

// MARK: - Images Collection View

extension PostCellView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return postDataSource?.getNumberOfImages() ?? 0
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellID, for: indexPath)
        let imageView = UIImageView(image: #imageLiteral(resourceName: "boxed-water-is-better-1464052-unsplash"))
        cell.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.anchor(top: cell.contentView.topAnchor, left: cell.contentView.leadingAnchor, bottom: cell.contentView.bottomAnchor, right: cell.contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // The idea is to have this scale so that one picture takes up the entire screen, 2 takes up half, and > 2 goes into the scrollable view
        if let count = postDataSource?.getBodyText().count {
            let maxHeight = imagesCollectionView.frame.height - 20
            switch count {
            case 0...100:
                let maxWidth = imagesCollectionView.frame.width - 16
                imagesCollectionView.isScrollEnabled = false
                return CGSize(width: maxWidth, height: maxHeight)
            case 100...200:
                let maxWidth = imagesCollectionView.frame.width - 26
                imagesCollectionView.isScrollEnabled = false
                return CGSize(width: maxWidth / 2, height: maxHeight)
            default:
                let maxWidth = imagesCollectionView.frame.width - 20
                return CGSize(width: maxWidth / 3, height: maxHeight)
            }
        } else {
            return CGSize(width: imagesCollectionView.frame.width, height: imagesCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
}
