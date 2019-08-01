//
//  AddWorkoutViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/31/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class AddWorkoutViewController: UIViewController {
    
    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.isOpaque = false
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
        gesture.delegate = self
        view.addGestureRecognizer(gesture)
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(viewContainer)
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            viewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
            viewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            viewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    // TODO: - Add gesture recognizer to view. and on press display an alert asking the user if they want to dismiss their progress
    
}

extension AddWorkoutViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
    
}
