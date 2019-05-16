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
    var homeViewDelegate: HomeViewControllerDelegate?
    var imagePreviewViewController: ImagePreviewViewController?
    var userDataSource: User?
    var postDataSource: Post? {
        didSet {
            if let dataSource = postDataSource {
                loadData(withDataSource: dataSource)
            }
        }
    }
    
    // MARK: - Views
    
    let mainContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 200, height: 3)
        
        return view
    }()
    
    let profileImageView: UIImageView = {
        let profileImage = UIImageView(image: #imageLiteral(resourceName: "zac_perna"))
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        profileImage.layer.cornerRadius = Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH / 2
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
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.contentHuggingPriority(for: .horizontal)
        
        return label
    }()
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    let likesButton: ButtonWithImage = {
        let button = ButtonWithImage(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "thumbs-up"), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let commentsButton: ButtonWithImage = {
        let button = ButtonWithImage(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "message-circle"), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let bottomBorder: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.rgb(red: 215, green: 215, blue: 215)
        
        return view;
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for subview in contentView.subviews {
            subview.removeFromSuperview()
        }
    }
    
    // MARK: - Data Configuration
    
    private func loadData(withDataSource dataSource: Post) {
        self.userDataSource = dataSource.getUser()
        
        configureViews()
        configureImagesCollectionView()
    }
    
    // MARK: - Selectors
    
    @objc func likeSelector() {
        print(123)
    }
    
    // MARK: - Auto-sizing logic
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()
        
        // let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        // frame.size.height = ceil(size.height)
        
        // This is a very poor way of doing this, but it'll work for now
        // TODO: Add true self-sizing capabilities
        frame.size.height = 80
        frame.size.height += getImagesCollectionViewHeight()
        frame.size.height += bodyLabel.frame.height
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
}
