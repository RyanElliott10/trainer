//
//  SwipeController.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/22/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SwipeController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellID"
    private let NUM_PAGES: CGFloat = 3
    private let searchController = UISearchController(searchResultsController: nil)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = Constants.Global.BACKGROUND_COLOR
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var headerView: SearchHeader = {
        let header = SearchHeader(frame: .zero)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubViews()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureSubViews() {
        configureHeader()
        configureCollectionView()
    }
    
    private func configureHeader() {
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 135)
    }
    
    private func configureCollectionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        collectionView.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func switchToTab(atIndexPath indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .clear
        if indexPath.row == 1 {
            cell.backgroundColor = .red
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(NUM_PAGES)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Used to move the highlight bar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newPage = ceil(collectionView.contentOffset.x / collectionView.frame.width)
        let collectionViewWidth = collectionView.frame.width * NUM_PAGES
        let percentComplete = collectionView.contentOffset.x / collectionViewWidth
        let x = ceil((collectionView.frame.width - 48) * percentComplete + 24) + newPage
        
        let oldFrame = headerView.highlightBar.frame
        let newFrame = CGRect(x: x, y: oldFrame.origin.y, width: oldFrame.width, height: oldFrame.height)
        headerView.highlightBar.frame = newFrame
    }
    
}
