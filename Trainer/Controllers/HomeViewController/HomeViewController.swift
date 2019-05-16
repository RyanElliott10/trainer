//
//  HomeViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit
import AMScrollingNavbar

protocol HomeViewControllerDelegate {
    func push(viewController controller: UIViewController)
}

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let refreshControl = UIRefreshControl()
    private let cellReuseID = "cellID"
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // MARK: - Init
    
    // AMScrollingNavbar override
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = self.navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(collectionView, delay: 50.0)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureViews()
    }
    
    // MARK: - Configuration
    
    func configureViews() {
        view.backgroundColor = .white
        configureNavBar()
        configureTabBar()
        configureCollectionView()
        configureWhiteStatusBar()
    }
    
    private func configureNavBar() {
        configureNavBarItems()
    }
    
    private func configureTabBar() {
        tabBarController?.delegate = self
    }
    
    private func configureWhiteStatusBar() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        let statusBarColor = UIColor.rgb(red: 255, green: 255, blue: 255)
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    private func configureCollectionView() {
        view.addSubview(collectionView)
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width, height: 1)
        }
        
        collectionView.register(PostCellView.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.delaysContentTouches = false
        
        collectionView.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        configureRefreshControl()
    }
    
    func configureRefreshControl() {
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlSelectorTest), for: .valueChanged)
    }
    
    // MARK: - Selectors
    
    @objc func postOnPress() {
        let transition: CATransition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.moveIn
        transition.subtype = .fromTop
        
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.pushViewController(PostViewController(), animated: false)
    }
    
    @objc func navigationProfileImageOnPress() {
        print("Navigation profile image on press")
    }
    
    @objc func refreshControlSelectorTest() {
        print("Refreshing")
        collectionView.refreshControl?.endRefreshing()
    }
    
}

// MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Post.generateDummyPosts().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? PostCellView {
            let post = Post.generateDummyPosts()[indexPath.row]
            cell.postDataSource = post
            cell.homeViewDelegate = self
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedPostViewController = DetailedPostViewController()
        detailedPostViewController.post = Post.generateDummyPosts()[indexPath.row]
        
        navigationController?.pushViewController(detailedPostViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = UIColor.rgb(red: 235, green: 235, blue: 235)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.backgroundColor = .white
    }
    
}

extension HomeViewController: UITabBarControllerDelegate {
    
    // TODO: - Only scroll to top if current VC is HomeViewController
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 0, tabBarController.selectedIndex == 0 {
            if let _ = view.window?.rootViewController as? HomeViewController {
                return
            }
            if let navigationController = navigationController as? ScrollingNavigationController {
                navigationController.showNavbar(animated: true)
            }
            
            // Calculate correct height from top of screen to bottom of nav bar
            let barHeight = navigationController?.navigationBar.frame.height ?? 0
            let statusBarHeight = UIApplication.shared.statusBarFrame.height
            let yOffset = barHeight + statusBarHeight
            
            collectionView.setContentOffset(CGPoint(x: 0, y: -yOffset), animated: true)
        }
    }
    
}

extension HomeViewController: HomeViewControllerDelegate {
    
    func push(viewController controller: UIViewController) {
        let transition: CATransition = CATransition()
        transition.duration = 0.1
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .fade
        
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        tabBarController?.present(controller, animated: true)
    }
    
}
