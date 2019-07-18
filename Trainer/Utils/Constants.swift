//
//  Constants.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/27/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

struct GlobalConstants {
    
    static let BACKGROUND_COLOR: UIColor = UIColor.rgb(red: 235, green: 235, blue: 235)
    
}

struct HomeScreenConstants {
    
    static let POST_CONTAINER_HEIGHT: CGFloat = 50
    
}

struct SearchScreenConstants {
    
    static let HEADER_HEIGHT: CGFloat = 50
    
    static let BOLD_LABEL_FONT: CGFloat = 28
    
}

struct ProfileScreenConstants {
    
    static let PROFILE_IMAGE_WIDTH: CGFloat = 75
    
    static let PROFILE_IMAGE_HEIGHT: CGFloat = 75
    
}

struct CellConstants {
    
    static let BORDER_COLOR: UIColor = UIColor.rgb(red: 175, green: 175, blue: 175)
    
    static let IMAGES_COLLECTION_VIEW_HEIGHT: CGFloat = 200
    
    static let PROFILE_IMAGE_VIEW_WIDTH: CGFloat = 35
    
    static let AUTO_SIZING_HEIGHT: CGFloat = 1
    
}

struct PostBottomSheetConstants {
    
    static let AUTOMATED_SLIDE_UP_DOWN_ANIMATION_DURATION: Double = 0.85
    
    static let FULL_VIEW_TOP_INSET: CGFloat = 100
    
}

struct Constants {
    
    static let Global = GlobalConstants.self
    
    static let HomeScreen = HomeScreenConstants.self
    
    static let SearchScreen = SearchScreenConstants.self
    
    static let Cell = CellConstants.self
    
    static let ProfileScreen = ProfileScreenConstants.self
    
    static let PostBottomSheet = PostBottomSheetConstants.self
    
}
