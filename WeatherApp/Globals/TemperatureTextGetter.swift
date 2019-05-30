//
//  TemperatureTextGetter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.28.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class TemperatureTextGetter {
    
    static let shared = TemperatureTextGetter()
    
    func getText(_ number: Double?) -> (String){
        var text = "N/A"
        guard let number = number else { return "text" }
        text = "\(number)º"
        return text
    }
}
