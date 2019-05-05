//
//  SearchHeaderView.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/24/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SearchHeaderView: UICollectionReusableView, UISearchBarDelegate {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Featured Trainers"
        label.font = UIFont.boldSystemFont(ofSize: Constants.SEARCH_SCREEN_BOLD_LABEL_FONT)
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}
