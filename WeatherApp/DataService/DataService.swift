//
//  DataService.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class DataService {
    
    enum RequestName {
        case locationSearch
        case currentConditions
        case hourluForecasts
        case dailyForecasts
        
        var string: String {
            get {
                switch self {
                case .locationSearch:    return "https://dataservice.accuweather.com/locations/v1/cities/autocomplete"
                case .currentConditions: return "https://dataservice.accuweather.com/currentconditions/v1/"
                case .hourluForecasts:   return "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/"
                case .dailyForecasts:    return "https://dataservice.accuweather.com/forecasts/v1/daily/5day/"
                }
            }
        }
    }

    static let shared = DataService()
    
    func getData<Type: Codable>(for requestName: RequestName, locationId: String?, parameters: Parameters, completion: @escaping (Type?)->()) {
        let baseLink = requestName.string
        guard let url = URLMaker.shared.getURL(baseLink: baseLink, locationId: locationId, parameters: parameters) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(Type?.self, from: data)
                completion(model)
            } catch {
                print(error.localizedDescription)
            }
        }
        print("network activity")
        task.resume()
    }
}
