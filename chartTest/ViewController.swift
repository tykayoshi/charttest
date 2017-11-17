//
//  ViewController.swift
//  chartTest
//
//  Created by Ilkay on 14/11/2017.
//  Copyright © 2017 Ilkay. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {

    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var chrtChart: LineChartView!
    
    var currencyRate = [String]()
    var monthDays = [String]()
    
    var lineDataEntry = [ChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        populateData()
        cubicChartSetup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     
     Quick Testt
     
     2017-10-20 1.1898164332356
     2017-10-19 1.1927098497538
     2017-10-18 1.1893094829112
     2017-10-17 1.1843852644422
     2017-10-16 1.1883221653788
     2017-11-15 1.1832443643065
     2017-11-14 1.1828196968792
     2017-11-13 1.1922178204323
     2017-11-12 1.1835791363967
     2017-11-11 1.1843300086507
     2017-11-10 1.1830416214148
     2017-11-09 1.1844337559896
     2017-11-08 1.1910865785881
     2017-11-07 1.1839330935577
     2017-11-06 1.1904094637085
     2017-11-05 1.1850576519249
     2017-11-04 1.1835559929668
     2017-11-03 1.1854487400976
     2017-11-02 1.1907082788977
     2017-11-01 1.1833036194197
     2017-10-31 1.1863225901901
     2017-10-30 1.1866400078363
     2017-10-29 1.1890137232623
     2017-10-28 1.1923279236448
     2017-10-27 1.1823202458708
     2017-10-26 1.1817660136265
     2017-10-25 1.1853627713156
     2017-10-24 1.1827904085597
     2017-10-23 1.1819739813832
     2017-10-22 1.1896785936734
     2017-10-21 1.1880055207966
 
     */
    
    func populateData() {
        currencyRate = ["1.1830416214148","1.1843300086507","1.1835791363967","1.1922178204323","1.1828196968792","1.1832443643065","1.1883221653788","1.1830416214148","1.1843300086507","1.1835791363967","1.1922178204323","1.1828196968792","1.1832443643065","1.1883221653788", "1.1880055207966", "1.1880055207966"]
        monthDays = ["10","11","12","13","14","15","16","10","11","12","13","14","15","16", "1", "2"]
    }
    
    func cubicChartSetup() {
        // Line Chart Config
        chrtChart.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .linear)
        chrtChart.dragEnabled = false
        chrtChart.isUserInteractionEnabled = false
        setCubicLineChart(dataPoints: monthDays, values: currencyRate)
    }
    
    func setCubicLineChart(dataPoints: [String], values: [String]) {
        
        //No data setup
        chrtChart.noDataTextColor = UIColor.white
        chrtChart.noDataText = "NO DATA MAN!"
        //chrtChart.drawBordersEnabled = true
        chrtChart.backgroundColor = UIColor(red: 7/255, green: 92/255, blue: 103/255, alpha: 1)
        
        //Data point setup and color config
        
        for i in 0..<dataPoints.count {
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(values[i])!)
            lineDataEntry.append(dataPoint)
        }
        
        let chartDataSet = LineChartDataSet(values: lineDataEntry, label: "Currency Rate")
        let chartData = LineChartData()
        
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(false) // False if i dont have values above bar
        chartDataSet.colors = [UIColor(red: 70/255, green: 175/255, blue: 188/255, alpha: 1)] // Line Colour
        chartDataSet.lineWidth =  2.5
        chartDataSet.setCircleColor(UIColor.clear)
        chartDataSet.circleHoleColor = UIColor(red: 70/255, green: 175/255, blue: 188/255, alpha: 1)
        chartDataSet.circleRadius = 5.0
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2 // Dont touch haha
        chartDataSet.drawCirclesEnabled = false // Draw value circles
        
        chartDataSet.drawValuesEnabled = false
        
        //chartDataSet.valueFont = UIFont(name: "Helvetica", size: 12.0)!
        //chartDataSet.valueColors = [UIColor.black]
        
        // Gradient Fill
        /*let gradientColors = [UIColor.blue.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0,0.0] // Position the gradient
        guard let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations) else {
            print("gradient error")
            return
        }
        
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient, angle: 90.0)
        chartDataSet.drawFilledEnabled = true*/
        
        
        // Axes setup
        let formatter: ChartFormatter = ChartFormatter ()
        formatter.setValues(values: dataPoints)
        
        // X Axis (Months/days)
        let xAxis:XAxis = XAxis()
        
        xAxis.valueFormatter = formatter
        chrtChart.xAxis.labelPosition = .bottom
        //chrtChart.xAxis.axisRange = 2.0
        chrtChart.xAxis.labelCount = 2 //  Only show 2 labels
        chrtChart.xAxis.drawGridLinesEnabled = false // Turns off grid lines for X Axis
        chrtChart.xAxis.labelTextColor = UIColor(red: 178/255, green: 223/255, blue: 219/255, alpha: 1)
        chrtChart.xAxis.labelFont = UIFont(name: "Helvetica-Bold", size: 20.0)!
        chrtChart.xAxis.drawAxisLineEnabled = true
        chrtChart.xAxis.axisLineWidth = 2.0 // Axis thickness
        chrtChart.xAxis.axisLineColor = UIColor(red: 178/255, green: 223/255, blue: 219/255, alpha: 1) // Axis line colour
        chrtChart.xAxis.valueFormatter = xAxis.valueFormatter
        chrtChart.chartDescription?.enabled = false // Turns off chart description
        chrtChart.legend.enabled = true // Tell you what the line is showing, eg. Currency Rate
        
        // Right Axis
        chrtChart.rightAxis.drawLabelsEnabled = false // Disable Label on right axis
        chrtChart.rightAxis.drawAxisLineEnabled = false // Turns off the axis
        chrtChart.rightAxis.drawGridLinesEnabled = false // Turns off horrible grid lines
        
        // Left Axis (Currency Rate)
        chrtChart.leftAxis.drawGridLinesEnabled = false
        chrtChart.leftAxis.drawAxisLineEnabled = false
        chrtChart.leftAxis.labelTextColor = UIColor(red: 178/255, green: 223/255, blue: 219/255, alpha: 1)
        chrtChart.leftAxis.labelFont = UIFont(name: "Helvetica-Bold", size: 20.0)!
        chrtChart.leftAxis.drawLabelsEnabled = true
        
        // Middle Value Line
        let middleValue = ChartLimitLine(limit: 1.187, label: "") // Grab middle limit from array
        middleValue.lineDashPhase = 10.0 // Create dashed lines
        middleValue.lineDashLengths = [15.0] // Create dashed lines, experimental
        middleValue.lineColor = UIColor(red: 178/255, green: 223/255, blue: 219/255, alpha: 1)
        middleValue.lineWidth = 2.0
        //middleValue.labelPosition = .leftTop
        chrtChart.rightAxis.addLimitLine(middleValue)
        
        // Top Limit Line
        let topValue = ChartLimitLine(limit: 1.1923, label: "") // Grab top limit from array
        topValue.lineColor = UIColor(red: 178/255, green: 223/255, blue: 219/255, alpha: 1)
        topValue.lineWidth = 2.0
        chrtChart.rightAxis.addLimitLine(topValue)
    
        chrtChart.data = chartData
        
    }
}

public class ChartFormatter: NSObject, IAxisValueFormatter {
    
    var currencyRate = [String]()
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return currencyRate[Int(value)]
    }
    
    public func setValues(values: [String]) {
        self.currencyRate = values
    }
    
}
 
