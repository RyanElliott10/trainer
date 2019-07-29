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

class WorkoutDatasource {
    
    var title: String // Legs, Chest and Triceps, etc.
    var dayOfWeek: Weekday
    var workouts: [Excercise]
    var trainer: String // Will be changed to User object
    var isCompleted: Bool
    
    init(title: String, dayOfWeek: Weekday, workouts: [Excercise], trainer: String, isCompleted: Bool) {
        self.title = title
        self.dayOfWeek = dayOfWeek
        self.workouts = workouts
        self.trainer = trainer
        self.isCompleted = isCompleted
    }
    
    static func generateDummyData() -> [WorkoutDatasource] {
        return [WorkoutDatasource(title: "Legs", dayOfWeek: .monday, workouts: [Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false), Excercise(name: "Leg Press", reps: 8, sets: 4, isCompleted: false)], trainer: "Zac Perna", isCompleted: false), WorkoutDatasource(title: "Legs", dayOfWeek: .monday, workouts: [Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false), Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false)], trainer: "Zac Perna", isCompleted: false), WorkoutDatasource(title: "Legs", dayOfWeek: .monday, workouts: [Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false), Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false)], trainer: "Zac Perna", isCompleted: false), WorkoutDatasource(title: "Legs", dayOfWeek: .monday, workouts: [Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false), Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false)], trainer: "Zac Perna", isCompleted: false), WorkoutDatasource(title: "Legs", dayOfWeek: .monday, workouts: [Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false), Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false)], trainer: "Zac Perna", isCompleted: false), WorkoutDatasource(title: "Legs", dayOfWeek: .monday, workouts: [Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false), Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false)], trainer: "Zac Perna", isCompleted: false), WorkoutDatasource(title: "Legs", dayOfWeek: .monday, workouts: [Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false), Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false)], trainer: "Zac Perna", isCompleted: false), WorkoutDatasource(title: "Legs", dayOfWeek: .monday, workouts: [Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false), Excercise(name: "Squat", reps: 8, sets: 4, isCompleted: false)], trainer: "Zac Perna", isCompleted: false)]
    }
    
}
