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
    private var bodyText = ""
    private var likers = [User]()
    private var comments = [Comment]()
    private var images = [UIImage]()
    private var title = ""
    private var date = ""
    
    init(json: [String: Any]) {
        user = json["user"] as? User ?? User(json: ["Unspecified" : 0])
        title = json["title"] as? String ?? ""
        bodyText = json["bodyText"] as? String ?? ""
        date = json["date"] as? String ?? ""
        if let likers = json["likers"] as? [User] {
            self.likers = likers
        }
        if let comments = json["comments"] as? [Comment] {
            self.comments = comments
        }
        images = json["images"] as? [UIImage] ?? []
    }
    
    static func generateDummyPosts() -> [Post] {
        let user = User.generateDummyUser()
        let json1 = [
            "user" : user,
            "title" : "This is a Title",
            "bodyText" : "0. Hello, this should have 1 image.",
            "date" : "2m ago",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash")]
            ] as JSON
        
        let json2 = [
            "user" : user,
            "title" : "This is a Title",
            "bodyText" : "1. This cell should have 6 images. I'll be adding more text to this to test the auto-sizing cell size.",
            "date" : "2m ago",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash")]
            ] as JSON
        
        let json3 = [
            "user" : user,
            "title" : "This is a Title",
            "bodyText" : "2. This cell shouldn't have any images.",
            "date" : "2m ago",
            "likers" : [user],
            ] as JSON
        
        let json4 = [
            "user" : user,
            "title" : "This is a Title",
            "bodyText" : "3. This cell shouldn't have any images.",
            "date" : "2m ago",
            "likers" : [user],
            ] as JSON
        
        let json5 = [
            "user" : user,
            "title" : "This is a Title",
            "bodyText" : "4. This cell should have exactly 2 images.",
            "date" : "2m ago",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as JSON
        
        let json6 = [
            "user" : user,
            "title" : "This is a Title",
            "bodyText" : "5. This cell should have exactly 2 images.",
            "date" : "2m ago",
            "likers" : [user],
            "images" : [UIImage(named: "edgar-chaparro-669210-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as JSON
        
        let json7 = [
            "user" : user,
            "title" : "This is a Title",
            "bodyText" : "6. This cell should have exactly 2 images.",
            "date" : "2m ago",
            "likers" : [user],
            "images" : [UIImage(named: "edgar-chaparro-669210-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash")]
            ] as JSON
        
        let json8 = [
            "user" : user,
            "title" : "This is a Title",
            "bodyText" : "7. This cell should have exactly 3 images.",
            "date" : "2m ago",
            "likers" : [user],
            "images" : [UIImage(named: "boxed-water-is-better-1464052-unsplash"), UIImage(named: "edgar-chaparro-669210-unsplash"), UIImage(named: "boxed-water-is-better-1464052-unsplash")]
            ] as JSON
        
//        return [Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8), Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8)]
        return [Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8), Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8), Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8), Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8), Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8), Post(json: json1), Post(json: json2), Post(json: json3), Post(json: json4), Post(json: json5), Post(json: json6), Post(json: json7), Post(json: json8)]
    }
    
    func getUser() -> User {
        return user ?? User(json: ["Unspecified" : 0])
    }
    
    func getBodyText() -> String {
        return bodyText
    }
    
    func getNumberOfLikes() -> Int {
        return likers.count
    }
    
    func getNumberOfComments() -> Int {
        return comments.count
    }
    
    func getNumberOfImages() -> Int {
        return images.count;
    }
    
    func getImages() -> [UIImage] {
        return images
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getDate() -> String {
        return date
    }
    
}
