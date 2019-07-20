//
//  ModernPostImageView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/19/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ModernPostImageCell: UIView {
    
    private var images = [UIImage]()
    
    convenience init(withImages images: [UIImage]) {
        self.init()
        
        self.images = images
        setupViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
//        switch images.count {
//        case 1: print("1")
//        case 2: print("2")
//        case 3: print("3")
//        default: print("4 or more")
//        }
        
    }
    
}
