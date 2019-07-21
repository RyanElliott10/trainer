//
//  ExperimentalViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/20/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ExperimentalViewController: UIViewController {
    
    private let cellReuseId = "cellReuseId"
    private let imageCellReuseId = "imageCellReuseId"
    fileprivate var data = [(String, [UIImage])]()
    fileprivate var strings = [
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
        "This is a short string.",
        "This is a substantially longer string than the previous, but not crazy long.",
        "This is a stupid long string that will actually test the self-sizing ability of the cell. There is no better way to do this -- that I can think of right now -- so this is how we'll have to go about this. We shall see what this longer string actually produces.",
        "This is a shorter string. We're testing the self-sizing ability of cells.",
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
        
        setupDummyData()
        setupCollectionView()
    }
    
    private func setupDummyData() {
        for (i, str) in strings.enumerated() {
            var images = [UIImage]()
            if i % 2 == 0 {
                images = [UIImage(named: "boxed-water-is-better-1464052-unsplash")!, UIImage(named: "boxed-water-is-better-1464052-unsplash")!, UIImage(named: "boxed-water-is-better-1464052-unsplash")!]
            }
            data.append((str, images))
        }
    }
    
    private func setupCollectionView() {
        // BIG FIND: https://stackoverflow.com/questions/44187881/uicollectionview-full-width-cells-allow-autolayout-dynamic-height
        if #available(iOS 13.0, *) {
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.estimated(440)
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
        collectionView.register(ExperimentalCell.self, forCellWithReuseIdentifier: imageCellReuseId)
        
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
}

extension ExperimentalViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    /// See: https://stackoverflow.com/questions/57135977/how-to-fix-images-disappearing-from-uicollectionviewcell-on-scroll/57136811#57136811
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Must use two cellIds to ensure the cells are reused properly. My best guess is this has to do with the self-sizing
        let reuseId = data[indexPath.item].1.count > 0 ? imageCellReuseId : cellReuseId
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseId, for: indexPath) as! ExperimentalCell
        cell.index = indexPath
        cell.backgroundColor = .yellow
        cell.setupViews(withDatasource: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
}
