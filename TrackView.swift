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
    
    open var gradients: [CGColor] = [UIColor.black.cgColor] {
        didSet {
            configureGradientView()
        }
    }
    
    private var gradientLayer: CAGradientLayer?
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.heavy)
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
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
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
        configureGradientView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.frame = bounds
        print(bounds)
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
        switch bodyType {
        case .counter: setupCounter()
        case .excerpt: setupExcerpt()
        }
    }
    
    private func setupCounter() {
        addSubview(counterNumber)
        counterNumber.text = "13"
        
        addSubview(counterLabel)
        counterLabel.text = "Workouts"
        
        
        let stackView = UIStackView(arrangedSubviews: [counterNumber, counterLabel])

        stackView.axis = .horizontal
        stackView.alignment = .firstBaseline
        stackView.distribution = .fill
        stackView.spacing = 4

        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupExcerpt() {
        print("setupExcerpt")
    }
    
    private func configureGradientView() {
        backgroundColor = .clear
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        gradientLayer?.colors = gradients
        gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer?.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer?.locations = [0.0, 1.0]
        layer.insertSublayer(gradientLayer!, at: 0)
        
        print("FRIGGITY FRAGGITY FUCK")
    }
    
}
