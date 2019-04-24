//
//  SearchViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    let cellID = "cellID"
    let searchController = UISearchController(searchResultsController: nil)
    // Will have to add the search bar to the UICollectionView's header
    // Will have CollectionView inside each cell
    // Will probably want to hide the navigation bar on the main ViewController, then show it on subsequent ViewControllers
    
    // Auto-sizing for cells
    let autoSizingCellLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 100)
        return layout
    }()
    
    let featuredTrainersLabel: UILabel = {
        let label = UILabel()
        label.text = "Featured Trainers"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Configurations
    
    private func configureViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        configureCollectionView()
//        configureSearchBar()
//        configureFeaturedTrainers()
    }
    
    private func configureCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.collectionViewLayout = autoSizingCellLayout
        collectionView?.register(FeaturedTrainersCell.self, forCellWithReuseIdentifier: cellID)
//        collectionView?.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: <#T##String#>)
        collectionView?.register(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>)
    }
    
    private func configureFeaturedTrainers() {
        view.addSubview(featuredTrainersLabel)
        featuredTrainersLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 16, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: - CollectionView
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! FeaturedTrainersCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
