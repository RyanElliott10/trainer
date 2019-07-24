//
//  TrackMiniHeaderView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/23/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class TrackMiniHeaderView: UIView {
    
    private let workoutStreakView: TrackView = {
        let view = TrackView(withTitle: "Streak", type: .counter)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bodyType = .counter
        
        return view
    }()
    
    private let goalView: TrackView = {
        let view = TrackView(withTitle: "Top Goal", type: .excerpt)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(workoutStreakView)
        workoutStreakView.backgroundColor = .blue
        
        NSLayoutConstraint.activate([
            workoutStreakView.topAnchor.constraint(equalTo: topAnchor),
            workoutStreakView.bottomAnchor.constraint(equalTo: bottomAnchor),
            workoutStreakView.leadingAnchor.constraint(equalTo: leadingAnchor),
            workoutStreakView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 2/5)
        ])
        
        addSubview(goalView)
        goalView.backgroundColor = .orange
        
        NSLayoutConstraint.activate([
            goalView.topAnchor.constraint(equalTo: topAnchor),
            goalView.bottomAnchor.constraint(equalTo: bottomAnchor),
            goalView.trailingAnchor.constraint(equalTo: trailingAnchor),
            goalView.leadingAnchor.constraint(equalTo: workoutStreakView.trailingAnchor, constant: 6)
        ])
    }
    
}
