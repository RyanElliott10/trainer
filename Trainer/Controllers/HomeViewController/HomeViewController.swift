//
//  HomeViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

import AMScrollingNavbar
import PanModal

protocol HomeViewControllerDelegate {
    func push(viewController controller: UIViewController)
}

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    
    private let refreshControl = UIRefreshControl()
    private let cellReuseID = "cellID"
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    // TODO: - Before going any further, take a look at Slack's open source slider on GitHub
    let postBarContainer: UIView = {
        // TODO: - Add indicator showing you can slide it up, and textfield
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.cornerRadius = 8
        view.topShadow()
        
        return view
    }()
    
    let createPostLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Create a Post"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        
        return label
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
    }
    
    // MARK: - Configuration
    
    func configureViews() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(postBarContainer)
        
        configureNavBar()
        configureTabBar()
        configurePostBar()
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
    
    private func configurePostBar() {
        let upSwipe = UIPanGestureRecognizer(target: self, action: #selector(presentScrollablePostVC(_:)))
        upSwipe.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentPostVC(_:)))
        tap.delegate = self
        
        postBarContainer.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: -8, paddingRight: 0, width: 0, height: Constants.HomeScreen.POST_CONTAINER_HEIGHT)
        postBarContainer.addGestureRecognizer(upSwipe)
        postBarContainer.addGestureRecognizer(tap)
        
        postBarContainer.addSubview(createPostLabel)
        createPostLabel.anchor(top: postBarContainer.topAnchor, leading: postBarContainer.leadingAnchor, bottom: nil, trailing: postBarContainer.trailingAnchor, paddingTop: 8, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
    }
    
    private func configureCollectionView() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width - 24, height: 1)
        }
        
        collectionView.register(HomeScreenPostCellView.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        
        collectionView.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        collectionView.refreshControl = refreshControl
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshControlSelectorTest), for: .valueChanged)
    }
    
    // MARK: - Swipe Gesture
    
    func wasDragged(gesture: UIPanGestureRecognizer) {
        print("wasDragged", gesture)
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
    
    @objc private func refreshControlSelectorTest() {
        print("Refreshing")
        collectionView.refreshControl?.endRefreshing()
    }
    
    @objc private func presentScrollablePostVC(_ gesture: UIPanGestureRecognizer) {
        var tabBarFrame = tabBarController?.tabBar.frame
        tabBarFrame?.origin.y = view.frame.height
        // If the user is dragging
        if gesture.state == .began || gesture.state == .changed {
            let translation = gesture.translation(in: self.view)
            
            // If the user is dragging up
            if -translation.y > 0 {
                if let constraint = (postBarContainer.constraints.filter{$0.firstAttribute == .height}.first) {
                    // PostBarContainer translation
                    constraint.constant = -translation.y + Constants.HomeScreen.POST_CONTAINER_HEIGHT
                    
                    // TabBar translation
                    if let tabBar = tabBarController?.tabBar {
                        let origin = CGPoint(x: tabBar.frame.origin.x, y: view.frame.height - (translation.y * 0.5))
                        let frame = CGRect(origin: origin, size: CGSize(width: tabBar.frame.width, height: tabBar.frame.height))
                        tabBar.frame = frame
                    }
                    
                    // Return to normal state
                    if (-translation.y + Constants.HomeScreen.POST_CONTAINER_HEIGHT >= 200) {
                        tabBarController?.presentPanModal(PostPanModalViewController())
                        constraint.constant = Constants.HomeScreen.POST_CONTAINER_HEIGHT
                        UIView.animate(withDuration: 0.0, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                            if let tabBar = self.tabBarController?.tabBar {
                                let origin = CGPoint(x: tabBar.frame.origin.x, y: self.view.frame.height)
                                let frame = CGRect(origin: origin, size: CGSize(width: tabBar.frame.width, height: tabBar.frame.height))
                                tabBar.frame = frame
                            }
                            self.view.layoutIfNeeded()
                        }, completion: nil)
                    }
                }
            }
        } else if gesture.state == .ended {
            if let constraint = (self.postBarContainer.constraints.filter{$0.firstAttribute == .height}.first) {
                constraint.constant = Constants.HomeScreen.POST_CONTAINER_HEIGHT
            }
            UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                if let tabBar = self.tabBarController?.tabBar {
                    tabBar.frame = tabBarFrame!
                }
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    @objc private func presentPostVC(_ gesture: UITapGestureRecognizer) {
        tabBarController?.presentPanModal(PostPanModalViewController(), sourceView: postBarContainer)
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
        return 16
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
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
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
