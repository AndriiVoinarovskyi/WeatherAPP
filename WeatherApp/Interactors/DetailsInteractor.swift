//
//  DetailsInteractor.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.27.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class DetailsInteractor {
    
    func getHourlyForecasts(cityId: String, completion: @escaping (HourlyForecastsModel)->()) {
        DataService.shared.getData(for: .hourlyForecasts, cityId: cityId, parameters: ["metric" : "true"]) { (hourlyForecastsModel: HourlyForecastsModel?) in
            print("data is gotten")
            guard let model = hourlyForecastsModel else { return }
            completion(model)
        }
    }
    
    func getDailyForecasts(cityId: String, completion: @escaping ([DailyForecast])->()) {
        DataService.shared.getData(for: .dailyForecasts, cityId: cityId, parameters: ["metric" : "true"]) { (dailyForecastsModel: DailyForecastsModel?) in
            guard let model = dailyForecastsModel?.dailyForecasts else { return }
            completion(model)
        }
    }

}
