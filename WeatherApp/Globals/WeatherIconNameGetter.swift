//
//  WeatherIconNameGetter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.28.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class WeatherIconNameGetter {
    
    static let shared = WeatherIconNameGetter()
    
    func getName(iconIndex: Int) -> String {
        var iconName = ""
        for i in 1...45 {
            if i == iconIndex {
                if i < 10 {
                    iconName = "0\(i)-s"
                } else {
                    iconName = "\(i)-s"
                }
                break
            }
        }
        return iconName
    }
}
