//
//  TrainersViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/25/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class TrainersSearchViewController : BaseSearchPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchTrainerCell.self, forCellWithReuseIdentifier: cellId)
        wireUpFilterButton()
    }
    
    private func wireUpFilterButton() {
        super.filterButton.addTarget(self, action: #selector(filterOnPress), for: .touchUpInside)
    }
    
    @objc private func filterOnPress() {
        print("filterOnPress")
    }
    
}

// MARK: - CollectionView

extension TrainersSearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dataSource.count
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: super.cellId, for: indexPath) as? SearchTrainerCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: super.CELL_WIDTH, height: super.CELL_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
}
