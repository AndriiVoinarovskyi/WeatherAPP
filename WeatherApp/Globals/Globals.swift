//
//  Globals.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.24.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

typealias Parameters = [String : String]?

struct Details {
    var cityId: String
    var cityName: String
    var dateTime: String?
    var temperature: Double?
    var weatherText: String?
    var weatherIcon: Int?
    var hourlyForecasts: HourlyForecastsModel?
    var dailyForecasts: [DailyForecast]?
    
    init() {
        cityId = ""
        cityName = ""
        dateTime = ""
        temperature = 0
        weatherText = ""
        weatherIcon = 0
        hourlyForecasts = nil
        dailyForecasts = nil
    }
}

