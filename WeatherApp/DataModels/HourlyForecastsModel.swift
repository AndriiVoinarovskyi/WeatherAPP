//
//  HourlyForecastsModel.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation


// MARK: - HourlyForecastModelElement
struct HourlyForecastModelElement: Codable {
    let dateTime: Date?
    let epochDateTime, weatherIcon: Int?
    let iconPhrase: String?
    let isDaylight: Bool?
    let temperature: Temperature?
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
struct Temperature: Codable {
    let value: Double?
    let unit: Unit?
    let unitType: Int?
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

enum Unit: String, Codable {
    case c = "C"
}

typealias HourlyForecastModel = [HourlyForecastModelElement]

