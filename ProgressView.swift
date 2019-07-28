//
//  ProgressView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/23/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit
import Charts

public enum ProgressViewType {
    case counter
    case chart
    case excerpt
}

class ProgressView: UICollectionViewCell {
    
    // MARK: - Properties
    
    open var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    open var bodyType: ProgressViewType = .chart
    
    open var gradients: [CGColor] = [UIColor.black.cgColor] {
        didSet {
            configureGradientView()
        }
    }
    
    open var datasource: ProgressDatasource? {
        didSet {
            guard let data = datasource else { return }
            title = data.title
            bodyType = data.type
        }
    }
    
    private var gradientLayer: CAGradientLayer?
    
    // MARK: - UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.semibold)
        label.sizeToFit()
        label.numberOfLines = 2
        
        return label
    }()
    
    private let chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.drawGridBackgroundEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartView.extraTopOffset = 5
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 35
        chartView.xAxis.labelTextColor = .white
        chartView.leftAxis.labelTextColor = .white
        
        return chartView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // TODO: - Center all the labels in the middle of the view, no matter its height
    }
    
    convenience init(withTitle title: String, type: ProgressViewType) {
        self.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer?.frame = bounds
    }
    
    override func prepareForReuse() {
        for view in contentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    // MARK: - View Setup
    
    func setupViews() {
        layer.cornerRadius = 8
        clipsToBounds = true
        
        contentView.addSubview(titleLabel)
        titleLabel.text = title
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        setupBodyView()
    }
    
    private func setupBodyView() {
        switch bodyType {
        case .counter: setupCounter()
        case .chart: setupChart()
        case .excerpt: setupExcerpt()
        }
    }
    
    private func setupCounter() {
        contentView.addSubview(counterNumber)
        counterNumber.text = "13"
        
        NSLayoutConstraint.activate([
            counterNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            counterNumber.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
        ])
        
        contentView.addSubview(bodyLabel)
        bodyLabel.text = "Workouts"
        
        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: counterNumber.trailingAnchor, constant: 4),
            bodyLabel.bottomAnchor.constraint(equalTo: counterNumber.bottomAnchor, constant: -4),
            bodyLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * (2 / 5))
        ])
    }
    
    private func setupExcerpt() {
        contentView.addSubview(bodyLabel)
        bodyLabel.text = "Lose weight, get shredded for summer  💪"
        
        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    
    private func configureGradientView() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = bounds
        gradientLayer?.colors = gradients
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer?.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer?.locations = [0, 1]
        layer.insertSublayer(gradientLayer!, at: 0)
    }
    
    func addMainView(_ view: UIView) {
        contentView.addSubview(view)
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    private func setupChart() {
        chartView.data = datasource?.setupChartValues()
        
        for set in chartView.data!.dataSets as! [LineChartDataSet] {
            set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
            set.drawCirclesEnabled = false
            set.drawFilledEnabled = !set.drawFilledEnabled
        }
        chartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
        chartView.setNeedsDisplay()
        
        addMainView(chartView)
    }
    
}
