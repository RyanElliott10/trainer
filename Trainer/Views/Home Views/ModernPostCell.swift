//
//  ModernPostCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/17/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ModernPostCell: UICollectionViewCell {
    
    var isLayedOut = false
    var homeViewDelegate: HomeViewController?
    var user: User?
    var post: Post? {
        didSet {
            loadData()
        }
    }
    
    private let modernPostCellImageId = "modernPostCellImageId"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 1
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)
        label.numberOfLines = 1
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        label.numberOfLines = 0
        return label
    }()
    
    private let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        return collection
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 235, green: 235, blue: 235)
        view.layer.cornerRadius = 2
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("RYANLOG")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 24).isActive = true
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
        
        // Title
        titleLabel.text = post?.getTitle()
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        // Time
        dateLabel.text = post?.getDate()
        contentView.addSubview(dateLabel)
        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        // Body
        bodyLabel.text = post?.getBodyText()
        contentView.addSubview(bodyLabel)
        bodyLabel.anchor(top: dateLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        // Images
        contentView.addSubview(imagesCollectionView)
        imagesCollectionView.anchor(top: bodyLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imagesCollectionView.heightAnchor.constraint(equalToConstant: getImagesCollectionViewHeight()).isActive = true
        print("HERE: \(post?.getNumberOfImages() ?? 0) | \(getImagesCollectionViewHeight())")
        
        // Divider
        contentView.addSubview(divider)
        divider.anchor(top: imagesCollectionView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 2)
    }
    
    private func loadData() {
        imagesCollectionView.collectionViewLayout.invalidateLayout()
        configureCollectionView()
        setupViews()
    }
    
    func getImagesCollectionViewHeight() -> CGFloat {
        var imagesCollectionViewHeight: CGFloat = 0
        if let numberOfImages = post?.getNumberOfImages() {
            imagesCollectionViewHeight = numberOfImages > 0 ? Constants.Cell.IMAGES_COLLECTION_VIEW_HEIGHT : 0.0
        }
        return imagesCollectionViewHeight
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var newFrame = layoutAttributes.frame
        // note: don't change the width
        newFrame.size.height = ceil(size.height)
        layoutAttributes.frame = newFrame
        
        print(post?.getBodyText())
        print(getImagesCollectionViewHeight())
        print(size)
        print(newFrame, "\n\n")
        return layoutAttributes
    }
    
}

extension ModernPostCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate func configureCollectionView() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        
        imagesCollectionView.register(ScrollableImageView.self, forCellWithReuseIdentifier: modernPostCellImageId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post?.getNumberOfImages() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: modernPostCellImageId, for: indexPath) as? ScrollableImageView {
            if let image = post?.getImages()[indexPath.item] {
                cell.image = image
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let numberOfImages = post?.getNumberOfImages() {
            let maxHeight = imagesCollectionView.frame.height
            switch numberOfImages {
            case 1:
                let maxWidth = imagesCollectionView.frame.width - 16
                return CGSize(width: maxWidth, height: maxHeight)
            case 2:
                let maxWidth = imagesCollectionView.frame.width - 26
                return CGSize(width: maxWidth / 2, height: maxHeight)
            default:
                let maxWidth = imagesCollectionView.frame.width - 20
                return CGSize(width: maxWidth * 0.4, height: maxHeight)
            }
        } else {
            return CGSize(width: imagesCollectionView.frame.width, height: imagesCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imagePreviewViewController = ImagePreviewViewController()
        imagePreviewViewController.images = post!.getImages()
        imagePreviewViewController.startingIndexPath = indexPath
        homeViewDelegate?.push(viewController: imagePreviewViewController)
    }
    
}
