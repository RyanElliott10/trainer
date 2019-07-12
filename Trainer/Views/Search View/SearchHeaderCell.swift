//
//  SearchHeaderCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/23/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SearchHeaderCell: UICollectionViewCell {
    
    var labelText = "N/a" {
        didSet {
            configureSubViews()
        }
    }
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubViews() {
        addSubview(label)
        label.text = labelText
        label.anchor(top: nil, leading: contentView.safeAreaLayoutGuide.leadingAnchor, bottom: contentView.safeAreaLayoutGuide.bottomAnchor, trailing: contentView.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
    }
    
}
