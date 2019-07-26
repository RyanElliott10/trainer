//
//  WorkoutDatasource.swift
//  Trainer
//
//  Created by Ryan Elliott on 6/25/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import Foundation

enum Weekday: Int {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

struct WorkoutDatasource {
    
    var title: String // Legs, Chest and Triceps, etc.
    var dayOfWeek: Weekday
    var workouts: [String]
    var trainer: String // Will be converted to User object
    
}
