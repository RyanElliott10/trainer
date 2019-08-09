//
//  AddWorkoutCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 8/4/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class AddWorkoutCell: UITableViewCell {
    
    // MARK: - Properties
    
    var workoutType: AddWorkoutSection? {
        didSet {
            setupFieldPlaceholder()
        }
    }
    
    private let BOTTOM_PADDING: CGFloat = -10
    
    // MARK: - UI
    
    let workoutTitleField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.backgroundColor = .white
        field.clipsToBounds = true
        field.layer.cornerRadius = 8
        field.setLeftPaddingPoints(5)
        
        return field
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        clipsToBounds = true
        layer.cornerRadius = 8
        backgroundColor = .clear
        
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func setupViews() {
        workoutTitleField.backgroundColor = .white
        contentView.addSubview(workoutTitleField)
        NSLayoutConstraint.activate([
            workoutTitleField.topAnchor.constraint(equalTo: contentView.topAnchor),
            workoutTitleField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: BOTTOM_PADDING),
            workoutTitleField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            workoutTitleField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
        ])
    }
    
    private func setupFieldPlaceholder() {
        guard let type = workoutType else { return }
        switch type {
        case .title:
            workoutTitleField.placeholder = "Title (optional)"
        case .add:
            workoutTitleField.placeholder = "Excercise"
        case .date:
            workoutTitleField.placeholder = "Date"
        }
    }
    
    func getExercise() -> String {
        return workoutTitleField.text ?? ""
    }
    
}

class AddWorkoutHeader: UIView {
    
    private var title: String!
    
    let titleLabel: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        field.text = "Add Exercises"
        field.textAlignment = .center
        
        return field
    }()
    
    // MARK: Init
    
    init(withTitle title: String) {
        super.init(frame: .zero)
        
        self.title = title
        titleLabel.text = self.title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    func getTitle() -> String {
        return titleLabel.text ?? ""
    }
    
}

class AddWorkoutFooter: UIView {
    
    // MARK: - Properties
    
    private var delegate: AddWorkoutSectionButtonDelegate!
    
    private let BUTTON_HEIGHT: CGFloat = 35
    
    // MARK: - UI
    
    private let addExerciseButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Exercise", for: .normal)
        button.backgroundColor = .appPrimary
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return button
    }()
    
    private let addSectionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Section", for: .normal)
        button.backgroundColor = .appPrimary
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        
        return button
    }()
    
    // MARK: Init
    
    init(withDelegate delegator: AddWorkoutSectionButtonDelegate) {
        super.init(frame: .zero)
        
        delegate = delegator
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupViews() {
        addExerciseButton.addTarget(self, action: #selector(addExercise), for: .touchUpInside)
        addSubview(addExerciseButton)
        NSLayoutConstraint.activate([
            addExerciseButton.topAnchor.constraint(equalTo: topAnchor),
            addExerciseButton.heightAnchor.constraint(equalToConstant: BUTTON_HEIGHT),
            addExerciseButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            addExerciseButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        addSectionButton.addTarget(self, action: #selector(addSection), for: .touchUpInside)
        addSubview(addSectionButton)
        NSLayoutConstraint.activate([
            addSectionButton.topAnchor.constraint(equalTo: topAnchor),
            addSectionButton.heightAnchor.constraint(equalToConstant: BUTTON_HEIGHT),
            addSectionButton.leadingAnchor.constraint(equalTo: addExerciseButton.trailingAnchor, constant: 8),
            addSectionButton.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: - Selectors
    
    @objc private func addExercise() {
        delegate.addExercise()
    }
    
    @objc private func addSection() {
        delegate.addSection()
    }
    
}
