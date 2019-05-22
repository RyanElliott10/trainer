//
//  Post.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/29/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import Foundation
import UIKit

typealias JSON = [String : Any]

class Post {
    
    private var user: User?
    private var bodyText: String?
    private var likers = [User]()
    private var comments = [Comment]()
    private var images = [UIImage]()
    
    init(json: [String: Any]) {
        self.user = json["user"] as? User ?? User(json: ["Unspecified" : 0])
        self.bodyText = json["bodyText"] as? String ?? ""
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
        let user = User.generateDummyUser()
        let json1 = [
            "user" : user,
            "bodyText" : "Hello, this should have 1 image. 1",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash")]
            ] as JSON
        
        let json2 = [
            "user" : user,
            "bodyText" : "This cell should have 6 images. I'll be adding more text to this to test the auto-sizing cell size. 2",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash")]
            ] as JSON
        
        let json3 = [
            "user" : user,
            "bodyText" : "This cell shouldn't have any images. 3",
            "likers" : [user],
            ] as JSON
        
        let json4 = [
            "user" : user,
            "bodyText" : "This cell shouldn't have any images. 4",
            "likers" : [user],
            ] as JSON
        
        let json5 = [
            "user" : user,
            "bodyText" : "This cell should have exactly 2 images. 5",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as JSON
        
        let json6 = [
            "user" : user,
            "bodyText" : "This cell should have exactly 2 images. 6",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as JSON
        
        let json7 = [
            "user" : user,
            "bodyText" : "This cell should have exactly 2 images. 7",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as JSON
        
        let json8 = [
            "user" : user,
            "bodyText" : "This cell should have exactly 2 images. 8",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash")]
            ] as JSON
        
        return [Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8), Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8)]
    }
    
    func getUser() -> User {
        return self.user ?? User(json: ["Unspecified" : 0])
    }
    
    func getBodyText() -> String {
        return self.bodyText ?? ""
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
