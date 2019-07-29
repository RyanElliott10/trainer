//
//  Excercies.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/28/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import Foundation

class Excercise {
    
    var name: String
    var reps: Int
    var sets: Int
    var isCompleted: Bool
    
    init(name: String, reps: Int, sets: Int, isCompleted: Bool) {
        self.name = name
        self.reps = reps
        self.sets = sets
        self.isCompleted = isCompleted
    }
    
}
