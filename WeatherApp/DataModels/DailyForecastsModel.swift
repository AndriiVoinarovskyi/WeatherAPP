//
//  DailyForecastsModel.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

// MARK: - DailyForecastModel
struct DailyForecastsModel: Codable {
    let headline: Headline?
    let dailyForecasts: [DailyForecast]?
    
    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let date: String?
    let epochDate: Int?
    let temperature: TemperatureDaily?
    let day, night: Day?
    let sources: [String]?
    let mobileLink, link: String?
    
    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

// MARK: - Day
struct Day: Codable {
    let icon: Int?
    let iconPhrase: String?
    
    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
    }
}

// MARK: - Temperature
struct TemperatureDaily: Codable {
    let minimum, maximum: Imum?
    
    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - Imum
struct Imum: Codable {
    let value: Double?
    let unit: UnitDaily?
    let unitType: Int?
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

enum UnitDaily: String, Codable {
    case c = "C"
    case f = "F"
}

// MARK: - Headline
struct Headline: Codable {
    let effectiveDate: String?
    let effectiveEpochDate, severity: Int?
    let text, category: String?
    let endDate: String?
    let endEpochDate: Int?
    let mobileLink, link: String?
    
    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
