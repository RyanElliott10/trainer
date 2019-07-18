//
//  ProgressViewController.swift
//  Trainer
//
//  Created by Ryan Elliott on 4/21/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import UIKit
import Charts

class ProgressViewController: UIViewController {
    
    private let chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.drawGridBackgroundEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.enabled = false
        chartView.leftAxis.drawGridLinesEnabled = false
        chartView.xAxis.labelPosition = XAxis.LabelPosition.bottom
        chartView.extraTopOffset = 5
        chartView.leftAxis.axisMinimum = 0
        chartView.leftAxis.axisMaximum = 35
        return chartView
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Press me", for: .normal)
        return button
    }()
    
    @objc func buttonPress() {
        viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Your Journey"
        
        setChartValues()
        
        for set in chartView.data!.dataSets as! [LineChartDataSet] {
            set.mode = (set.mode == .cubicBezier) ? .linear : .cubicBezier
            set.drawCirclesEnabled = false
            set.drawFilledEnabled = !set.drawFilledEnabled
        }
        chartView.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
        chartView.setNeedsDisplay()
        
        view.addSubview(chartView)
        chartView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 200)
        
        view.addSubview(button)
        button.anchor(top: chartView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40)
        button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
    }
    
    private func setChartValues(_ count: Int = 20) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(count)) + 10)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(entries: values, label: "Dataset 1")
        
        let gradientColors = [UIColor.appPrimaryColor.cgColor, UIColor.appSecondaryColor.cgColor] as CFArray // Colors of the gradient
        let colorLocations:[CGFloat] = [1.0, 0.0] // Positioning of the gradient
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) // Gradient Object
        set1.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0) // Set the Gradient
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        
        chartView.data = data
    }
    
}
