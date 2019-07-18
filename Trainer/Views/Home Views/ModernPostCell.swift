//
//  ModernPostCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/17/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

// New implementation: No collection view, just imagesView

class ModernPostCell: UICollectionViewCell {
    
    var homeViewDelegate: HomeViewController?
    var user: User?
    var post: Post? {
        didSet {
            if let post = post {
                loadData(from: post)
            }
        }
    }
    
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
    
    private let imagesView: ModernPostCellImagesView = {
        let view = ModernPostCellImagesView()
        
        return view
    }()
    
    private let divider: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 235, green: 235, blue: 235)
        view.layer.cornerRadius = 2
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 24).isActive = true
        
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
        imagesView.images = post?.getImages() ?? []
        contentView.addSubview(imagesView)
        imagesView.anchor(top: bodyLabel.bottomAnchor, leading: titleLabel.leadingAnchor, bottom: nil, trailing: titleLabel.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 1)
        
        // Divider
        contentView.addSubview(divider)
        divider.anchor(top: imagesView.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8, width: 0, height: 2)
    }
    
    private func loadData(from dataSource: Post) {
        setupViews()
    }
    
}
