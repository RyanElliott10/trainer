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
    
    private var gradientLayer: CAGradientLayer?
    
    // MARK: - UI
    
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
    
    private func configureGradientView() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        gradientLayer?.colors = gradients
        gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer?.endPoint = CGPoint(x: 0.0, y: 0.1)
        gradientLayer?.locations = [0.0, 0.1]
        layer.insertSublayer(gradientLayer!, at: 0)
    }
    
    private func setupViews() {
        guard let data = datasource else { return }
        layer.cornerRadius = 8
        layer.shouldRasterize = true
        layer.rasterizationScale = 3
        clipsToBounds = true
        
        let titleString = "\(data.dayOfWeek) - \(data.title)".capitalized
        titleLabel.text = titleString
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        let withTrainer = "With \(data.trainer)"
        withTrainerLabel.text = withTrainer
        contentView.addSubview(withTrainerLabel)
        NSLayoutConstraint.activate([
            withTrainerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            withTrainerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            withTrainerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
}
