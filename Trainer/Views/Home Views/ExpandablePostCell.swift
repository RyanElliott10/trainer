//
//  ExpandablePostCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/19/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

/** To be deleted:
    |         POST        |
    | ___________________ |
    |                     |
    | CONTAINER STACKVIEW |
    |                     |
    |                     |
 */

/// These cells contain BasePostCells within their UIStackView

import UIKit

class ExpandablePostCell: HomeScreenPostCellView {
    
    var succeedingPosts = [Post]()
    var succeedingComments = [Comment]()
    
    // MARK: - Views
    
    var leftBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        view.layer.cornerRadius = 2
        
        return view
    }()
    
    var mainContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        
        return stackView
    }()
    
    // MARK: - View Configuration
    
    private func configureLeftBar() {
        contentView.addSubview(leftBar)
        leftBar.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor).isActive = true
        leftBar.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        leftBar.heightAnchor.constraint(equalToConstant: getImagesCollectionViewHeight()).isActive = true
        leftBar.widthAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    override func configureImagesCollectionView() {
        imagesCollectionView.anchor(top: bodyLabel.bottomAnchor, leading: leftBar.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 12, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: getImagesCollectionViewHeight())
    }
    
    override func configureMainViews() {
        configureLeftBar()
        super.configureMainViews()
        configureSucceedingCommentViews()
    }
    
    override func configureLikesView(withTopView topView: UIView, paddingTop: CGFloat) {
        let numberOfLikes = post?.getNumberOfLikes()
        let likesText = "\(numberOfLikes ?? 0)"
        
        likesButton.setTitle(likesText, for: .normal)
        likesButton.anchor(top: topView.bottomAnchor, leading: leftBar.trailingAnchor, bottom: nil, trailing: nil, paddingTop: paddingTop, paddingLeft: 10, paddingBottom: 12, paddingRight: 0, width: 50, height: 18)
    }
    
    override func configureCommentsView(withTopView topView: UIView, paddingTop: CGFloat) {
        let numberOfComments = post?.getNumberOfComments()
        let commentsText = "\(numberOfComments ?? 0)"
        
        commentsButton.setTitle(commentsText, for: .normal)
        commentsButton.anchor(top: topView.bottomAnchor, leading: likesButton.trailingAnchor, bottom: nil, trailing: nil, paddingTop: paddingTop, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: 50, height: 18)
    }
    
    private func configureSucceedingCommentViews() {
        contentView.addSubview(mainContainerStackView)
        mainContainerStackView.anchor(top: likesButton.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        configureCommentsViews()
    }
    
    private func configureCommentsViews() {
        for _ in succeedingComments {
//            let commentView = CommentCellView()
//            let post = Post.generateDummyPosts()[0]
//            commentView.postDataSource = post
//            mainContainerStackView.addSubview(commentView)
//            commentView.backgroundColor = .red
        }
    }
    
    // MARK: - Self-sizing logic
    
    override func calculateFrameSize(fromFrame frame: inout CGRect) {
        frame.size.height = 75
        frame.size.height += getImagesCollectionViewHeight()
        frame.size.height += bodyLabel.frame.height
        
        for _ in succeedingComments {
            frame.size.height += 100
        }
        
        frame.size.height += 100
    }
    
}
