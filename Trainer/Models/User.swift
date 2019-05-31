//
//  User.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/29/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class User {
    
    private var name: String?
    private var username: String?
    private var profileImageURL: NSURL?
    private var profileImage: UIImage?
    private var storyContent: [UIImage]?
    
    init(json: [String: Any]) {
        if let _name = json["name"] as? String {
            name = _name;
        }
        if let _username = json["username"] as? String {
            username = _username
        }
        profileImageURL = json["profileImageURL"] as? NSURL
        storyContent = json["storyContent"] as? [UIImage]
    }
    
    static func generateDummyUser() -> User {
        let json = [
            "name" : "Ryan Elliott",
            "username" : "handlerandle",
            "profileImageURL" : "www.google.com",
            "storyContent" : [#imageLiteral(resourceName: "boxed-water-is-better-1464052-unsplash")]
        ] as [String : Any]
        return User(json: json)
    }
    
    private func fetchProfileImage() {
        // Make API call to fetch the profile image from the given URL provided by JJSON
    }
    
    func getName() -> String {
        guard let _name = name else { return "" }
        return _name
    }
    
    func getUsername() -> String {
        guard let _username = username else { return "" }
        return _username
    }
    
    func getProfileImage() -> UIImage {
        // Return whatever is grabbed from the fetch for the url
        guard let _profileImage = profileImage else { return UIImage() }
        return _profileImage
    }
    
    func getStoryContent() -> [UIImage] {
        guard let content = storyContent else { return [] }
        return content
    }
    
}
