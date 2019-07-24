//
//  BaseWelcomeViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/4/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class BaseWelcomeViewController: UIViewController {
    
    // MARK: - UI
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = .white
        button.backgroundColor = .appPrimary
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.backgroundColor = .clear
        pageViewController.delegate = self
        pageViewController.dataSource = self
        return pageViewController
    }()
    
    var homeControllerDelegate: HomeViewController!
    private var viewControllers = [UIViewController]()
    private var currentIndex = 0
    
    // MARK: - Init
    
    override func viewDidLayoutSubviews() {
        createGradientLayer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubViews()
    }
    
    private func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = continueButton.bounds
        gradientLayer.colors = [UIColor.appPrimary.cgColor, UIColor.appSecondary.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.0, 1.0]
        continueButton.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func configureSubViews() {
        view.backgroundColor = .white
        configureContinueButton()
        configurePageViewController()
    }
    
    private func configureContinueButton() {
        view.addSubview(continueButton)
        continueButton.addTarget(self, action: #selector(continuePress), for: .touchUpInside)
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            continueButton.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    private func configurePageViewController() {
        let vc0 = ExperimentalSignInWithApple()
        let vc1 = WelcomeViewController()
        let vc2 = WelcomeViewController()
        let vc3 = WelcomeAccountViewController()
        vc3.baseWelcomeDelegate = self
        viewControllers.append(vc0)
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        pageViewController.setViewControllers([viewControllerAtIndex(0)!], direction: .forward, animated: false, completion: nil)
        
        view.addSubview(pageViewController.view)
        pageViewController.view.anchor(top: view.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: continueButton.topAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
    }
    
    // MARK: - Selectors
    
    @objc private func continuePress() {
        if let labelText = continueButton.titleLabel?.text {
            if let buttonState = WelcomeControllers.init(rawValue: labelText) {
                    switch buttonState {
                    case .Continue: print("Continue")
                    case .SignUp: dismiss(animated: true, completion: nil)
                    case .Login: dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}

// MARK: - PageViewController

extension BaseWelcomeViewController : UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
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
            if let vcs = pageViewController.viewControllers {
                currentIndex = indexOfViewController(vcs[0])
                if currentIndex == viewControllers.count - 1 {
                    if let vc = viewControllers[2] as? WelcomeAccountViewController {
                        vc.setButtonTitle()
                    }
                } else {
                    continueButton.setTitle(WelcomeControllers.Continue.rawValue, for: .normal)
                }
            }
        }
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        setupPageControl()
        return viewControllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

extension BaseWelcomeViewController {
    
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
