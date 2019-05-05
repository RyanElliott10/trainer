//
//  Constants.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/27/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

struct Constants {
    // Search Screen
    static let SEARCH_SCREEN_HEADER_HEIGHT: CGFloat = 50
    static let SEARCH_SCREEN_BOLD_LABEL_FONT: CGFloat = 28
    
    // Cells
    static let CELL_BORDER_COLOR: UIColor = UIColor.rgb(red: 175, green: 175, blue: 175)
    static let IMAGES_COLLECTION_VIEW_HEIGHT: CGFloat = 175
    static let PROFILE_IMAGE_VIEW_WIDTH: CGFloat = 50
    static let AUTO_SIZING_HEIGHT: CGFloat = 1
    static let AUTOSIZING_FLOW_LAYOUT: UICollectionViewFlowLayout = {
        let width = UIScreen.main.bounds.size.width
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: width, height: Constants.AUTO_SIZING_HEIGHT)
        return layout
    }()
}
