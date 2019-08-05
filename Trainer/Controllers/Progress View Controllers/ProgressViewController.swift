//
//  ProgressViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    // DELETE THIS
    private let progressDatasource = ProgressDatasource.generateDummyData()
    private let workoutDatasource = WorkoutDatasource.generateDummyData()
    
    private let workoutCellReuseId = "WorkoutCellReuseId"
    private let progressCellReuseId = "ProgressCellReuseId"
    private let headerCellReuseId = "HeaderCellReuseId"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionInset = UIEdgeInsets(top: 6, left: 8, bottom: 0, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Your Progress"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]
        
        setupRightNavBarItem()
        setupCollectionView()
    }
    
    private func setupRightNavBarItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus-circle"), style: .plain, target: self, action: #selector(plusOnPress))
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(WorkoutCell.self, forCellWithReuseIdentifier: workoutCellReuseId)
        collectionView.register(ProgressView.self, forCellWithReuseIdentifier: progressCellReuseId)
        collectionView.register(ProgressHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellReuseId)
//        setupCollectionViewLayout()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc private func plusOnPress() {
        tabBarController?.present(AddWorkoutViewController(), animated: true)
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return progressDatasource.count
        case 1: return workoutDatasource.count
        default: return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let topColor = UIColor.rgb(red: 101, green: 170, blue: 240)
            let bottomColor = UIColor.rgb(red: 62, green: 202, blue: 244)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: progressCellReuseId, for: indexPath) as! ProgressView
            cell.gradients = [topColor.cgColor, bottomColor.cgColor]
            cell.datasource = progressDatasource[indexPath.row]
            #warning("Directly call setup views to avoid recursive overflow. The datasource has a mutating func, and setting a didSet on the datasource will endlessly call itself. Listen to me.")
            cell.setupViews()
            
            return cell
        case 1:
            let topColor = UIColor.rgb(red: 244, green: 104, blue: 62)
            let bottomColor = UIColor.rgb(red: 240, green: 133, blue: 101)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: workoutCellReuseId, for: indexPath) as! WorkoutCell
            cell.datasource = workoutDatasource[indexPath.row]
            cell.gradients = [topColor.cgColor, bottomColor.cgColor]
        
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellReuseId, for: indexPath) as! ProgressHeaderView
        header.title = indexPath.section == 0 ? "Progress" : "Workouts"
        
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 8, bottom: 10, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: UIScreen.main.bounds.width - 16, height: 150)
        } else {
            let bounds = UIScreen.main.bounds.width - 16
            switch progressDatasource[indexPath.row].type {
            case .counter: return CGSize(width: (bounds - 10) * (2 / 5), height: 60)
            case .excerpt: return CGSize(width: (bounds - 10) * (3 / 5), height: 60)
            case .chart: return CGSize(width: bounds, height: 200)
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width - 16, height: 40)
    }
    
}
