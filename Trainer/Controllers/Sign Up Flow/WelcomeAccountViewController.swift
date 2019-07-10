//
//  WelcomeAccountViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/5/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class WelcomeAccountViewController: UIViewController {
    
    // MARK: - UI
    
    private let headerView: WelcomeAccountHeaderView = {
        let header = WelcomeAccountHeaderView()
        header.dropShadow()
        return header
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        return pageViewController
    }()
    
    // MARK: - Properties
    
    private var viewControllers = [UIViewController]()
    var currentIndex = 0
    var baseWelcomeDelegate: BaseWelcomeViewController?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSubViews()
    }
    
    private func configureSubViews() {
        configureHeaderView()
        configurePageViewController()
    }
    
    private func configureHeaderView() {
        headerView.welcomeAccountDelegate = self
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200)
    }
    
    private func configurePageViewController() {
        let vc1 = SignUpViewController()
        let vc2 = LoginViewController()
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.setViewControllers([viewControllerAtIndex(0)!], direction: .forward, animated: false, completion: nil)
        
        view.addSubview(pageViewController.view)
        pageViewController.view.anchor(top: headerView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    func setButtonTitle() -> WelcomeControllers {
        if currentIndex == 0 {
            baseWelcomeDelegate?.continueButton.setTitle(WelcomeControllers.SignUp.rawValue, for: .normal)
            return WelcomeControllers.SignUp
        } else {
            baseWelcomeDelegate?.continueButton.setTitle(WelcomeControllers.Login.rawValue, for: .normal)
            return WelcomeControllers.Login
        }
    }
    
    func switchTo(viewController controllerType: WelcomeControllers) {
        if controllerType == .Login {
            pageViewController.setViewControllers([viewControllers[1]], direction: .forward, animated: true, completion: nil)
        } else {
            pageViewController.setViewControllers([viewControllers[0]], direction: .reverse, animated: true, completion: nil)
        }
        headerView.updateBarPosition(to: controllerType)
    }
    
}

// MARK: - PageViewController

extension WelcomeAccountViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance(whenContainedInInstancesOf: [UIPageViewController.self])
        appearance.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.5)
        appearance.currentPageIndicatorTintColor = UIColor.lightGray
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        if index == 0 {
            return nil
        }
        index -= 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController)
        if index == viewControllers.count - 1 {
            return nil
        }
        index += 1
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            var title: WelcomeControllers = .Continue
            if let vcs = pageViewController.viewControllers {
                currentIndex = indexOfViewController(vcs[0])
                title = setButtonTitle()
            }
            headerView.updateBarPosition(to: title)
        }
    }
    
}

extension WelcomeAccountViewController {
    
    fileprivate func viewControllerAtIndex(_ index: Int) -> UIViewController? {
        if viewControllers.count == 0 || index >= viewControllers.count {
            return nil
        }
        return viewControllers[index]
    }
    
    fileprivate func indexOfViewController(_ viewController: UIViewController) -> Int {
        return viewControllers.firstIndex(of: viewController) ?? NSNotFound
    }
    
}
