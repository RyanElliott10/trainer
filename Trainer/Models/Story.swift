//
//  Story.swift
//  Trainer
//
//  Created by Ryan Elliott on 5/24/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class Story {
    
    var content = [UIImage]()
    
    static func generateDummyStoryData() -> [Story] {
        let s1 = Story()
        s1.content = [#imageLiteral(resourceName: "boxed-water-is-better-1464052-unsplash")]
        let s2 = Story()
        s2.content = [#imageLiteral(resourceName: "zac_perna")]
        let s3 = Story()
        s3.content = [#imageLiteral(resourceName: "edgar-chaparro-669210-unsplash")]
        
        return [s1, s2, s3]
    }
    
}
