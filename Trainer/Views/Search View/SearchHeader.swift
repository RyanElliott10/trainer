//
//  SearchHeader.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/23/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SearchHeader: UIView {
    
    private let cellID = "cellID"
    private let HEADER_INSET: CGFloat = 24
    private lazy var CELL_WIDTH: CGFloat = (frame.width - (HEADER_INSET * 2)) / CGFloat(CELL_COUNT)
    //    private let labels = ["Trainers", "Gyms", "Workouts"]
    private let labels = ["Trainers", "Gyms"]
    private lazy var CELL_COUNT = labels.count
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.backgroundColor = .clear
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private lazy var labelsView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isScrollEnabled = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(SearchHeaderCell.self, forCellWithReuseIdentifier: cellID)
        return cv
    }()
    
    let highlightBar: UIView = {
        let bar = UIView()
        bar.backgroundColor = .white
        bar.layer.cornerRadius = 2
        return bar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        // Call configureSubViews in here to avoid covering views
        createGradientLayer()
        configureSubViews()
    }
    
    private func configureSubViews() {
        configureSearchBar()
        configureLabelsView()
        configureHighlightBar()
        dropShadow(withHeight: 2, opacity: 0.2, radius: 2)
    }
    
    private func createGradientLayer() {
        let startColor = UIColor.rgb(red: 126, green: 164, blue: 245).cgColor
        let endColor = UIColor.appPrimary.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor, endColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        layer.addSublayer(gradientLayer)
    }
    
    private func configureSearchBar() {
        addSubview(searchBar)
        
        searchBar.anchor(top: safeAreaLayoutGuide.topAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func configureLabelsView() {
        addSubview(labelsView)
        labelsView.backgroundColor = .clear
        // TODO: - Add anchors to search bar rather than specifying the height
        labelsView.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: HEADER_INSET, paddingBottom: 3, paddingRight: HEADER_INSET, width: 0, height: 50)
    }
    
    private func configureHighlightBar() {
        addSubview(highlightBar)
        highlightBar.anchor(top: labelsView.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: nil, paddingTop: 0, paddingLeft: HEADER_INSET, paddingBottom: 0, paddingRight: HEADER_INSET, width: 100, height: 0)
    }
    
}

extension SearchHeader : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? SearchHeaderCell {
            cell.labelText = labels[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CELL_COUNT
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CELL_WIDTH, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        swipeControllerDelegate?.switchToTab(atIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SearchHeaderCell {
            cell.label.textColor = UIColor.white.withAlphaComponent(0.5)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SearchHeaderCell {
            cell.label.textColor = .white
        }
    }
    
}
