//
//  ScrollableImageView.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/11/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ScrollableImageView: UICollectionViewCell {
    
    var image: UIImage = UIImage() {
        didSet {
            loadData(withImage: image)
        }
    }
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
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
    
    private func configureViews() {
        
        let imageView = UIImageView(image: image)
        contentView.addSubview(imageView)
        
        
        // Use contentView to reference the cell within the cell
        imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.cornerRadius = 8
    }
    
    private func loadData(withImage image: UIImage) {
        configureViews()
    }
    
}
