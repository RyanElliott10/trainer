//
//  TrackMiniHeaderView.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/23/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit
import Charts

class TrackMiniHeaderView: UICollectionViewCell {
    
    private let workoutStreakView: TrackView = {
        let topColor = UIColor.rgb(red: 240, green: 130, blue: 101)
        let bottomColor = UIColor.rgb(red: 244, green: 104, blue: 62)
        
        let view = TrackView(withTitle: "Streak", type: .counter)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bodyType = .counter
        view.gradients = [topColor.cgColor, bottomColor.cgColor]
        
        return view
    }()
    
    private let goalView: TrackView = {
        let topColor = UIColor.rgb(red: 240, green: 130, blue: 101)
        let bottomColor = UIColor.rgb(red: 62, green: 202, blue: 244)
        
        let view = TrackView(withTitle: "Top Goal", type: .excerpt)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bodyType = .excerpt
        view.gradients = [topColor.cgColor, bottomColor.cgColor]
        
        return view
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.bold)
        label.text = "Progress"
        
        return label
    }()
    
    private let workoutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 26, weight: UIFont.Weight.bold)
        label.text = "Upcoming Workouts"
        
        return label
    }()
    
    private let chartContainer: TrackView = {
        let topColor = UIColor.rgb(red: 0, green: 130, blue: 101)
        let bottomColor = UIColor.rgb(red: 62, green: 202, blue: 0)
        
        let view = TrackView(withTitle: "Weight", type: .excerpt)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bodyType = .chart
        view.gradients = [topColor.cgColor, bottomColor.cgColor]
        
        return view
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
        // TODO: - Add support for an arrow below the progress section that, on tap, will expand that section and display further charts
        
        super.init(frame: frame)
        
        translatesAutoresizingMaskIntoConstraints = false
        setupViews()
        setupChartView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(workoutStreakView)
        NSLayoutConstraint.activate([
            workoutStreakView.topAnchor.constraint(equalTo: contentView.topAnchor),
            workoutStreakView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            workoutStreakView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/5),
            workoutStreakView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        contentView.addSubview(goalView)
        NSLayoutConstraint.activate([
            goalView.topAnchor.constraint(equalTo: contentView.topAnchor),
            goalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            goalView.leadingAnchor.constraint(equalTo: workoutStreakView.trailingAnchor, constant: 6),
            goalView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        contentView.addSubview(progressLabel)
        NSLayoutConstraint.activate([
            progressLabel.topAnchor.constraint(equalTo: workoutStreakView.bottomAnchor, constant: 8),
            progressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            progressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
        
        contentView.addSubview(chartContainer)
        NSLayoutConstraint.activate([
            chartContainer.topAnchor.constraint(equalTo: progressLabel.bottomAnchor, constant: 8),
            chartContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            chartContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            chartContainer.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        contentView.addSubview(workoutLabel)
        NSLayoutConstraint.activate([
            workoutLabel.topAnchor.constraint(equalTo: chartContainer.bottomAnchor, constant: 8),
            workoutLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            workoutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ])
    }
    
    private func setupChartView() {
        setChartValues()
        
        for set in chartView.data!.dataSets as! [LineChartDataSet] {
            set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
            set.drawCirclesEnabled = false
            set.drawFilledEnabled = !set.drawFilledEnabled
        }
        chartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
        chartView.setNeedsDisplay()
        
        chartContainer.addMainView(chartView)
    }
    
    private func setChartValues(_ count: Int = 20) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(count)) + 10)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(entries: values, label: "Dataset 1")
        
        let gradientColors = [UIColor.appPrimary.cgColor, UIColor.appSecondary.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        
        chartView.data = data
    }
    
}
