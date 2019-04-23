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
    private let cellID = "cellID"
    
    // Auto-sizing for cells
    let autoSizingCellLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
//        layout.estimatedItemSize = CGSize(width: width, height: 100)
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()
    
    // Navigation Bar Images
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "zac_perna.jpeg") // assign the image from Firebase here
        return imageView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        collectionView?.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = autoSizingCellLayout
        configureRefreshControl()
        collectionView?.register(PostCellView.self, forCellWithReuseIdentifier: cellID)
    }
    
    func configureRefreshControl() {
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlSelectorTest), for: .valueChanged)
    }
    
    // MARK: - Selectors
    
    @objc func test() {
        print(123)
    }
    
    @objc func refreshControlSelectorTest() {
        print("Refreshing")
    }
    
    // MARK: - CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! PostCellView
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
