//
//  PostCellView.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class PostCellView: UICollectionViewCell {
    
    // MARK: - Properties
    
    let imageCellID = "imageCellID"
    var isImageCollectionViewNeeded = false
    var userDataSource: User?
    var postDataSource: Post? {
        didSet {
            if let dataSource = postDataSource {
                loadData(withDataSource: dataSource)
            }
        }
    }
    
    // MARK: - Views
    
    let profileImageView: UIImageView = {
        let profileImage = UIImageView(image: #imageLiteral(resourceName: "zac_perna"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.cornerRadius = Constants.PROFILE_IMAGE_VIEW_WIDTH / 2
        profileImage.contentMode = .scaleToFill
        profileImage.clipsToBounds = true
        
        return profileImage
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        
        return label
    }()
    
    let bodyView: UIView = {
        let view = UIView()
        return view;
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        
        return label
    }()
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.alwaysBounceHorizontal = true
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    let likesCommentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let likesImage: UIImageView = {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(likeSelector))
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "thumbs-up")
        
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "128 likes"
        label.font = label.font.withSize(14)
        
        return label
    }()
    
    let commentsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "message-circle")
        
        return imageView
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "3 comments"
        label.font = label.font.withSize(14)
        
        return label
    }()
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view;
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Data Configuration
    
    private func loadData(withDataSource dataSource: Post) {
        self.userDataSource = dataSource.getUser()
        usernameLabel.text = self.userDataSource?.getName()
        bodyLabel.text = dataSource.getBodyText()
        likesLabel.text = "\(dataSource.getNumberOfLikes()) likes"
        commentsLabel.text = "\(dataSource.getNumberOfComments()) comments"
        
        contentView.addSubview(imagesCollectionView)
        isImageCollectionViewNeeded = true
        configureBodyView()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: - Selectors
    
    @objc func likeSelector() {
        print(123)
    }
    
}
