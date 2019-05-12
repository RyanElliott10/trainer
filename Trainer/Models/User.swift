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
    
    init(json: [String: Any]) {
        if let name = json["name"] as? String {
            self.name = name;
        }
        if let username = json["username"] as? String {
            self.username = username
        }
        self.profileImageURL = json["profileImageURL"] as? NSURL
    }
    
    static func generateDummyUser() -> User {
        let json = [
            "name" : "Ryan Elliott",
            "username" : "handlerandle",
            "profileImageURL" : "www.google.com",
        ]
        return User(json: json)
    }
    
    private func fetchProfileImage() {
        // Make API call to fetch the profile image from the given URL provided by JJSON
    }
    
    func getName() -> String {
        guard let name = self.name else { return "" }
        return name
    }
    
    func getUsername() -> String {
        guard let username = self.username else { return "" }
        return username
    }
    
    func getProfileImage() -> UIImage {
        // Return whatever is grabbed from the fetch for the url
        guard let profileImage = self.profileImage else { return UIImage() }
        return profileImage
    }
    
}
