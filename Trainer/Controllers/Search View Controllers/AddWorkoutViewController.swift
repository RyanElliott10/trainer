//
//  AddWorkoutViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/31/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

enum AddWorkoutSection {
    case title
    case add
    case date
}

protocol AddWorkoutSectionButtonDelegate {
    
    func addExercise()
    
    func addSection()
    
}

struct AddSection {
    
    var type: AddWorkoutSection
    var workoutSection: WorkoutSection?
    
}

class AddWorkoutViewController: UIViewController {
    
    // MARK: - Properties
    
    private let TEXT_FIELD_HEIGHT: CGFloat = 35
    
    // The idea here being: these are the base ones. When a user adds a new section, it'll always be of type .add, and we use tableViewSections.count in numberOfSections
    fileprivate var sectionsInTableView: [AddSection] = [
        AddSection(type: .title, workoutSection: nil),
        AddSection(type: .date, workoutSection: nil)
    ]
    fileprivate var workoutDatasource: WorkoutDatasource = WorkoutDatasource.generateDummyData()[0]
    private let cellReuseId = "CellReuseId"
    
    // MARK: - UI
    
    private let navigationBar: NavigationBar = {
        let bar = NavigationBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        
        return bar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    // New strat: Allow the user to add literal sections to the table view for the "warmup", "main", etc. groupings
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 242, green: 242, blue: 242)
        setupSectionCounter()
        setupViews()
    }
    
    private func setupSectionCounter() {
        // This is a disgusting way to do this
        for section in workoutDatasource.sections {
            print("section:", section)
            let count = sectionsInTableView.count
            sectionsInTableView.insert(AddSection(type: .add, workoutSection: section), at: count - 1)
        }
        
        print("AHHHEEMMM:", sectionsInTableView)
    }
    
    private func setupViews() {
        navigationBar.delegate = self
        
        view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        setupAddExercisesViews()
    }
    
    private func setupAddExercisesViews() {
        tableView.register(AddWorkoutCell.self, forCellReuseIdentifier: cellReuseId)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: navigationBar.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

extension AddWorkoutViewController: NavigationBarDelegate {
    
    // MARK: - NavigationBarDelegate
    
    func dismissView() {
        print("dismiss")
        dismiss(animated: true, completion: nil)
    }
    
    func rightActionButtonOnTap() {
        print("rightActionButtonOnTap")
    }
    
    func navigationTitleOnTap() {
        print("navigationTitleOnTap")
    }

}

extension AddWorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsInTableView.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case sectionsInTableView.count - 1:
            return 1
        default:
            print("HM 2:", workoutDatasource.sections.count)
            print("Section:", section)
            return workoutDatasource.sections[section - 1].exercises.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var workoutType: AddWorkoutSection = .title
        switch indexPath.section {
        case 0:
            workoutType = .title
        case sectionsInTableView.count - 1:
            workoutType = .date
        default:
            workoutType = .add
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! AddWorkoutCell
        print(workoutType)
        cell.workoutType = workoutType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        
        let header = AddWorkoutHeader(withTitle: sectionsInTableView[section].workoutSection?.title ?? "Set Date")
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == sectionsInTableView.count - 2 { // The last section in the "add workout" sections
            return AddWorkoutFooter(withDelegate: self)
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (section == sectionsInTableView.count - 2 ? 50 : 0)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0 ? 8 : 40)
    }
    
}

extension AddWorkoutViewController: AddWorkoutSectionButtonDelegate {
    
    func addExercise() {
        let index = sectionsInTableView.count - 2
        let currentSectionDatasource = sectionsInTableView[index]
        currentSectionDatasource.workoutSection?.exercises.append(Exercise(name: "Placeholder", reps: 0, sets: 0, isCompleted: false))
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: currentSectionDatasource.workoutSection!.exercises.count - 1, section: index)], with: .automatic)
        tableView.endUpdates()
    }
    
    func addSection() {
        let addSection = AddSection(type: .add, workoutSection: WorkoutSection(title: "Add Exercsies", exercises: [Exercise(name: "Temp", reps: 0, sets: 0, isCompleted: false)]))
        workoutDatasource.sections.append(addSection.workoutSection!)
        let index = sectionsInTableView.count - 2
        sectionsInTableView.insert(addSection, at: index)
        
        let indexSet = IndexSet(integer: sectionsInTableView.count - 1)
        tableView.beginUpdates()
        tableView.insertSections(indexSet, with: .automatic)
        tableView.endUpdates()
    }
    
}
