//
//  ProgressHeaderView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/27/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ProgressHeaderView: UICollectionViewCell {
    
    // MARK: - Properties
    
    open var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.bold)
        
        return label
    }()
    
    private let visibilityImage: ButtonWithImage = {
        let button = ButtonWithImage()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "eye-off"), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
        
        contentView.addSubview(visibilityImage)
        NSLayoutConstraint.activate([
            visibilityImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            visibilityImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            visibilityImage.heightAnchor.constraint(equalToConstant: 25),
            visibilityImage.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
