//
//  CurrentConditionsModel.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

// MARK: - CurrentConditionModelElement
struct CurrentConditionModelElement: Codable {
    let localObservationDateTime: Date?
    let epochTime: Int?
    let weatherText: String?
    let weatherIcon: Int?
    let hasPrecipitation: Bool?
    let precipitationType: JSONNull?
    let isDayTime: Bool?
    let temperature: CurrentTemperature?
    let mobileLink, link: String?
    
    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

// MARK: - Temperature
struct CurrentTemperature: Codable {
    let metric, imperial: Imperial?
    
    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - Imperial
struct Imperial: Codable {
    let value: Int?
    let unit: String?
    let unitType: Int?
    
    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

typealias CurrentConditionModel = [CurrentConditionModelElement]
