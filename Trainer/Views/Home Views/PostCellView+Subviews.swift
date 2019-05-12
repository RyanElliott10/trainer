//
//  PostCellView+Subviews.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/5/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

extension PostCellView {
    
    func configureViews() {
        addSubviews()
        configureSubviews()
    }
    
    private func addSubviews() {
        // Top Views
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        
        // Main Views
        contentView.addSubview(bodyLabel)
        contentView.addSubview(imagesCollectionView)
        
        // Bottom Views
        contentView.addSubview(likesImage)
        contentView.addSubview(likesLabel)
        contentView.addSubview(commentsImage)
        contentView.addSubview(commentsLabel)
        
        // Border View
        contentView.addSubview(bottomBorder)
    }
    
    // MARK: - Configuration
    
    private func configureSubviews() {
        configureTopViews()
        configureMainViews()
        configureBottomViews()
        configureBorderView()
    }
    
    private func configureTopViews() {
        profileImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH, height: Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH)
        usernameLabel.text = self.postDataSource?.getUser().getName()
        usernameLabel.anchor(top: contentView.topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 20)
    }
    
    func configureMainViews() {
        let imagesCollectionViewHeight = getImagesCollectionViewHeight()
        bodyLabel.text = self.postDataSource?.getBodyText()
        bodyLabel.anchor(top: usernameLabel.bottomAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
        
        imagesCollectionView.anchor(top: bodyLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: imagesCollectionViewHeight)
    }
    
    func getImagesCollectionViewHeight() -> CGFloat {
        
        var imagesCollectionViewHeight: CGFloat = 0
        if let numberOfImages = self.postDataSource?.getNumberOfImages() {
            imagesCollectionViewHeight = numberOfImages > 0 ? Constants.Cell.IMAGES_COLLECTION_VIEW_HEIGHT : 0.0
        }
        return imagesCollectionViewHeight
    }
    
    private func configureBottomViews() {
        configureLikesView()
        configureCommentsView()
    }
    
    private func configureLikesView() {
        let numberOfLikes = self.postDataSource?.getNumberOfLikes()
        let likesText = "\(numberOfLikes ?? 0) like\(numberOfLikes != 1 ? "s" : "")"
        likesLabel.text = likesText
        likesImage.anchor(top: imagesCollectionView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 8, paddingBottom: 12, paddingRight: 0, width: 16, height: 16)
        likesLabel.anchor(top: imagesCollectionView.bottomAnchor, leading: likesImage.trailingAnchor, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 4, paddingBottom: 12, paddingRight: 0, width: 0, height: 20)
    }
    
    private func configureCommentsView() {
        let numberOfComments = self.postDataSource?.getNumberOfComments()
        let commentsText = "\(numberOfComments ?? 0) comment\(numberOfComments != 1 ? "s" : "")"
        commentsLabel.text = commentsText
        commentsImage.anchor(top: imagesCollectionView.bottomAnchor, leading: likesLabel.trailingAnchor, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: 16, height: 16)
        commentsLabel.anchor(top: imagesCollectionView.bottomAnchor, leading: commentsImage.trailingAnchor, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 4, paddingBottom: 12, paddingRight: 0, width: 0, height: 20)
    }
    
    private func configureBorderView() {
        bottomBorder.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
}

// MARK: - Images Collection View

extension PostCellView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // The issue is probably in here. Perhaps make the imageView a seperate View object
    
    func configureImagesCollectionView() {
        // I feel like this should be in viewDidLoad
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(ScrollableImageView.self, forCellWithReuseIdentifier: imageCellID)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.postDataSource?.getNumberOfImages() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellID, for: indexPath) as? ScrollableImageView {
            if let image = self.postDataSource?.getImages()[indexPath.row] {
                cell.image = image
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let numberOfImages = self.postDataSource?.getNumberOfImages() {
            let maxHeight = imagesCollectionView.frame.height - 20
            switch numberOfImages {
            case 1:
                let maxWidth = imagesCollectionView.frame.width - 16
                imagesCollectionView.isScrollEnabled = false
                return CGSize(width: maxWidth, height: maxHeight)
            case 2:
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
