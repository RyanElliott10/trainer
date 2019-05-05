//
//  SearchViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    private let cellReuseID = "cellID"
    private let headerTrainerReuseID = "headerID"
    let searchController = UISearchController(searchResultsController: nil)
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search"
        search.translatesAutoresizingMaskIntoConstraints = false
        search.sizeToFit()
        search.barStyle = .default
        return search
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Configurations
    
    private func configureViews() {
        view.backgroundColor = .white
        configureCollectionView()
        configureSearchBar()
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .yellow
        collectionView.alwaysBounceVertical = true
        // This causes an issue with the frame. Figure out how to auto resize later
//        collectionView.collectionViewLayout = Constants.AUTOSIZING_FLOW_LAYOUT
        collectionView.register(FeaturedTrainersCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.register(SearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerTrainerReuseID)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 0)
    }
    
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // MARK: - CollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 2
        default: assert(false, "Unexpected number of sections")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as! FeaturedTrainersCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return getHeader(ofKind: kind, for: indexPath)
        default:
            assert(false, "Unexpected element kind")
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2, height: 300)
    }
    
    // MARK: - CollectionView Header
    
    private func getHeader(ofKind kind: String, for indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerTrainerReuseID, for: indexPath) as! SearchHeaderView
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: Constants.SEARCH_SCREEN_HEADER_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
