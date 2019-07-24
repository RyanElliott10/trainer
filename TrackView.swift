//
//  TrackView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/23/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

public enum TrackViewType {
    case counter
    case excerpt
}

class TrackView: UIView {
    
    // MARK: - Properties
    
    open var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    open var bodyType: TrackViewType = .excerpt
    
    open var gradients: [UIColor] = [.white, .white]
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.heavy)
        label.sizeToFit()
        
        return label
    }()
    
    private let eyeView: UIImageView = {
        return UIImageView()
    }()
    
    private let counterNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        label.sizeToFit()
        
        return label
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: UIFont.Weight.semibold)
        label.sizeToFit()
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withTitle title: String, type: TrackViewType) {
        self.init(frame: .zero)
        
        self.title = title
        self.bodyType = type
        
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Setup
    
    private func setupViews() {
        layer.cornerRadius = 8
        clipsToBounds = true
        
        addSubview(titleLabel)
        titleLabel.sizeToFit()
        titleLabel.text = title
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        setupBodyView()
    }
    
    private func setupBodyView() {
        print(bodyType)
        switch bodyType {
        case .counter: setupCounter()
        case .excerpt: setupExcerpt()
        }
    }
    
    private func setupCounter() {
        addSubview(counterNumber)
        counterNumber.text = "13"
        NSLayoutConstraint.activate([
            counterNumber.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            counterNumber.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -8),
            counterNumber.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(counterLabel)
        counterLabel.text = "Workouts"
        NSLayoutConstraint.activate([
            counterLabel.leadingAnchor.constraint(equalTo: counterNumber.trailingAnchor, constant: 6),
            counterLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6)
        ])
        
        
//        let stackView = UIStackView(arrangedSubviews: [counterNumber, counterLabel])
//        stackView.axis = .horizontal
//        stackView.alignment = .lastBaseline
//
//        stackView.backgroundColor = .white
//
//        addSubview(stackView)
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
//            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
    }
    
    private func setupExcerpt() {
        print("setupExcerpt")
    }
    
}
