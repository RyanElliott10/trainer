//
//  ExperimentalViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/20/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

/**
 *  BIG FIND: https://stackoverflow.com/questions/44187881/uicollectionview-full-width-cells-allow-autolayout-dynamic-height
 */

import UIKit

class ExperimentalViewController: UIViewController {
    
    private let cellReuseId = "cellReuseId"
    fileprivate var data = [
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells."
    ]
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.alwaysBounceVertical = true
        collection.contentInsetAdjustmentBehavior = .always
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        if #available(iOS 13.0, *) {
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.estimated(44)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: size)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
            section.interGroupSpacing = 5
            
            let layout = UICollectionViewCompositionalLayout(section: section)
            collectionView.collectionViewLayout = layout
        } else {
            let layout = ExperimentalFlowLayout()
            collectionView.collectionViewLayout = layout
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ExperimentalCell.self, forCellWithReuseIdentifier: cellReuseId)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}

extension ExperimentalViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as! ExperimentalCell
        cell.backgroundColor = .yellow
        if indexPath.item == 1 {
            cell.imageView.image = UIImage(named: "boxed-water-is-better-1464052-unsplash")
        }
        cell.setupViews(withDatasource: data[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
