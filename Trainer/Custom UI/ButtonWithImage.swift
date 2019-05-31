//
//  ButtonWithImage.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/12/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class ButtonWithImage: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView != nil {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            if let _ = imageView?.frame.width {
                titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            }
        }
    }
    
}
