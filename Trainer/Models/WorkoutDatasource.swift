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

class WorkoutSection {
    
    var title: String
    var exercises: [Exercise]
    
    init(title: String, exercises: [Exercise]) {
        self.title = title
        self.exercises = exercises
    }
    
    static func generateDummyData() -> [WorkoutSection] {
        return [
            WorkoutSection(title: "Warmup", exercises: [Exercise(name: "1 Mile Jog", reps: 0, sets: 0, isCompleted: false)]),
            WorkoutSection(title: "Main", exercises: [Exercise(name: "Leg Press", reps: 8, sets: 4, isCompleted: false), Exercise(name: "Chest Press", reps: 8, sets: 4, isCompleted: false)]),
            WorkoutSection(title: "Cool Down", exercises: [Exercise(name: "Abs", reps: 8, sets: 4, isCompleted: false)]),
        ]
    }
    
}

class WorkoutDatasource {
    
    var title: String // Legs, Chest and Triceps, etc.
    var dayOfWeek: Weekday
    var sections: [WorkoutSection]
    var trainer: String // Will be changed to User object
    var isCompleted: Bool
    
    init(title: String, dayOfWeek: Weekday, sections: [WorkoutSection], trainer: String, isCompleted: Bool) {
        self.title = title
        self.dayOfWeek = dayOfWeek
        self.sections = sections
        self.trainer = trainer
        self.isCompleted = isCompleted
    }
    
    static func generateDummyData() -> [WorkoutDatasource] {
        let sections = WorkoutSection.generateDummyData()
        return [
            WorkoutDatasource(title: "Legs", dayOfWeek: .monday, sections: sections, trainer: "Zac Perna", isCompleted: false),
            WorkoutDatasource(title: "Legs", dayOfWeek: .monday, sections: sections, trainer: "Zac Perna", isCompleted: false),
            WorkoutDatasource(title: "Legs", dayOfWeek: .monday, sections: sections, trainer: "Zac Perna", isCompleted: false),
            WorkoutDatasource(title: "Legs", dayOfWeek: .monday, sections: sections, trainer: "Zac Perna", isCompleted: false),
            WorkoutDatasource(title: "Legs", dayOfWeek: .monday, sections: sections, trainer: "Zac Perna", isCompleted: false),
            WorkoutDatasource(title: "Legs", dayOfWeek: .monday, sections: sections, trainer: "Zac Perna", isCompleted: false),
            WorkoutDatasource(title: "Legs", dayOfWeek: .monday, sections: sections, trainer: "Zac Perna", isCompleted: false),
            WorkoutDatasource(title: "Legs", dayOfWeek: .monday, sections: sections, trainer: "Zac Perna", isCompleted: false)]
    }
    
}
