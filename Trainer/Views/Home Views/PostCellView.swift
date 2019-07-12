//
//  PostCellView.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/19/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class PostCellView: UICollectionViewCell {
    
    // MARK: - Properties
    
    var user: User?
    var post: Post? {
        didSet {
            if let dataSource = post {
                loadData(withDataSource: dataSource)
            }
        }
    }
    
    // MARK: - Views
    
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
        label.textColor = .black
        
        return label
    }()
    
    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = label.font.withSize(14)
        label.contentHuggingPriority(for: .horizontal)
        label.textColor = .black
        
        return label
    }()
    
    let likesButton: ButtonWithImage = {
        let button = ButtonWithImage(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "thumbs-up"), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFit
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let commentsButton: ButtonWithImage = {
        let button = ButtonWithImage(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "message-circle"), for: .normal)
        button.tintColor = .gray
        button.imageView?.contentMode = .scaleAspectFit
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
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
    
    func loadData(withDataSource dataSource: Post) {
        self.user = dataSource.getUser()
        
        configureViews()
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    // MARK: - Selectors
    
    @objc func likeSelector() {
        debugPrint("Like button")
    }
    
    // MARK: - Self-sizing logic
    
    func calculateFrameSize(fromFrame frame: inout CGRect) {
        frame.size.height = 75
        frame.size.height += bodyLabel.frame.height
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()

        var frame = layoutAttributes.frame
        // TODO: Add true self-sizing capabilities
        calculateFrameSize(fromFrame: &frame)

        layoutAttributes.frame = frame

        return layoutAttributes
    }
    
    // MARK: - View Configuration
    
    func configureMainViews() {
        bodyLabel.text = post?.getBodyText()
        bodyLabel.anchor(top: usernameLabel.bottomAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    func configureViews() {
        addSubviews()
        configureSubviews()
    }
    
    func addSubviews() {
        // Top Views
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        
        // Main Views
        contentView.addSubview(bodyLabel)
        
        // Bottom Views
        contentView.addSubview(likesButton)
        contentView.addSubview(commentsButton)
    }
    
    // MARK: - Configuration
    
    func configureSubviews() {
        configureContentView()
        configureTopViews()
        configureMainViews()
        configureBottomViews()
    }
    
    func configureContentView() {
        contentView.layer.cornerRadius = 6
        contentView.backgroundColor = .white
        contentView.dropShadow()
    }
    
    func configureTopViews() {
        profileImageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH, height: Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH)
        usernameLabel.text = post?.getUser().getName()
        usernameLabel.anchor(top: contentView.topAnchor, leading: profileImageView.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 20)
    }
    
    func configureBottomViews() {
        let padding: CGFloat = 18
        configureLikesView(withTopView: bodyLabel, paddingTop: padding)
        configureCommentsView(withTopView: bodyLabel, paddingTop: padding)
    }
    
    func configureLikesView(withTopView topView: UIView, paddingTop: CGFloat) {
        let numberOfLikes = post?.getNumberOfLikes()
        let likesText = "\(numberOfLikes ?? 0)"
        
        likesButton.setTitle(likesText, for: .normal)
        likesButton.anchor(top: topView.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: paddingTop, paddingLeft: 0, paddingBottom: 12, paddingRight: 4, width: 50, height: 18)
    }
    
    func configureCommentsView(withTopView topView: UIView, paddingTop: CGFloat) {
        let numberOfComments = post?.getNumberOfComments()
        let commentsText = "\(numberOfComments ?? 0)"
        
        commentsButton.setTitle(commentsText, for: .normal)
        commentsButton.anchor(top: topView.bottomAnchor, leading: likesButton.trailingAnchor, bottom: nil, trailing: nil, paddingTop: paddingTop, paddingLeft: 12, paddingBottom: 12, paddingRight: 0, width: 50, height: 18)
    }
    
    func setBottomViewText() {
        let numberOfLikes = post?.getNumberOfLikes()
        let likesText = "\(numberOfLikes ?? 0) like\(numberOfLikes != 1 ? "s" : "")"
        likesButton.setTitle(likesText, for: .normal)
        
        let numberOfComments = post?.getNumberOfComments()
        let commentsText = "\(numberOfComments ?? 0) comment\(numberOfComments != 1 ? "s" : "")"
        commentsButton.setTitle(commentsText, for: .normal)
    }
    
}
