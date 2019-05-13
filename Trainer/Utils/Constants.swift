//
//  Constants.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/27/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

struct HomeScreenConstants {
    
}

struct SearchScreenConstants {
    
    static let HEADER_HEIGHT: CGFloat = 50
    
    static let BOLD_LABEL_FONT: CGFloat = 28
    
}

struct CellConstants {
    
    static let BORDER_COLOR: UIColor = UIColor.rgb(red: 175, green: 175, blue: 175)
    
    static let IMAGES_COLLECTION_VIEW_HEIGHT: CGFloat = 175
    
    static let PROFILE_IMAGE_VIEW_WIDTH: CGFloat = 50
    
    static let AUTO_SIZING_HEIGHT: CGFloat = 1
    
}

struct ProfileScreenConstants {
    
    static let PROFILE_IMAGE_WIDTH: CGFloat = 110
    
    static let PROFILE_IMAGE_HEIGHT: CGFloat = 110
    
}

struct Constants {
    
    static let HomeScreen = HomeScreenConstants.self
    
    static let SearchScreen = SearchScreenConstants.self
    
    static let Cell = CellConstants.self
    
    static let ProfileScreen = ProfileScreenConstants.self
    
}
