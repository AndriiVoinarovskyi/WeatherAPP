//
//  HourlyForecastsModel.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation


// MARK: - HourlyForecastModelElement
struct HourlyForecastsModelElement: Codable {
    let dateTime: String?
    let epochDateTime, weatherIcon: Int?
    let iconPhrase: String?
    let isDaylight: Bool?
    let temperature: TemperatureHourly?
    let precipitationProbability: Int?
    let mobileLink, link: String?
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "DateTime"
        case epochDateTime = "EpochDateTime"
        case weatherIcon = "WeatherIcon"
        case iconPhrase = "IconPhrase"
        case isDaylight = "IsDaylight"
        case temperature = "Temperature"
        case precipitationProbability = "PrecipitationProbability"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

// MARK: - Temperature
struct TemperatureHourly: Codable {
    let value: Double?
    let unit: UnitHourly?
    let unitType: Int?
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

enum UnitHourly: String, Codable {
    case c = "C"
    case f = "F"
}

typealias HourlyForecastsModel = [HourlyForecastsModelElement]

