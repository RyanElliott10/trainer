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
    case chart
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
        label.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.heavy)
        label.sizeToFit()
        label.numberOfLines = 1
        
        return label
    }()
    
    private let eyeView: UIImageView = {
        return UIImageView()
    }()
    
    private let counterNumber: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.bold)
        label.sizeToFit()
        label.numberOfLines = 1
        
        return label
    }()
    
    private let bodyLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        label.sizeToFit()
        label.numberOfLines = 2
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // TODO: - Center all the labels in the middle of the view, no matter its height
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
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        setupBodyView()
    }
    
    private func setupBodyView() {
        switch bodyType {
        case .counter: setupCounter()
        case .chart: break
        case .excerpt: setupExcerpt()
        }
    }
    
    private func setupCounter() {
        addSubview(counterNumber)
        counterNumber.text = "13"
        
        NSLayoutConstraint.activate([
            counterNumber.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            counterNumber.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -8)
        ])
        
        addSubview(bodyLable)
        bodyLable.text = "Workouts"
        
        NSLayoutConstraint.activate([
            bodyLable.leadingAnchor.constraint(equalTo: counterNumber.trailingAnchor, constant: 4),
            bodyLable.bottomAnchor.constraint(equalTo: counterNumber.bottomAnchor, constant: -4),
            bodyLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupExcerpt() {
        addSubview(bodyLable)
        bodyLable.text = "To lose weight and get shredded for summer"
        
        NSLayoutConstraint.activate([
            bodyLable.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bodyLable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -4),
            bodyLable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func configureGradientView() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        gradientLayer?.colors = gradients
        gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer?.endPoint = CGPoint(x: 0.0, y: 0.1)
        gradientLayer?.locations = [0.0, 0.1]
        layer.insertSublayer(gradientLayer!, at: 0)
    }
    
    func addMainView(_ view: UIView) {
        addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
}
