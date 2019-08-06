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

class Section {
    
    var title: String
    var type: AddWorkoutSection
    var entries: [String]
    
    init(title: String, type: AddWorkoutSection, entries: [String]) {
        self.title = title
        self.type = type
        self.entries = entries
    }
    
}

class AddWorkoutViewController: UIViewController {
    
    // MARK: - Properties
    
    private let TEXT_FIELD_HEIGHT: CGFloat = 35
    
    // The idea here being: these are the base ones. When a user adds a new section, it'll always be of type .add, and we use tableViewSections.count in numberOfSections
    fileprivate var datasource: [Section] = [
        Section(title: "Title", type: .title, entries: ["Add Title (Optional)"]),
        Section(title: "Add Exercise", type: .add, entries: ["Exercise"]),
        Section(title: "Date", type: .date, entries: ["Set Date"])
    ]
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
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.rgb(red: 242, green: 242, blue: 242)
        setupViews()
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
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].entries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var workoutType: AddWorkoutSection = .title
        switch indexPath.section {
        case 0:
            workoutType = .title
        case datasource.count - 1:
            workoutType = .date
        default:
            workoutType = .add
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as! AddWorkoutCell
        cell.workoutType = workoutType
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 { return nil }
        
        let header = AddWorkoutHeader(withTitle: datasource[section].title)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == datasource.count - 2 { // The last section in the "add workout" sections
            return AddWorkoutFooter(withDelegate: self)
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return (section == datasource.count - 2 ? 50 : 0)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0 ? 8 : 40)
    }
    
}

extension AddWorkoutViewController: AddWorkoutSectionButtonDelegate {
    
    func addExercise() {
        let index = datasource.count - 2
        let currentSection = datasource[index]
        currentSection.entries.append("Placeholder")
        
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: currentSection.entries.count - 1, section: index)], with: .automatic)
        tableView.endUpdates()
    }
    
    func addSection() {
        let index = datasource.count - 1
        datasource.insert(Section(title: "Add Exercise", type: .add, entries: ["Placeholder"]), at: index)
        
        let indexSet = IndexSet(integer: datasource.count - 2)
        tableView.beginUpdates()
        tableView.insertSections(indexSet, with: .automatic)
        tableView.endUpdates()
    }
    
}
