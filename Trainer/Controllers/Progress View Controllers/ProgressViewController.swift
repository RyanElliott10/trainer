//
//  ProgressViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
    
    private let miniHeaderView: TrackMiniHeaderView = {
        return TrackMiniHeaderView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Your Journey"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)]
        
        setupMiniHeaderView()
    }
    
    private func setupMiniHeaderView() {
        view.addSubview(miniHeaderView)
        miniHeaderView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            miniHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            miniHeaderView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            miniHeaderView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            miniHeaderView.heightAnchor.constraint(equalToConstant: 65)
        ])
    }
    
}
