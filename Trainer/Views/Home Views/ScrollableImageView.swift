//
//  ScrollableImageView.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/11/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ScrollableImageView: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.cornerRadius = 6
        
        contentView.addSubview(imageView)
        imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}
