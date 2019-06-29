//
//  SearchGymCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/27/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SearchGymCell : UICollectionViewCell {
    
    var rightContainerWidth: CGFloat = 100
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Zac Perna"
        label.font = UIFont.systemFont(ofSize: 18)
        label.sizeToFit()
        return label
    }()
    
    private let cellSubtitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "1024 Burlingame Road, Burlingame, CA 94104"
        return label
    }()
    
    private let cellBody: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.text = "Lorem ipsum yutu ioalg sdkdow apebd dipa djhaoe dbao dyeitn qietn zxcvo zodbeoa sdflk sadflkj sdfiohsdf sti tial fot ahao dld a toad djd and then there should be an ellipses"
        label.sizeToFit()
        label.numberOfLines = 3
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        
        contentView.layer.cornerRadius = 8
        contentView.dropShadow()
        
        configureSubViews()
    }
    
    private func configureSubViews() {
        configureTitle()
        configureSubtitle()
        configureBody()
    }
    
    private func configureTitle() {
        contentView.addSubview(cellTitle)
        cellTitle.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: contentView.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    private func configureSubtitle() {
        contentView.addSubview(cellSubtitle)
        cellSubtitle.anchor(top: cellTitle.bottomAnchor, leading: cellTitle.leadingAnchor, bottom: nil, trailing: contentView.safeAreaLayoutGuide.trailingAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    private func configureBody() {
        contentView.addSubview(cellBody)
        cellBody.anchor(top: cellSubtitle.bottomAnchor, leading: cellTitle.leadingAnchor, bottom: nil, trailing: contentView.safeAreaLayoutGuide.trailingAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
