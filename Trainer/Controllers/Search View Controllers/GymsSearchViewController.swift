//
//  GymsViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/25/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit
import MapKit

class GymsSearchViewController: BaseSearchPageViewController {
    
    // MARK: - Init
    
    private var mapSnapshotImage: UIImage? {
        didSet {
            mapSnapshotImageView.image = mapSnapshotImage
        }
    }
    
    private let mapSnapshotImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchGymCell.self, forCellWithReuseIdentifier: cellId)
        wireUpFilterButton()
        generateMapSnapshot()
    }
    
    private func wireUpFilterButton() {
        super.filterButton.addTarget(self, action: #selector(filterOnPress), for: .touchUpInside)
    }
    
    private func generateMapSnapshot() {
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        let location = CLLocationCoordinate2DMake(37.332077, -122.02962)
        
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapSnapshotOptions.region = region
        
        // Set the scale of the image. We'll just use the scale of the current device, which is 2x scale on Retina screens.
        mapSnapshotOptions.scale = UIScreen.main.scale
        
        // Set the size of the image output.
        mapSnapshotOptions.size = CGSize(width: 300, height: 300)
        
        // Show buildings and Points of Interest on the snapshot
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true
        
        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        
        snapShotter.start { (snapshot: MKMapSnapshotter.Snapshot?, error: Error?) in
            self.mapSnapshotImage = snapshot?.image
        }
    }
    
    // MARK: - Selectors
    
    @objc private func filterOnPress() {
        print("filterOnPress")
    }
    
}

// MARK: - CollectionView

extension GymsSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //        return dataSource.count
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SearchGymCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: super.CELL_WIDTH, height: super.CELL_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt")
    }
    
}
