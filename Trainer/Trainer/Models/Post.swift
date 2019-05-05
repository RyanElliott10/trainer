//
//  Post.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/29/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import Foundation
import UIKit

class Post {
    
    private var user: User
    private var bodyText: String
    private var likers = [User]()
    private var comments = [Comment]()
    private var images = [UIImage]()
    
    init(json: [String: Any]) {
        self.user = json["user"] as! User
        self.bodyText = json["bodyText"] as! String
        if let likers = json["likers"] as? [User] {
            self.likers = likers
        }
    }

    static func generateDummyPosts() -> [Post] {
        let user1 = User.generateDummyUser()
        let json1 = [
            "user" : user1,
            "bodyText" : "Hello, this is a test of the body text adding more to make the text longer",
            "likers" : [user1],
            ] as [String : Any]
        
        let user2 = User.generateDummyUser()
        let json2 = [
            "user" : user2,
            "bodyText" : "Hello, this is a test of the body text adding more to make the text longer and actually a unique text hehehehehe",
            "likers" : [user1, user2],
            ] as [String : Any]
        
        let user3 = User.generateDummyUser()
        let json3 = [
            "user" : user3,
            "bodyText" : "Hello, this is a test of the body text adding more to make the text longer and actually a unique text hehehehehe and oh my god there is a lot of text here " + (json2["bodyText"] as! String),
            "likers" : [user1, user2],
            ] as [String : Any]
        return [Post(json: json1), Post(json: json3), Post(json: json2)]
    }
    
    func getUser() -> User {
        return self.user
    }
    
    func getBodyText() -> String {
        return self.bodyText
    }
    
    func getNumberOfLikes() -> Int {
        return self.likers.count
    }
    
    func getNumberOfComments() -> Int {
        return self.comments.count
    }
    
    func getNumberOfImages() -> Int {
        return self.images.count;
    }
    
    func getImages() -> [UIImage] {
        return self.images
    }
    
}
