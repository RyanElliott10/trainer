//
//  ProgressDatasource.swift
//  Trainer
//
//  Created by Ryan Elliott on 7/27/19.
//  Copyright © 2019 Ryan Elliott. All rights reserved.
//

import Foundation
import Charts

struct ProgressDatasource {
    
    // MARK: - Properties
    
    var title: String
    
    var type: ProgressViewType
    
    // Excerpt
    
    var body: String?
    
    // Streaks
    
    var streakCount: Int?
    
    var streakClassifier: String?
    
    // Chart
    
    var rawData: [Any]?
    
    var values: [ChartDataEntry]?
    
    var dataSet: LineChartDataSet?
    
    var data: LineChartData?
    
    // MARK: - Init
    
    init(type: ProgressViewType, title: String, streakCount: Int, streakClassifier: String) {
        self.type = type
        self.title = title
        self.streakCount = streakCount
        self.streakClassifier = streakClassifier
    }
    
    init(type: ProgressViewType, title: String, body: String) {
        self.type = type
        self.title = title
        self.body = body
    }
    
    init(type: ProgressViewType, title: String, rawData: [Any]?, values: [ChartDataEntry]?, dataSet: LineChartDataSet?
        , data: LineChartData?) {
        self.type = type
        self.title = title
        self.rawData = rawData
        self.values = values
        self.dataSet = dataSet
        self.data = data
    }
    
    // MARK: - Functions
    
    mutating func setupChartValues() -> LineChartData? {
        let count = rawData?.count ?? 0

        values = (0..<count * 2).map { (i) -> ChartDataEntry in
            let val = Double(arc4random_uniform(UInt32(count)) + 10)
            return ChartDataEntry(x: Double(i), y: val)
        }

        dataSet = LineChartDataSet(entries: values, label: "Dataset 1")

        let gradientColors = [UIColor.appPrimary.cgColor, UIColor.appSecondary.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        dataSet?.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)

        data = LineChartData(dataSet: dataSet)
        data?.setDrawValues(false)
        
        return data
    }
    
    static func generateDummyData() -> [ProgressDatasource] {
        let data1 = ProgressDatasource(type: .counter, title: "Streak", streakCount: 13, streakClassifier: "Workouts")
        let data2 = ProgressDatasource(type: .excerpt, title: "Top Goal", body: "Lose weight, get shredded for summer 💪")
        let data3 = ProgressDatasource(type: .chart, title: "Weight", rawData: [0,1,2,3,4,5,6,7,8,9], values: nil, dataSet: nil, data: nil)
        
        return [data1, data2, data3]
    }
    
}
