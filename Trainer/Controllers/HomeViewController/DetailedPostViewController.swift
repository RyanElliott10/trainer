//
//  DetailedPostViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/12/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class DetailedPostViewController: UIViewController {
    
    // MARK: - Properties
    
    var post: Post? {
        didSet {
            if let p = post {
                load(data: p)
            }
        }
    }
    
    let mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.spacing = 4
        
        return mainStackView
    }()
    
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let postStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        return label
    }()
    
    let postBodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    // MARK: - View Configuration
    
    private func configureViews() {
        view.backgroundColor = .white
        configurePostBodyView()
        mainStackView.addArrangedSubview(mainView)
        
        view.addSubview(mainStackView)
        mainStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    private func configurePostBodyView() {
        mainView.addSubview(postStackView)
        postStackView.addArrangedSubview(usernameLabel)
        postStackView.addArrangedSubview(postBodyLabel)
    }
    
    // MARK: - Data
    
    private func load(data: Post) {
        usernameLabel.text = post?.getUser().getName()
        postBodyLabel.text = post?.getBodyText()
    }
    
}
