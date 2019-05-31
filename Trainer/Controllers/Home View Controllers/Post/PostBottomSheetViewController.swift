//
//  PostBottomSheetViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/17/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

import PanModal

enum ViewState {
    case expanded
    case collapsed
}

class PostBottomSheetViewController: UIViewController, PanModalPresentable {
    
    let fullViewTopInset: CGFloat = Constants.PostBottomSheet.FULL_VIEW_TOP_INSET
    var viewState: ViewState = .collapsed
    var partialView: CGFloat {
        if let height = tabBarController?.tabBar.frame.height {
            return UIScreen.main.bounds.height - (height + 60)
        }
        return UIScreen.main.bounds.height - Constants.PostBottomSheet.FULL_VIEW_TOP_INSET
    }
    var panScrollable: UIScrollView?
    var shortFormHeight: PanModalHeight {
        return .contentHeight(250)
    }
    var longFormHeight: PanModalHeight {
        return .maxHeight
    }
    
    let createPostLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Create a Post"
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .left
        
        return label
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 18)
        view.backgroundColor = .yellow
        
        return view
    }()
    
    let totalActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.addTarget(self, action: #selector(flipBottomSheetExpansion), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addGestureRecognizers()
        configureViews()
    }
    
    private func addGestureRecognizers() {
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeGesture(_:)))
        view.addGestureRecognizer(swipeGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.topShadow()
        
        configureCreatePostLabel()
        configureTextView()
        configureRightActionButton()
    }
    
    private func configureCreatePostLabel() {
        view.addSubview(createPostLabel)
        
        createPostLabel.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 20, paddingLeft: 32, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
    }
    
    private func configureTextView() {
        view.addSubview(textView)
        
        textView.anchor(top: createPostLabel.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 20, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: view.frame.height - 400)
    }
    
    private func configureRightActionButton() {
        view.addSubview(totalActionButton)
        
        totalActionButton.centerYAnchor.constraint(equalTo: createPostLabel.centerYAnchor).isActive = true
        totalActionButton.anchor(top: nil, leading: nil, bottom: nil, trailing: view.trailingAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 32, width: 20, height: 20)
        totalActionButton.setImage(#imageLiteral(resourceName: "arrow-up"), for: .normal)
    }
    
    // MARK: - Animation
    
    func hintToSwipeUp() {
        UIView.animate(withDuration: Constants.PostBottomSheet.AUTOMATED_SLIDE_UP_DOWN_ANIMATION_DURATION / 4, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: [.allowUserInteraction], animations: {
            self.view.frame = CGRect(x: 0, y: self.partialView - 15, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: { (_) in
            UIView.animate(withDuration: Constants.PostBottomSheet.AUTOMATED_SLIDE_UP_DOWN_ANIMATION_DURATION, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [.allowUserInteraction], animations: {
                self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: nil)
        })
    }
    
    func resetToPartialView() {
        print("resetToPartialView state:", viewState)
        if viewState != .collapsed {
            UIView.animate(withDuration: Constants.PostBottomSheet.AUTOMATED_SLIDE_UP_DOWN_ANIMATION_DURATION, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
                self.view.frame = CGRect(x: 0, y: self.partialView, width: self.view.frame.width, height: self.view.frame.height)
                self.view.backgroundColor = .white
                self.tabBarController?.view.backgroundColor = .white
                self.tabBarController?.tabBar.isTranslucent = false;
                self.totalActionButton.transform = self.totalActionButton.transform.rotated(by: .pi)
            }, completion: { (_) in
                self.updateViewState()
            })
        }
    }
    
    func setToFullView() {
        print("setToFullView state:",  viewState)
        if viewState != .expanded {
            UIView.animate(withDuration: Constants.PostBottomSheet.AUTOMATED_SLIDE_UP_DOWN_ANIMATION_DURATION, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
                self.view.frame = CGRect(x: 0, y: self.fullViewTopInset, width: self.view.frame.width, height: self.view.frame.height)
                self.view.backgroundColor = UIColor.rgb(red: 250, green: 250, blue: 250).withAlphaComponent(0.99)
                self.tabBarController?.view.backgroundColor = UIColor.rgb(red: 250, green: 250, blue: 250).withAlphaComponent(0.99)
                    self.tabBarController?.tabBar.isTranslucent = true;
                
                self.totalActionButton.transform = self.totalActionButton.transform.rotated(by: .pi)
            }, completion: { (_) in
                self.updateViewState()
            })
        }
    }
    
    func isExpanded() -> Bool {
        return view.frame.origin.y == fullViewTopInset
    }
    
    func updateViewState() {
        viewState = isExpanded() ? .expanded : .collapsed
    }
    
    @objc func flipBottomSheetExpansion() {
        if isExpanded() {
            resetToPartialView()
        } else {
            setToFullView()
        }
    }
    
    @objc func tapGesture(_ gesture: UITapGestureRecognizer) {
        textView.resignFirstResponder()
        hintToSwipeUp()
    }
    
    @objc func swipeGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        let y = view.frame.minY
        if (y + translation.y >= fullViewTopInset) && (y + translation.y <= partialView) {
            self.view.frame = CGRect(x: 0, y: y + translation.y, width: view.frame.width, height: view.frame.height)
            gesture.setTranslation(CGPoint.zero, in: view)
        }
        
        if gesture.state == .ended {
            var duration =  velocity.y < 0 ? Double((y - fullViewTopInset) / -velocity.y) : Double((partialView - y) / velocity.y )
            
            duration = duration > 1.3 ? 1 : duration
            duration = duration < 0.5 ? 0.5 : duration
            
            if velocity.y >= 0 {
                resetToPartialView()
            } else {
                setToFullView()
            }
        }
    }
    
}
