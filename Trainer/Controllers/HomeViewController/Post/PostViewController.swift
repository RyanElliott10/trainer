//
//  PostViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/11/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit
import AVFoundation
import Photos

class PostViewController: UIViewController {
    
    // MARK: - Properties
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(onCancelPress), for: .touchUpInside)
        
        return button
    }()
    
    let previewButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Preview", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.addTarget(self, action: #selector(onPreviewPress), for: .touchUpInside)
        
        return button
    }()
    
    let textView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 18)
        view.backgroundColor = .yellow
        
        return view
    }()
    
    let plusButton: UIButton = {
        let image = #imageLiteral(resourceName: "plus-circle")
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(onPlusPress), for: .touchUpInside)
        button.tintColor = .black
        
        return button
    }()
    
    // MARK: - Init
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.hidesBottomBarWhenPushed = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // The back arrow is somewhat visible on pop because this happens early
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configureViews()
    }
    
    // MARK: - Configuration
    
    private func configureViews() {
        addSubviews()
        
        configureTopBar()
        configureBody()
    }
    
    private func addSubviews() {
        view.addSubview(cancelButton)
        view.addSubview(previewButton)
        view.addSubview(textView)
        view.addSubview(plusButton)
    }
    
    private func configureTopBar() {
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 0, paddingRight: 0, width: 80, height: 20)
        previewButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 8, width: 90, height: 20)
    }
    
    private func configureBody() {
        textView.anchor(top: cancelButton.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 16, paddingLeft: 8, paddingBottom: 0, paddingRight: 8, width: 0, height: 300)
        plusButton.anchor(top: textView.bottomAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 16, width: 40, height: 40)
    }
    
    // MARK: - Selectors
    
    @objc func onCancelPress() {
        let transition: CATransition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        
        navigationController?.view.layer.add(transition, forKey: kCATransition)
        navigationController?.popViewController(animated: false)
    }
    
    @objc func onPreviewPress() {
        print("On Preview Press")
        // Push a modal on top of the view controller with a preview of what it'll look like. Have a top bar
        // and have a button say "Post" in the top right, "Back" in the top left. Taps outside will trigger "Back"
    }
    
    @objc func onPlusPress() {
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            // Request permisison to photos
            let alert = UIAlertController(title: "Allow access to Photos?", message: "Allowing access to photos will grant you the ability to create posts", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Not now", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Allow access", style: .default, handler: { (self) in
                PHPhotoLibrary.requestAuthorization({status in
                    if status == .authorized{
                        print("Photo permission authorized")
                    } else {
                        print("Photo permission denied")
                    }
                })
            }))
            present(alert, animated: true, completion: nil)
        } else if photos == .authorized {
            // Present the user's photo library
        } else {
            // Access denied
            let alert = UIAlertController(title: "Allow access to Photos", message: "To add images to your post, Trainer needs access to your Photo library", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Not now", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Allow access", style: .default, handler: { (self) in
                // Deep link user to settings
            }))
            present(alert, animated: true, completion: nil)
        }
    }
    
}
