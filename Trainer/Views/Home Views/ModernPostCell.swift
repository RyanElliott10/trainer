//
//  ModernPostCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/17/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ModernPostCell: UICollectionViewCell {
    
    private var imagesDataSource = [UIImage]()
    private var homeViewDelegate: HomeViewController?
    private var user: User?
    private var post: Post?
    
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
        view.backgroundColor = .appBackground
        view.layer.cornerRadius = 2
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // Reset data since this cell will be used for another one
        resetData()
    }
    
    private func resetData() {
        imagesDataSource = []
        imagesCollectionView.delegate = nil
        imagesCollectionView.dataSource = nil
        titleLabel.text = nil
        bodyLabel.text = nil
    }
    
    func parseData(fromDatasource datasource: Post, withDelegate delegate: HomeViewController) {
        post = datasource
        user = datasource.getUser()
        titleLabel.text = user?.getName()
        dateLabel.text = datasource.getDate()
        bodyLabel.text = datasource.getBodyText()
        imagesDataSource = datasource.getImages()
        homeViewDelegate = delegate
        
        loadData()
    }
    
    private func loadData() {
        anchorViews()
        setupCollectionView()
    }
    
    private func anchorViews() {
        contentView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: UIScreen.main.bounds.width - 24, height: 0)
        
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shouldRasterize = true
        layer.rasterizationScale = 3
        clipsToBounds = true
        
        // Title
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        // Time
        contentView.addSubview(dateLabel)
        dateLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, paddingTop: 4, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 20)
        
        // Body
        contentView.addSubview(bodyLabel)
        bodyLabel.anchor(top: dateLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        // Images
        var topAnchor = bodyLabel.bottomAnchor
        if imagesDataSource.count > 0 {
            contentView.addSubview(imagesCollectionView)
            imagesCollectionView.anchor(top: bodyLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: getImagesCollectionViewHeight())
            topAnchor = imagesCollectionView.bottomAnchor
        }
        
        // Divider
        contentView.addSubview(divider)
        divider.anchor(top: topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 2)
    }
    
    func getImagesCollectionViewHeight() -> CGFloat {
        var imagesCollectionViewHeight: CGFloat = 0
        imagesCollectionViewHeight = imagesDataSource.count > 0 ? Constants.Cell.IMAGES_COLLECTION_VIEW_HEIGHT : 0.0
        return imagesCollectionViewHeight
    }
    
    // MARK: - Used for self-sizing on <= iOS 12
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return layoutAttributes
    }
    
}

extension ModernPostCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate func setupCollectionView() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ScrollableImageView.self, forCellWithReuseIdentifier: modernPostCellImageId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: modernPostCellImageId, for: indexPath) as! ScrollableImageView
        cell.imageView.image = imagesDataSource[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxHeight = imagesCollectionView.frame.height - 20
        let count = imagesDataSource.count
        switch count {
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imagePreviewViewController = ImagePreviewViewController()
        imagePreviewViewController.images = imagesDataSource
        imagePreviewViewController.startingIndexPath = indexPath
        homeViewDelegate?.push(viewController: imagePreviewViewController)
    }
    
}
