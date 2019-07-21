//
//  DetailedPostViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/12/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

import AMScrollingNavbar

class DetailedPostViewController: UIViewController {
    
    // MARK: - Properties
    
    let postHeaderCellReuseId = "postHeaderCellReuseId"
    let commentCellReuseId = "commentCellReuseId"
    var post: Post? {
        didSet {
            if let p = post {
                load(data: p)
            }
        }
    }
    // Var beause this will fetch more comments the further the user scrolls
    var comments = [Comment]()
    
    private lazy var postCommentsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .appBackground
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(PostCellView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: postHeaderCellReuseId)
        collectionView.register(ExpandablePostCell.self, forCellWithReuseIdentifier: commentCellReuseId)
        
        return collectionView
    }()
    
    // AMScrollingNavbar override
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(postCommentsCollectionView, delay: 50.0)
        }
    }
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - View Configuration
    
    private func configureViews() {
        addSubviews()
        configurePostCommentsCollectionView()
    }
    
    private func addSubviews() {
        view.addSubview(postCommentsCollectionView)
    }
    
    private func configurePostCommentsCollectionView() {
        if let flowLayout = postCommentsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width - 24, height: 1)
        }
        
        postCommentsCollectionView.delegate = self
        postCommentsCollectionView.dataSource = self
        postCommentsCollectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: - Data
    
    private func load(data: Post) {
        configureViews()
    }
    
}

// MARK: - Collection View

extension DetailedPostViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        //        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 24, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: postHeaderCellReuseId, for: indexPath) as? PostCellView {
                cell.post = post
                return cell
            }
            return UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: commentCellReuseId, for: indexPath) as? ExpandablePostCell {
            cell.post = post
            cell.succeedingComments = [Comment()]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    // MARK: - CollectionView Header
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width - 24, height: 200)
    }
    
}
