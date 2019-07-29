//
//  WorkoutCheckView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/27/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit

class WorkoutCheckView: UIView {
    
    // MARK: - Properties
    
    private var datasource: Excercise!
    
    var delegate: WorkoutCell!
    
    private var isChecked: Bool! {
        didSet {
            updateCheckMark()
        }
    }
    
    private var excerciseName: String?
    
    // MARK: - UI
    
    private let checkView: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(checkMarkOnTap), for: .touchUpInside)
        button.tintColor = .white
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize, weight: .medium)
        label.isUserInteractionEnabled = true
        
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    init(withDatsource data: inout Excercise) {
        super.init(frame: .zero)
        
        isChecked = data.isCompleted
        excerciseName = data.name
        datasource = data
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(checkView)
        NSLayoutConstraint.activate([
            checkView.centerYAnchor.constraint(equalTo: centerYAnchor),
            checkView.leadingAnchor.constraint(equalTo: leadingAnchor),
            checkView.widthAnchor.constraint(equalToConstant: 30)
        ])
        updateCheckMark()
        
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: checkView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: checkView.trailingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(checkMarkOnTap))
        titleLabel.addGestureRecognizer(tapRecognizer)
    }
    
    private func updateCheckMark() {
        let image = isChecked ? "check-circle" : "circle"
        self.checkView.setImage(#imageLiteral(resourceName: image).withRenderingMode(.alwaysTemplate), for: .normal)
        
        if isChecked {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: excerciseName!)
            attributeString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, excerciseName?.count ?? 0))
            titleLabel.attributedText = attributeString
        } else {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: excerciseName!)
            titleLabel.attributedText = attributeString
        }
    }
    
    @objc private func checkMarkOnTap() {
        isChecked = !isChecked
        datasource.isCompleted = isChecked
    }
    
}
