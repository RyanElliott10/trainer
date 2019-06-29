//
//  HomeScreenStoryCellView.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/24/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class HomeScreenStoryCellView: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let imageReuseID = "imageReuseID"
    var stories: [Story]? {
        didSet {
            addSubviews()
            configureViews()
        }
    }
    
    // MARK: - Views
    
    private let storiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Stories"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textColor = .black
        label.sizeToFit()
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Explore the stories shared by your friends and trainers"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.alwaysBounceHorizontal = true
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        
        return collection
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Configuration
    
    private func addSubviews() {
        contentView.addSubview(storiesLabel)
        contentView.addSubview(descriptionLabel)
//        contentView.addSubview(imagePreviewView)
        contentView.addSubview(collectionView)
    }
    
    private func configureViews() {
        configureContentView()
        configureStoriesLabel()
        configureDescriptionLabel()
        configureCollectionView()
    }
    
    func configureContentView() {
        contentView.layer.cornerRadius = 6
        contentView.backgroundColor = .white
        contentView.dropShadow()
    }
    
    private func configureStoriesLabel() {
        storiesLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 12, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func configureDescriptionLabel() {
        descriptionLabel.anchor(top: storiesLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 6, paddingLeft: 12, paddingBottom: 0, paddingRight: 0, width: contentView.frame.width - 24, height: 0)
    }
    
    private func configureCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: contentView.frame.width, height: 1)
        }
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(StoryImageView.self, forCellWithReuseIdentifier: imageReuseID)
        collectionView.anchor(top: descriptionLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: contentView.frame.width, height: 0)
    }
    
}

extension HomeScreenStoryCellView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageReuseID, for: indexPath) as? StoryImageView {
            cell.user = User.generateDummyUser()
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
