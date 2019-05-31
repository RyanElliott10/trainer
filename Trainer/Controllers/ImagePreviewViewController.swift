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
    
    var startingIndexPath: IndexPath = IndexPath()
    fileprivate let cellReuseId = "cellRuseId"
    override var prefersStatusBarHidden: Bool {
        return true
    }
    lazy var images = [UIImage]()
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.isPagingEnabled = true
        collection.showsHorizontalScrollIndicator = false
        
        collection.layer.cornerRadius = 6
        
        return collection
    }()
    
    let pageControl: UIPageControl = {
        let control = UIPageControl(frame: .zero)
        control.hidesForSinglePage = true
        
        return control
    }()
    
    // MARK: - Init
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
        
        configureGestureRecognizer()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        configureViews()
    }
    
    override func viewDidLayoutSubviews() {
        imagesCollectionView.scrollToItem(at: startingIndexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = startingIndexPath.row
    }
    
    // MARK: - View Configuration
    
    private func configureViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        view.addSubview(imagesCollectionView)
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(ImageCell.self, forCellWithReuseIdentifier: cellReuseId)
        
        imagesCollectionView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 60, paddingLeft: 0, paddingBottom: 80, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(pageControl)
        pageControl.numberOfPages = images.count
        
        pageControl.anchor(top: imagesCollectionView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 40)
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func configureGestureRecognizer() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        dismiss(animated: true)
    }
    
}

// MARK: - Collection View

extension ImagePreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseId, for: indexPath) as? ImageCell {
            cell.image = images[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - Page Control
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = imagesCollectionView.contentOffset.x / imagesCollectionView.frame.width
        pageControl.currentPage = Int(page)
    }
    
}

fileprivate class ImageCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var image: UIImage? {
        didSet {
            configureViews()
        }
    }
    
    let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View Configuration
    
    private func configureViews() {
        if let image = image {
            imageView.image = image
            contentView.addSubview(imageView)
            imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 0)
        }
    }
    
}
