//
//  HomeScreenPostCellView.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/19/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class HomeScreenPostCellView: PostCellView {
    
    // MARK: - Properties
    
    let imageCellID = "imageCellID"
    var homeViewDelegate: HomeViewControllerDelegate?
    var imagePreviewViewController: ImagePreviewViewController?
    
    // MARK: - Views
    
    let imagesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    // MARK: - Data Configuration
    
    override func loadData(withDataSource dataSource: Post) {
        super.loadData(withDataSource: dataSource)
        delegateImagesCollectionView()
    }
    
    // MARK: - Self-sizing logic
    
    override func calculateFrameSize(fromFrame frame: inout CGRect) {
        super.calculateFrameSize(fromFrame: &frame)
        frame.size.height += getImagesCollectionViewHeight()
    }
    
    override func addSubviews() {
        super.addSubviews()
        contentView.addSubview(imagesCollectionView)
    }
    
    // MARK - View Configuration
    
    override func configureMainViews() {
        super.configureMainViews()
        configureImagesCollectionView()
        
        // If there aren't any images to render, remove imagesCollectionView
        if (post?.getNumberOfImages() ?? 0 < 1) {
            imagesCollectionView.removeFromSuperview()
        }
    }
    
    override func configureBottomViews() {
        let topAnchorForBottomViews = getImagesCollectionViewHeight() == 0 ? bodyLabel : imagesCollectionView
        let padding: CGFloat = getImagesCollectionViewHeight() == 0 ? 18 : 4
        configureLikesView(withTopView: topAnchorForBottomViews, paddingTop: padding)
        configureCommentsView(withTopView: topAnchorForBottomViews, paddingTop: padding)
    }
    
    func configureImagesCollectionView() {
        // TODO: - Adjust padding based on length of body text
        imagesCollectionView.anchor(top: bodyLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, paddingTop: 12, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: getImagesCollectionViewHeight())
    }
    
    func getImagesCollectionViewHeight() -> CGFloat {
        var imagesCollectionViewHeight: CGFloat = 0
        if let numberOfImages = post?.getNumberOfImages() {
            imagesCollectionViewHeight = numberOfImages > 0 ? Constants.Cell.IMAGES_COLLECTION_VIEW_HEIGHT : 0.0
        }
        return imagesCollectionViewHeight
    }
    
}

// MARK: - Images Collection View

extension HomeScreenPostCellView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    fileprivate func delegateImagesCollectionView() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.delegate = self
        imagesCollectionView.register(ScrollableImageView.self, forCellWithReuseIdentifier: imageCellID)
        imagesCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post?.getNumberOfImages() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellID, for: indexPath) as? ScrollableImageView {
            if let image = post?.getImages()[indexPath.row] {
                cell.image = image
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let numberOfImages = post?.getNumberOfImages() {
            let maxHeight = imagesCollectionView.frame.height - 16
            switch numberOfImages {
            case 1:
                let maxWidth = imagesCollectionView.frame.width - 16
                return CGSize(width: maxWidth, height: maxHeight)
            case 2:
                let maxWidth = imagesCollectionView.frame.width - 26
                return CGSize(width: maxWidth / 2, height: maxHeight)
            default:
                let maxWidth = imagesCollectionView.frame.width - 20
                return CGSize(width: maxWidth * 0.4, height: maxHeight)
            }
        } else {
            return CGSize(width: imagesCollectionView.frame.width, height: imagesCollectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imagePreviewViewController = ImagePreviewViewController()
        imagePreviewViewController.images = post!.getImages()
        imagePreviewViewController.startingIndexPath = indexPath
        homeViewDelegate?.push(viewController: imagePreviewViewController)
    }
    
}
