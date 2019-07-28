//
//  WorkoutCell.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/25/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class WorkoutCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    open var datasource: WorkoutDatasource? {
        didSet {
            setupViews()
        }
    }
    
    open var gradients: [CGColor] = [UIColor.black.cgColor] {
        didSet {
            configureGradientView()
        }
    }
    
    private var checkBottomAnchor: NSLayoutYAxisAnchor?
    
    // MARK: - UI
    
    private let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "edit-underscore").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        
        return label
    }()
    
    private let withTrainerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .right
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func configureGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = gradients
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.locations = [0, 1]
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupViews() {
        guard let data = datasource else { return }
        layer.cornerRadius = 8
        layer.shouldRasterize = true
        layer.rasterizationScale = 3
        clipsToBounds = true
        
        contentView.addSubview(editButton)
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            editButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            editButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        editButton.addTarget(self, action: #selector(onEditWorkout), for: .touchUpInside)
        
        let titleString = "\(data.dayOfWeek) - \(data.title)".capitalized
        titleLabel.text = titleString
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        checkBottomAnchor = addWorkouts()
        
        let withTrainer = "With \(data.trainer)"
        withTrainerLabel.text = withTrainer
        contentView.addSubview(withTrainerLabel)
        NSLayoutConstraint.activate([
            withTrainerLabel.topAnchor.constraint(equalTo: checkBottomAnchor!, constant: 6),
            withTrainerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            withTrainerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    private func addWorkouts() -> NSLayoutYAxisAnchor {
        // for workout in workouts { ... }
        
        let workouts = ["WOTK", "WORK"]
        var prevWorkoutView: UIView = titleLabel
        
        for _ in workouts {
            let checkMarkView = WorkoutCheckView(withDatsource: (false, "4x10 Squats"))
            checkMarkView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(checkMarkView)
            NSLayoutConstraint.activate([
                checkMarkView.topAnchor.constraint(equalTo: prevWorkoutView.bottomAnchor, constant: 0),
                checkMarkView.leadingAnchor.constraint(equalTo: prevWorkoutView.leadingAnchor),
                checkMarkView.trailingAnchor.constraint(equalTo: prevWorkoutView.trailingAnchor),
                checkMarkView.heightAnchor.constraint(equalToConstant: 30)
            ])
            prevWorkoutView = checkMarkView
        }
        
        return prevWorkoutView.bottomAnchor
    }
    
    // MARK: - Selectors
    
    @objc private func onEditWorkout() {
        // Lol this is broken
        print("onEditWorkout")
        return
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        UIView.animate(withDuration: 0.5) {
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
}
