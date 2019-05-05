//
//  HomeViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    private let refreshControl = UIRefreshControl()
    private let cellReuseID = "cellID"
    
    // Navigation Bar Images
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = false
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "zac_perna.jpeg") // assign the image from Firebase here
        return imageView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.collectionViewLayout = Constants.AUTOSIZING_FLOW_LAYOUT
        collectionView.dataSource = self
        collectionView.delegate = self
        
        configureViews()
    }
    
    // MARK: - Configuration
    
    func configureViews() {
        view.backgroundColor = .white
        configureNavBar()
        configureCollectionView()
    }
    
    private func configureNavBar() {
        configureNavBarItems()
    }
    
    private func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: view.frame.width, height: 1)
        collectionView.collectionViewLayout = flowLayout
        
        collectionView?.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        configureRefreshControl()
        collectionView?.register(PostCellView.self, forCellWithReuseIdentifier: cellReuseID)
    }
    
    func configureRefreshControl() {
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlSelectorTest), for: .valueChanged)
    }
    
    // MARK: - Selectors
    
    @objc func postOnPress() {
        print("Post on press")
    }
    
    @objc func refreshControlSelectorTest() {
        print("Refreshing")
        collectionView.refreshControl?.endRefreshing()
    }
    
    // MARK: - CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Post.generateDummyPosts().count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? PostCellView {
            let post = Post.generateDummyPosts()[indexPath.row]
            cell.postDataSource = post
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell was selected at:", indexPath.row)
        tabBarController?.selectedIndex = indexPath.row
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 400)
//    }
    
}
