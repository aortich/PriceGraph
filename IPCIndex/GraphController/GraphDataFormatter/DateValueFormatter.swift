//
//  DateValueFormatter.swift
//  IPCIndex
//
//  Created by Alberto Ortiz on 8/29/18.
//  Copyright © 2018 TestInc. All rights reserved.
//

import Foundation
import Charts

/// Formatter for the charts library.
public class DateValueFormatter: NSObject, IAxisValueFormatter {
    private let dateFormatter = DateFormatter()
    
    override init() {
        super.init()
        dateFormatter.dateFormat = "HH:mm"
    }
    
    /// Returns a string representing a time interval in a readable format
    ///
    /// - Returns: a date string in the format "HH:mm"
    /// - Parameters:
    ///     - value: The time interval since 1970 to the current date
    ///     - axis:  The axis to be formatted
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
