//
//  ProgressViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    private let workoutCellReuseId = "WorkoutCellReuseId"
    private let headerCellReuseId = "HeaderCellReuseId"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 6, left: 8, bottom: 0, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Your Journey"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]
        
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(WorkoutCell.self, forCellWithReuseIdentifier: workoutCellReuseId)
        collectionView.register(TrackMiniHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellReuseId)
        collectionView.contentInset = UIEdgeInsets(top: 6, left: 8, bottom: Constants.HomeScreen.TIP_PADDING + 8, right: 8)
//        setupCollectionViewLayout()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
}

extension ProgressViewController: UICollectionViewDelegateFlowLayout {
    
    fileprivate func setupCollectionViewLayout() {
        if #available(iOS 13.0, *) {
            // TODO: - Figure out how to add Supplementary Views
            let size = NSCollectionLayoutSize(
                widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
                heightDimension: NSCollectionLayoutDimension.estimated(440)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: size)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            
            section.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 8, bottom: Constants.HomeScreen.TIP_PADDING + 8, trailing: 8)
            section.interGroupSpacing = 12
            
            let layout = UICollectionViewCompositionalLayout(section: section)
            collectionView.collectionViewLayout = layout
        } else {
//            collectionView.collectionViewLayout = CustomFlowLayout()
            // TODO: - Allow for use of CustomFlowLayout on <= iOS 12
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 24, height: 440)
            collectionView.collectionViewLayout = layout
            collectionView.contentInset = UIEdgeInsets(top: 8, left: 12, bottom: Constants.HomeScreen.TIP_PADDING + 8, right: 12)
        }
    }
    
}

extension ProgressViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let topColor = UIColor.rgb(red: 240, green: 130, blue: 101)
        let bottomColor = UIColor.rgb(red: 244, green: 104, blue: 62)
        let data = WorkoutDatasource(title: "Legs", dayOfWeek: .monday, workouts: [], trainer: "Zac Perna")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: workoutCellReuseId, for: indexPath) as! WorkoutCell
        cell.datasource = data
        cell.gradients = [topColor.cgColor, bottomColor.cgColor]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellReuseId, for: indexPath) as! TrackMiniHeaderView
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 8, bottom: 0, right: 8)
    }
    
    // Delete in favor of self sizing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 16, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 16, height: 350)
    }
    
}
