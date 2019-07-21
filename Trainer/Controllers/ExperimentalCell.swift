//
//  ExperimentalCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/20/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ExperimentalCell: UICollectionViewCell {
    
    // https://stackoverflow.com/questions/37782659/swift-ios-uicollectionview-images-mixed-up-after-fast-scroll/37784212
    // http://www.thomashanning.com/the-most-common-mistake-in-using-uitableview/
    private let imageCellReuseId = "imageCellReuseId"
    var index: IndexPath?
    var images = [UIImage]()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        images = []
        imageView.image = nil
        collectionView.delegate = nil
        collectionView.dataSource = nil
        titleLabel.text = nil
        label.text = nil
        
        setupCollectionView()
        collectionView.removeFromSuperview()
    }
    
    func setupViews(withDatasource datasource: (String, [UIImage])) {
        parseDatasource(datasource)
            
        contentView.addSubview(titleLabel)
        titleLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        contentView.addSubview(label)
        if images.count > 0 {
            titleLabel.text = "Images"
            label.text = String(images.count)
            label.anchor(top: titleLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
            
//            imageView.image = images[0]
//            contentView.addSubview(imageView)
//            imageView.anchor(top: label.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        let height: CGFloat = images.count > 0 ? 200 : 0
        print("RYANLOG height:", height)
            contentView.addSubview(collectionView)
            collectionView.anchor(top: label.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: height)
        } else {
            titleLabel.text = "No Images"
            label.anchor(top: titleLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        }
        
    }
    
    private func parseDatasource(_ datasource: (String, [UIImage])) {
        label.text = datasource.0
        images = datasource.1
    }
    
    // MARK: - Used for self-sizing on <= iOS 12
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutIfNeeded()
        let layoutAttributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutAttributes.bounds.size = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .defaultLow)
        return layoutAttributes
    }
    
}

extension ExperimentalCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    fileprivate func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ScrollableImageView.self, forCellWithReuseIdentifier: imageCellReuseId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("RYANLOG images.count:", images.count)
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellReuseId, for: indexPath) as! ScrollableImageView
        cell.imageView.image = images[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
}
