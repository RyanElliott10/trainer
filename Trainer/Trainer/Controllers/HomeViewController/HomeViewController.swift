//
//  HomeViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let refreshControl = UIRefreshControl()
    private let cellReuseID = "cellID"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureViews()
    }
    
    // MARK: - Configuration
    
    func configureViews() {
        view.backgroundColor = .white
        configureNavBar()
        configureCollectionView()
        configureWhiteStatusBar()
    }
    
    private func configureNavBar() {
        configureNavBarItems()
    }
    
    private func configureWhiteStatusBar() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor.rgb(red: 255, green: 255, blue: 255)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        collectionView.collectionViewLayout = Constants.Cell.AUTOSIZING_FLOW_LAYOUT
        collectionView.register(PostCellView.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.delaysContentTouches = false
        
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlSelectorTest), for: .valueChanged)
    }
    
    // MARK: - Selectors
    
    @objc func postOnPress() {
        print("Post on press")
    }
    
    @objc func navigationProfileImageOnPress() {
        print("Navigation profile image on press")
    }
    
    @objc func refreshControlSelectorTest() {
        print("Refreshing")
        collectionView.refreshControl?.endRefreshing()
    }
    
}

// MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Post.generateDummyPosts().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell was selected at:", indexPath.row)
        
        navigationController?.pushViewController(ProgressViewController(), animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.rgb(red: 235, green: 235, blue: 235)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .white
    }
    
}
