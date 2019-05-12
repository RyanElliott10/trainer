//
//  FeaturedTrainersCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/23/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class FeaturedTrainersCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Ryan Elliott, and this is a test, you know? Like will this even wrap?"
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    func configureViews() {
        contentView.addSubview(label)
        label.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 0, width: 0, height: 0)
    }
}
