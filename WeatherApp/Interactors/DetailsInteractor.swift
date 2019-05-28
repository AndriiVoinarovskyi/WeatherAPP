//
//  DetailsInteractor.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.27.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class DetailsInteractor {
    
    func getHourlyForecasts(locationId: String, completion: @escaping (HourlyForecastsModel)->()) {
        DataService.shared.getData(for: .hourlyForecasts, locationId: locationId, parameters: ["metric" : "true"]) { (hourlyForecastsModel: HourlyForecastsModel?) in
            guard let model = hourlyForecastsModel else { return }
            completion(model)
        }
    }
    
    func getDailyForecasts(locationId: String, completion: @escaping ([DailyForecast])->()) {
        DataService.shared.getData(for: .dailyForecasts, locationId: locationId, parameters: ["metric" : "true"]) { (dailyForecastsModel: DailyForecastsModel?) in
            guard let model = dailyForecastsModel?.dailyForecasts else { return }
            completion(model)
        }
    }

}
