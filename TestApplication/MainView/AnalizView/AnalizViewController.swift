//
//  AnalizViewController.swift
//  TestApplication
//
//  Created by Магомед Абдуразаков on 18.10.2020.
//  Copyright © 2020 Магомед Абдуразаков. All rights reserved.
//

import UIKit
import Charts


protocol AnalizViewInputProtocol: class {
    
    // MARK: - Public method
    
    func getTheNumberOfGoals(activeGoals: Int?, doneGoals: Int?, undoneGoals: Int?)
}

class AnalizViewController: UIViewController, ChartViewDelegate, AnalizViewInputProtocol {
    
    
    // MARK: - Private properties
    
    private var labels = [" "]
    private var activeGoals: Int?
    private var doneGoals: Int?
    private var undoneGoals: Int?
    private var summa: Int?
    private var maxNumber: Int?
    
    
    // MARK: - Public properties
    
    var pieCharts: PieChartView!
    var barCharts: BarChartView!
    var presenter: AnalizViewOutputProtocol!
    
        // MARK: - IBoutlet
    
    @IBOutlet var itemName: UINavigationItem!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.showStatistics()
        initViews()
        pieCharts.delegate = self
        createWindow()
        setupPieChart()
        setupBarChart()
        changeProperties()
    }
    
    
    // MARK: - Private methods
    
    private func changeProperties() {
        navigationItem.title = NSLocalizedString("Statistics", comment: "Статистика")
    }
    
    private func initViews() {
        
        self.pieCharts = PieChartView()
        self.barCharts = BarChartView()
        
        pieCharts?.translatesAutoresizingMaskIntoConstraints = false
        barCharts?.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(pieCharts)
        self.view.addSubview(barCharts)
    }
    
    private func createWindow(){
        
        let pieChartsTopConstraint = NSLayoutConstraint(item: pieCharts!, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: self.view.bounds.height * 0.15)
        
        let pieChartsRightConstraint = NSLayoutConstraint(item: pieCharts!, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0)
        
        let pieChartsLeftConstraint = NSLayoutConstraint(item: pieCharts!, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0)
        
        let pieChartsHeight = NSLayoutConstraint(item: pieCharts!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.bounds.height * 0.35)
        
        let barChartsTopConstraint = NSLayoutConstraint(item: barCharts!, attribute: .top, relatedBy: .equal, toItem: pieCharts, attribute: .bottom, multiplier: 1.0, constant: self.view.bounds.height * 0.1)
        
        let barChartsRightConstraint = NSLayoutConstraint(item: barCharts!, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: 0)
        
        let barChartsLeftConstraint = NSLayoutConstraint(item: barCharts!, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: 0)
        
        let barChartsHeight = NSLayoutConstraint(item: barCharts!, attribute: .height, relatedBy: .equal, toItem: .none, attribute: .notAnAttribute, multiplier: 1.0, constant: self.view.bounds.height * 0.35)
        
        self.view.addConstraints([pieChartsTopConstraint, pieChartsLeftConstraint, pieChartsRightConstraint, pieChartsHeight, barChartsTopConstraint, barChartsLeftConstraint, barChartsHeight, barChartsRightConstraint])
    }
    
    private func setupPieChart() {
        
        pieCharts.setExtraOffsets(left: 0, top: 0, right:0, bottom: 0)
        pieCharts.entryLabelColor = .black
        pieCharts.holeRadiusPercent = CGFloat(0.4)
        pieCharts.tintColor = .black
        pieCharts.tintColorDidChange()
        pieCharts.highlightPerTapEnabled = false
        pieCharts.usePercentValuesEnabled = false
        pieCharts.drawEntryLabelsEnabled = false
        pieCharts.usePercentValuesEnabled = true
        
        if #available(iOS 13.0, *) {
            pieCharts.holeColor = UIColor.systemBackground
        }
        
        var entries = [PieChartDataEntry]()
        
        if activeGoals != 0 {
            let dataEntryFirst = PieChartDataEntry(value: Double(self.activeGoals!), label: NSLocalizedString("Active", comment: "Активные") , data: nil)
            entries.append(dataEntryFirst)
            labels.append("Active")
        }
        
        if doneGoals != 0 {
            let dataEntrySecond = PieChartDataEntry(value: Double(self.doneGoals!), label: NSLocalizedString("Completed", comment: "Выполненные"))
            entries.append(dataEntrySecond)
            labels.append("Completed")
        }
        
        if undoneGoals != 0 {
            let dataEntryThird = PieChartDataEntry(value: Double(self.undoneGoals!), label: NSLocalizedString("Unfulfilled", comment: "Невыполненные"))
            entries.append(dataEntryThird)
            labels.append("Unfulfilled")
        }
        
        pieCharts.entryLabelFont = NSUIFont(name: "HelveticaNeue", size: 20.0)
        
        let set = PieChartDataSet(entries)
        set.colors = [UIColor.init(red: 203/255, green: 222/255, blue: 33/255, alpha: 1.0),
                      .green, .red]
        
        let data = PieChartData(dataSet: set)
        data.setValueTextColor(.black)
        
        pieCharts.data = data
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        
        let formattert = NumberFormatter()
        formattert.numberStyle = .percent
        formattert.maximumFractionDigits = 1
        formattert.multiplier = 1.0
        data.setValueFormatter(DefaultValueFormatter(formatter:formattert))
        
        pieCharts.legend.enabled = false
        pieCharts.animate(yAxisDuration: 3)
    }
    
    private func setupBarChart () {
        
        var entries = [BarChartDataEntry]()
        
        if activeGoals! > doneGoals! && activeGoals! > undoneGoals! {
            maxNumber = activeGoals!
        } else if doneGoals! > undoneGoals! {
            maxNumber = doneGoals!
        } else {
            maxNumber = undoneGoals!
        }
        
        if activeGoals != 0 {
            let dataEntryFirst = BarChartDataEntry(x: 1, y: Double(self.activeGoals!))
            entries.append(dataEntryFirst)
        }
        
        if doneGoals != 0 {
            let dataEntrySecond = BarChartDataEntry(x: 2, y: Double(self.doneGoals!))
            entries.append(dataEntrySecond)
        }
        
        if undoneGoals != 0 {
            let dataEntryThird = BarChartDataEntry(x: 3, y: Double(self.undoneGoals!))
            entries.append(dataEntryThird)
        }
        
        let set = BarChartDataSet(entries: entries)
        
        set.colors = [UIColor.init(red: 203/255, green: 222/255, blue: 33/255, alpha: 1.0),
                      .green, .red]
        
        let data = BarChartData(dataSet: set)
        data.setDrawValues(false)
        data.barWidth = Double(0.4)
        let labels = [" ", NSLocalizedString("Active", comment: "Активные"), NSLocalizedString("Completed", comment: "Выполненные"), NSLocalizedString("Unfulfilled", comment: "Невыполненные")]
        
        barCharts.xAxis.valueFormatter = IndexAxisValueFormatter(values:labels)
        barCharts.xAxis.granularity = 1
        barCharts.data = data
        barCharts.animate(yAxisDuration: 3)
        barCharts.leftAxis.drawGridLinesEnabled = false
        barCharts.rightAxis.enabled = false
        barCharts.xAxis.labelPosition = .bottom
        barCharts.rightAxis.drawGridLinesEnabled = false
        barCharts.leftAxis.axisMinimum = 0
        barCharts.leftAxis.axisMaximum = Double(maxNumber! + 1)
        barCharts.leftAxis.granularityEnabled = true
        barCharts.leftAxis.granularity = 1.0
        barCharts.legend.enabled = false
    }
    
    
    // MARK: - Public method
    
    func getTheNumberOfGoals(activeGoals: Int?, doneGoals: Int?, undoneGoals: Int?) {
        self.activeGoals = activeGoals
        self.doneGoals = doneGoals
        self.undoneGoals = undoneGoals
        summa = self.activeGoals! + self.doneGoals! + self.undoneGoals!
    }
    
}
