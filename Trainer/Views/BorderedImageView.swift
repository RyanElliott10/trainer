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
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withImage image: UIImage, diameter: CGFloat) {
        self.init(frame: .zero)
        
        imageView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        diameter = frame.width
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.frame = CGRect(x: 0, y: 0, width: diameter, height: diameter)
        shapeLayer.lineWidth = 1
        shapeLayer.fillColor = nil
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.shouldRasterize = true
        shapeLayer.rasterizationScale = 10
        
        let arcCenter = shapeLayer.position
        let startAngle = CGFloat(0.0)
        let endAngle = CGFloat(2.0 * .pi)
        let clockwise = true
        
        let circlePath = UIBezierPath(arcCenter: arcCenter,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: clockwise)
        
        shapeLayer.path = circlePath.cgPath
        layer.addSublayer(shapeLayer)

        imageView.layer.cornerRadius = radius - 1
        addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 2),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2)
        ])
    }
    
}
