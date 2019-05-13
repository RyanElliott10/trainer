//
//  ImagePreviewViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/12/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    // MARK: - Properties
    
    var image: UIImage?
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // MARK: - Init
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        configureGestureRecognizer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
    }
    
    // MARK: - View Configuration
    
    private func configureViews() {
        view.frame = UIScreen.main.bounds
        view.backgroundColor = UIColor.black.withAlphaComponent(0.95)
        
        imageView.image = image
        
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 325).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 550).isActive = true
    }
    
    private func configureGestureRecognizer() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        dismiss(animated: true)
    }
    
}
