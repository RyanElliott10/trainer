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
        return chartView
    }()
    
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
        chartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        chartView.setNeedsDisplay()
        
        view.addSubview(chartView)
        chartView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 200)
    }
    
    private func setChartValues(_ count: Int = 20) {
        let values = (0..<count).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(count)) + 3)
            return ChartDataEntry(x: Double(i), y: val)
        }
        
        let set1 = LineChartDataSet(entries: values, label: "Dataset 1")
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        
        chartView.data = data
    }
    
}
