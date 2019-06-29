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

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    private let refreshControl = UIRefreshControl()
    private let cellReuseID = "cellID"
    private let storyReuseID = "storyID"
    private let postBottomSheetVC = PostBottomSheetViewController()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsVerticalScrollIndicator = false
        
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
        
        configureViews()
        addBottomSheetView()
        
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = Constants.Global.BACKGROUND_COLOR
        view.addSubview(statusBarView)
    }

    func addBottomSheetView() {
        addChild(postBottomSheetVC)
        view.addSubview(postBottomSheetVC.view)
        postBottomSheetVC.didMove(toParent: self)
        
        let yOrig = tabBarController?.tabBar.frame.height ?? 0
        let height = view.frame.height
        let width = view.frame.width
        postBottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.height - (yOrig + 60), width: width, height: height)
    }
    
    // MARK: - Configuration
    
    func configureViews() {
        view.backgroundColor = Constants.Global.BACKGROUND_COLOR
        view.addSubview(collectionView)
        
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
        let statusBarColor = UIColor.white
        statusBarView.backgroundColor = statusBarColor
        view.addSubview(statusBarView)
    }
    
    private func configureCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width - 24, height: 1)
        }
        
        collectionView.register(HomeScreenPostCellView.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.register(HomeScreenStoryCellView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: storyReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 12, bottom: 0, right: 12)
        
        collectionView.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlSelectorTest), for: .valueChanged)
    }
    
    // MARK: - Selectors
    
    @objc func postOnPress() {
        presentPostVC()
    }
    
    @objc func navigationProfileImageOnPress() {
        debugPrint("Navigation profile image on press")
    }
    
    @objc private func refreshControlSelectorTest() {
        debugPrint("Refreshing")
        collectionView.refreshControl?.endRefreshing()
    }
    
    func presentPostVC() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
            self.postBottomSheetVC.view.frame = CGRect(x: 0, y: self.postBottomSheetVC.fullViewTopInset, width: self.postBottomSheetVC.view.frame.width, height: self.postBottomSheetVC.view.frame.height)
        }, completion: nil)
    }
    
}

// MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Post.generateDummyPosts().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? HomeScreenPostCellView {
            let post = Post.generateDummyPosts()[indexPath.row]
            cell.post = post
            cell.homeViewDelegate = self
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var bottomInsetHeight: CGFloat = 0
        if let height = tabBarController?.tabBar.frame.height {
            bottomInsetHeight = height + 40
        }
        return UIEdgeInsets(top: 12, left: 0, bottom: bottomInsetHeight, right: 0)
    }
    
    // MARK: - CollectionView Header
        
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: storyReuseID, for: indexPath) as? HomeScreenStoryCellView {
                cell.stories = Story.generateDummyStoryData()
                return cell
            }
            return UICollectionReusableView()
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 1, height: 275)
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
