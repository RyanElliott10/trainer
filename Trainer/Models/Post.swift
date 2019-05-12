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
        if let comments = json["comments"] as? [Comment] {
            self.comments = comments
        }
        if let images = json["images"] as? [UIImage] {
            self.images = images
        }
    }

    static func generateDummyPosts() -> [Post] {
        let user1 = User.generateDummyUser()
        let json1 = [
            "user" : user1,
            "bodyText" : "Hello, this should have 1 image.",
            "likers" : [user1],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash")]
            ] as [String : Any]
        
        let user2 = User.generateDummyUser()
        let json2 = [
            "user" : user2,
            "bodyText" : "This cell should have 6 images. I'll be adding more text to this to test the auto-sizing cell size.",
            "likers" : [user1, user2],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash")]
            ] as [String : Any]
        
        let user3 = User.generateDummyUser()
        let json3 = [
            "user" : user3,
            "bodyText" : "This cell shouldn't have any images.",
            "likers" : [user1, user2],
            ] as [String : Any]
        
        let user4 = User.generateDummyUser()
        let json4 = [
            "user" : user4,
            "bodyText" : "This cell should have exactly 2 images.",
            "likers" : [user1, user2, user3, user4],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as [String : Any]
        
        let user5 = User.generateDummyUser()
        let json5 = [
            "user" : user5,
            "bodyText" : "This cell should have exactly 2 images.",
            "likers" : [user1, user2, user3, user4],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as [String : Any]
        
        let user6 = User.generateDummyUser()
        let json6 = [
            "user" : user6,
            "bodyText" : "This cell should have exactly 2 images.",
            "likers" : [user1, user2, user3, user4],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as [String : Any]
        
        let user7 = User.generateDummyUser()
        let json7 = [
            "user" : user7,
            "bodyText" : "This cell should have exactly 2 images.",
            "likers" : [user1, user2, user3, user4],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as [String : Any]
        
        let user8 = User.generateDummyUser()
        let json8 = [
            "user" : user8,
            "bodyText" : "This cell should have exactly 2 images.",
            "likers" : [user1, user2, user3, user4],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as [String : Any]
        
        return [Post(json: json1), Post(json: json3), Post(json: json2), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8)]
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
