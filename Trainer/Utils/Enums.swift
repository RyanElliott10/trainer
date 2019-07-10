//
//  Enums.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/24/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import Foundation

enum SearchTab: Int {
    case Trainers = 0
    case Gyms = 1
    case Workouts = 2
}

enum WelcomeControllers: String {
    case Continue = "Continue"
    case SignUp = "Sign Up"
    case Login = "Login"
}

enum SearchPage: String {
    case Trainers
    case Gyms
    case Workouts
}
