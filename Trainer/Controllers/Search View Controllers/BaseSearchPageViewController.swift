//
//  BaseSearchViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/25/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class BaseSearchPageViewController : UIViewController {
    
    // MARK: - Properties
    
    let cellId = "cellId"
    let CELL_HEIGHT: CGFloat = 105
    lazy var CELL_WIDTH: CGFloat = view.frame.width - 24
    var dataSource = Array<SearchDataSource>()
    
    let filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Filter", for: .normal)
        button.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        return collectionView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubViews()
    }
    
    func configureSubViews() {
        view.backgroundColor = .clear
        configureFilterButton()
        configureCollectionView()
    }
    
    private func configureFilterButton() {
        view.addSubview(filterButton)
        filterButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 90, height: 30)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(top: filterButton.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}
