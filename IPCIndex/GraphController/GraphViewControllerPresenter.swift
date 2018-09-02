//
//  GraphViewControllerPresenter.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 8/29/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class GraphViewControllerPresenter: NSObject {
    var viewController: GraphViewController
    private let dateFormatter = DateFormatter()
    private let tableDateFormatter = DateFormatter()
    private let numberFormatter = NumberFormatter()
    private let cellIdentifier = "IndiceCell"
    private var disposeBag = DisposeBag()
    
    init(_ vc: GraphViewController) {
        self.viewController = vc
        self.dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        self.tableDateFormatter.dateFormat = "HH:mm:ss"
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.locale = Locale(identifier: "es-MX")
    }
    
    /**
     Feeds the graph within GraphViewController with GraphData obtained from a webservice
     */
    func retrieveData() {
        let repo = ObtenerDatosGraficoRepository()
        
        _ = repo.getDatosGrafico(empresa: "IPC")?.observeOn(MainScheduler.instance)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe (
                onNext: {
                    graphData in
                    let dates = graphData.resultObj.map { self.dateIntervalFromDateString($0.fecha) }
                    let precio = graphData.resultObj.map { $0.precio }
                    self.viewController.setChart(xVals: dates, yVals: precio)
                    
            }).disposed(by: disposeBag)
    }
    
    /**
     Subscribes the GraphViewController table view to an observable stream of graph results and sets
     the cell nib
     */
    func subscribeTable() {
        self.viewController.tableView.delegate = nil
        self.viewController.tableView.dataSource = nil
        
        self.viewController.tableView.tableFooterView = UIView()
        self.viewController.tableView.register(UINib(nibName: "IndiceCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        
        let repo = ObtenerDatosGraficoRepository()
        
        Observable<NSInteger>.interval(3.0, scheduler: MainScheduler.instance)
            .flatMap { n -> Observable<GraphData> in
                return repo.getDatosGrafico(empresa: "IPC")!
            }
            .map { (graphData) -> [ResultObj] in
                return graphData.resultObj.sorted(by: { (a, b) -> Bool in
                    return self.dateFromDateString(a.fecha) > self.dateFromDateString(b.fecha)
                }) }
            .bind(to: self.viewController.tableView.rx.items(cellIdentifier: cellIdentifier)) {
                (index, resultObj, cell) in
                if let lblFecha = cell.viewWithTag(10) as? UILabel {
                    lblFecha.text = self.formatDateString(resultObj.fecha)
                }
                if let lblPrecio = cell.viewWithTag(20) as? UILabel {
                    lblPrecio.text = self.numberFormatter.string(from:
                        (NSNumber(value: resultObj.precio)))
                }
            }
            .disposed(by: disposeBag)
    }
    
    
    
    /**
     Gets the time interval for a given date string
     - important: The date format needs to be as follows "yyyy-MM-dd'T'HH:mm:ss.SZ"
             - dateString: the date string
     - returns: a double with the unix time interval
     */
    private func dateIntervalFromDateString(_ dateString: String) -> Double {
        return (self.dateFormatter.date(from: dateString)?.timeIntervalSince1970) ?? 0
    }
    
    
    /**
     Gets a date object given a date string
     - important: The date format needs to be as follows "yyyy-MM-dd'T'HH:mm:ss.SZ"
     - parameters:
        - dateString: the date string
     - returns: a double with the unix time interval
     */
    private func dateFromDateString(_ dateString: String) -> Date {
        return self.dateFormatter.date(from: dateString) ?? Date()
    }
    
    /**
     Returns a date in an appropriate format to show to the user, given a date string
     - important: The date format needs to be as follows "yyyy-MM-dd'T'HH:mm:ss.SZ"
     - parameters:
        - dateString: the date string
     - returns: a double with the unix time interval
     */
    private func formatDateString(_ dateString: String) -> String {
        guard let date = self.dateFormatter.date(from: dateString) else {
            return ""
        }
        
        return self.tableDateFormatter.string(from: date)
    }
    
    
    
}
