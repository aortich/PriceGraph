//
//  GraphViewController.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 8/29/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import UIKit
import Charts

class GraphViewController: UIViewController {

    @IBOutlet weak var lineChartView: LineChartView!
    @IBOutlet weak var tableView: UITableView!
    private var presenter: GraphViewControllerPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = GraphViewControllerPresenter(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.initializeGraph()
        self.initializeTableView()
    }
    
    /**
     Sets colors and style for graph, and feeds it data
     */
    func initializeGraph() {
        self.lineChartView.noDataText = "LOADING DATA"
        self.lineChartView.chartDescription?.text = ""
        self.lineChartView.legend.enabled = false
        
        let xAxis = self.lineChartView.xAxis
        xAxis.labelPosition = .topInside
        xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        xAxis.labelTextColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 3600
        xAxis.valueFormatter = DateValueFormatter()
        
        let leftAxis = self.lineChartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelFont = .systemFont(ofSize: 8, weight: .light)
        leftAxis.drawGridLinesEnabled = false
        
        leftAxis.granularityEnabled = true
        leftAxis.labelTextColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        
        let rightAxis = self.lineChartView.rightAxis
        rightAxis.drawLabelsEnabled = false
        rightAxis.drawAxisLineEnabled = false
        
        self.presenter?.retrieveData()
       
    }
    
    /*feeds data to the tableview controller*/
    func initializeTableView() {
         self.presenter?.subscribeTable()
    }
    
    /// Set chart values
    ///
    /// - Parameters:
    ///     - xVals: Values for x axis
    ///     - yVals: Values for y axis
    func setChart(xVals: [Double], yVals: [Double]) {
        let values = (0..<xVals.count).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: xVals[i], y: yVals[i])
        }
        
        let set1 = LineChartDataSet(values: values, label: "Precio")
        set1.drawCircleHoleEnabled = false
        set1.drawCirclesEnabled = false
        set1.fillAlpha = 0.5
        set1.fillColor = UIColor(red: 200/255, green: 211/255, blue: 232/255, alpha: 1)
        set1.highlightColor = UIColor(red: 200/255, green: 211/255, blue: 232/255, alpha: 1)
        set1.drawFilledEnabled = true
        let data = LineChartData(dataSet: set1)
        self.lineChartView.data = data
        self.lineChartView.animate(xAxisDuration: 3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

}
