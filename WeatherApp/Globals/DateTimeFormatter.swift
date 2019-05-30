//
//  DateTimeFormatter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.29.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class DateTimeFormatter {
    static let shared = DateTimeFormatter()
    
    enum Format {
        case timeDate
        case dateTime
        case time
        case date
    }
    
    func formatDateTime(input: String, format: Format) -> (String) {
        
        var result: [String] = [""]
        var count = 0
        var st = ""
        for char in input {
            if !char.isNumber {
                result[count] = String(st)
                result.append("")
                st = ""
                count += 1
                continue
            }
            st += String(char)
        }
        result[count] = String(st)
        let year = result[0]
        let month = result[1]
        let day = result[2]
        let hours = result[3]
        let minutes = result[4]
        let seconds = result[5]
        
        switch format {
        case .date: return "\(day).\(month).\(year)"
        case .time: return "\(hours):\(minutes):\(seconds)"
        case .dateTime: return "\(day).\(month).\(year)\n\(hours):\(minutes):\(seconds)"
        case .timeDate: return "\(hours):\(minutes):\(seconds)\n\(day).\(month).\(year)"
        }
    }
}
