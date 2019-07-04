//
//  SearchTrainerCell
//  Trainer
//
//  Created by Ryan Elliott on 6/26/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SearchTrainerCell : UICollectionViewCell {
    
    var rightContainerWidth: CGFloat = 100
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "zac_perna")
        imageView.layer.cornerRadius = Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH / 2
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let cellTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Zac Perna"
        label.font = UIFont.systemFont(ofSize: 18)
        label.sizeToFit()
        
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
        configureProfileImageView()
        configureTitle()
        configureBody()
    }
    
    private func configureProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: contentView.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH, height: Constants.Cell.PROFILE_IMAGE_VIEW_WIDTH)
    }
    
    private func configureTitle() {
        contentView.addSubview(cellTitle)
        cellTitle.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: profileImageView.leadingAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    private func configureBody() {
        contentView.addSubview(cellBody)
        cellBody.anchor(top: cellTitle.bottomAnchor, leading: cellTitle.leadingAnchor, bottom: nil, trailing: profileImageView.leadingAnchor, paddingTop: 6, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
