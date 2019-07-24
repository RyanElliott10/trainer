//
//  BorderedImageView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class BorderedImageView: UIView {
    
    var circleLayer: CAShapeLayer!
    var diameter: CGFloat = 0
    var radius: CGFloat {
        get {
            diameter / 2
        }
    }
    
    private let innerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.shouldRasterize = true
        imageView.layer.rasterizationScale = 100
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withImage image: UIImage, diameter: CGFloat) {
        self.init()
        
        innerImageView.image = image
        self.diameter = diameter
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        innerImageView.layer.cornerRadius = radius
        
        circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(roundedRect: CGRect(x: frame.origin.x, y: frame.origin.y, width: diameter, height: diameter), cornerRadius: radius).cgPath
        circleLayer.position = CGPoint(x: frame.midX - radius, y: frame.midY - radius)
        circleLayer.fillColor = UIColor.blue.cgColor
        layer.addSublayer(circleLayer)
    }
    
}
