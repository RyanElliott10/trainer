//
//  HomeViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

import AMScrollingNavbar
import FloatingPanel

protocol HomeViewControllerDelegate {
    func push(viewController controller: UIViewController)
}

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    private let refreshControl = UIRefreshControl()
    private let cellReuseID = "cellID"
    private let imageCellReuseID = "imageCellReuseID"
    private let storyReuseID = "storyID"
    private let floatingPanelController = FloatingPanelController()
    private let postBottomSheetController = PostBottomSheetViewController()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return collectionView
    }()
    
    // MARK: - Init
    
    // AMScrollingNavbar override
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.followScrollView(collectionView, delay: 0.0)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let navigationController = navigationController as? ScrollingNavigationController {
            navigationController.stopFollowingScrollView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        configureStatusBar()
        addBottomSheetView()
    }
    
    private func configureStatusBar() {
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = Constants.Global.BACKGROUND_COLOR
        view.addSubview(statusBarView)
    }
    
    private func addBottomSheetView() {
        configureFloatingPanel()
    }
    
    private func configureFloatingPanel() {
        let backdropTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackdrop(tapGesture:)))
        floatingPanelController.backdropView.addGestureRecognizer(backdropTapGesture)
        
        floatingPanelController.delegate = self
        postBottomSheetController.controllerDelegate = floatingPanelController
        floatingPanelController.view.topShadow()
        
        floatingPanelController.surfaceView.cornerRadius = 12
        floatingPanelController.set(contentViewController: postBottomSheetController)
        floatingPanelController.addPanel(toParent: self)
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
            flowLayout.itemSize = UICollectionViewFlowLayout.automaticSize
            flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.size.width - 24, height: 2000)
        }
        
        collectionView.register(ModernPostCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.register(ImageModernPostCell.self, forCellWithReuseIdentifier: imageCellReuseID)
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
        floatingPanelController.move(to: .full, animated: true)
    }
    
    @objc func navigationProfileImageOnPress() {
        debugPrint("Navigation profile image on press")
    }
    
    @objc private func refreshControlSelectorTest() {
        debugPrint("Refreshing")
        collectionView.refreshControl?.endRefreshing()
    }
    
    @objc private func handleSurface(tapGesture gesture: UITapGestureRecognizer) {
        if floatingPanelController.position == .full {
            postBottomSheetController.textView.resignFirstResponder()
        } else {
            let nextPosition = getNextFloatingPanelPosition()
            showKeyboardIfNeeded(forPosition: nextPosition)
            floatingPanelController.move(to: nextPosition, animated: true)
        }
    }
    
    @objc private func handleBackdrop(tapGesture gesture: UITapGestureRecognizer) {
        floatingPanelController.move(to: .tip, animated: true)
    }
    
    private func getNextFloatingPanelPosition() -> FloatingPanelPosition {
        if let position = FloatingPanelPosition(rawValue: floatingPanelController.position.rawValue - 1) {
            return position
        }
        return .full
    }
    
    private func showKeyboardIfNeeded(forPosition position: FloatingPanelPosition) {
        if position == .full {
            postBottomSheetController.textView.becomeFirstResponder()
        }
    }
    
}

// MARK: - CollectionView

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Post.generateDummyPosts().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? ModernPostCell {
            cell.homeViewDelegate = self
            cell.post = Post.generateDummyPosts()[indexPath.item]
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedPostViewController = DetailedPostViewController()
        detailedPostViewController.post = Post.generateDummyPosts()[indexPath.item]
        
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
            bottomInsetHeight = height
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

extension HomeViewController: FloatingPanelControllerDelegate {
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return HomeScreenFloatingPanelLayout()
    }
    
    func floatingPanelDidChangePosition(_ vc: FloatingPanelController) {
        if vc.position == .half {
            postBottomSheetController.textView.resignFirstResponder()
        }
    }
    
}

class HomeScreenFloatingPanelLayout: FloatingPanelLayout {
    
    var initialPosition: FloatingPanelPosition {
        return .tip
    }
    
    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 16.0  // A top inset from safe area
        case .half: return 216.0 // A bottom inset from the safe area
        case .tip: return 44.0   // A bottom inset from the safe area
        default: return nil      // Or `case .hidden: return nil`
        }
    }
    
}
