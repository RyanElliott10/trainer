//
//  SearchViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/22/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let cellID = "cellID"
    private let NUM_PAGES: CGFloat = 2
    private let HEADER_HEIGHT: CGFloat = 135
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var viewControllers = [BaseSearchPageViewController]()
    
    private var startOffset: CGFloat = 0
    private var direction = 0
    
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.backgroundColor = .clear
        pageViewController.delegate = self
        pageViewController.dataSource = self
        return pageViewController
    }()
    
    lazy var headerView: SearchHeader = {
        let header = SearchHeader(frame: .zero)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubViews()
        setPageViewScrollViewDelegate()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setPageViewScrollViewDelegate() {
        for v in pageViewController.view.subviews {
            if v is UIScrollView {
                (v as! UIScrollView).delegate = self
                break
            }
        }
    }
    
    private func configureSubViews() {
        view.backgroundColor = Constants.Global.BACKGROUND_COLOR
        configureHeader()
        configurePageViewController()
    }
    
    private func configureHeader() {
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: HEADER_HEIGHT)
    }
    
    private func configurePageViewController() {
        let vc1 = TrainersSearchViewController()
        vc1.label.text = "1"
        let vc2 = GymsSearchViewController()
        vc2.label.text = "2"
        let vc3 = WorkoutsSearchViewController()
        vc3.label.text = "3"
        
        viewControllers.append(vc1)
        viewControllers.append(vc2)
//        viewControllers.append(vc3)
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.view.frame = CGRect(x: 0, y: HEADER_HEIGHT, width: view.frame.width, height: view.frame.height - HEADER_HEIGHT)
        pageViewController.didMove(toParent: self)
        
        pageViewController.setViewControllers([viewControllerAtIndex(0)!], direction: .forward, animated: false, completion: nil)
    }
    
}

extension SearchViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! BaseSearchPageViewController)
        if index == 0 {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! BaseSearchPageViewController)
        if index == viewControllers.count - 1 {
            return nil
        }
        index += 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if previousViewControllers.count > 0 {
            // We know it's not the first viewController
            if var newIndex = viewControllers.firstIndex(of: previousViewControllers[0] as! BaseSearchPageViewController) {
                newIndex += (direction > 0 ? 1 : -1)
                
                let oldFrame = headerView.highlightBar.frame
                let strictFrame = (view.frame.width - (24 * 3)) / 3
                let x = strictFrame * CGFloat(newIndex)
                let newFrame = CGRect(x: x, y: oldFrame.origin.y, width: oldFrame.width, height: oldFrame.height)
                headerView.highlightBar.frame = newFrame
            }
        }
    }
    
}

extension SearchViewController {
    
    fileprivate func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if viewControllers.count == 0 || index >= viewControllers.count {
            return nil
        }
        return viewControllers[index]
    }
    
    fileprivate func indexOfViewController(_ viewController: BaseSearchPageViewController) -> Int {
        return viewControllers.firstIndex(of: viewController) ?? NSNotFound
    }
    
}

extension SearchViewController: UIScrollViewDelegate {
    
    // Used to move the highlight bar
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        let newPage = ceil(collectionView.contentOffset.x / collectionView.frame.width)
        //        let collectionViewWidth = collectionView.frame.width * NUM_PAGES
        //        let percentComplete = collectionView.contentOffset.x / collectionViewWidth
        //        let x = ceil((collectionView.frame.width - 48) * percentComplete + 24) + newPage
        //
        //        let oldFrame = headerView.highlightBar.frame
        //        let newFrame = CGRect(x: x, y: oldFrame.origin.y, width: oldFrame.width, height: oldFrame.height)
        //        headerView.highlightBar.frame = newFrame
        
        if startOffset < scrollView.contentOffset.x {
            direction = 1 // Going right
        } else if startOffset > scrollView.contentOffset.x {
            direction = -1 // Going left
        }
        startOffset = scrollView.contentOffset.x
        
        let positionFromStartOfCurrentPage = abs(startOffset - scrollView.contentOffset.x)
        var percent = positionFromStartOfCurrentPage / view.frame.width
        let newPage = ceil(percent)
        percent /= NUM_PAGES
        //        print("Percent:", percent)
        //        print("New page:", newPage)
    }
    
}
