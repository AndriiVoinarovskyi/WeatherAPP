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
        case hourlyForecasts
        case dailyForecasts
        
        var string: String {
            get {
                switch self {
                case .locationSearch:    return "https://dataservice.accuweather.com/locations/v1/cities/autocomplete"
                case .currentConditions: return "https://dataservice.accuweather.com/currentconditions/v1/"
                case .hourlyForecasts:   return "https://dataservice.accuweather.com/forecasts/v1/hourly/12hour/"
                case .dailyForecasts:    return "https://dataservice.accuweather.com/forecasts/v1/daily/5day/"
                }
            }
        }
    }

    static let shared = DataService()
    
    func getData<Type: Codable>(for requestName: RequestName, cityId: String?, parameters: Parameters, vcDelegate: VCAlertDelegate, completion: @escaping (Type?)->()) {
        let baseLink = requestName.string
        guard let url = URLMaker.shared.getURL(baseLink: baseLink, cityId: cityId, parameters: parameters) else {
            let alert = Alert()
            alert.showAlert(title: linkError, message: linkErrorMessage, vcDelegate: vcDelegate)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                let alert = Alert()
                alert.showAlert(title: internetConnectionError, message: internetConnectionErrorMessage, vcDelegate: vcDelegate)
                return
            }
            let decoder = JSONDecoder()
            self.decodeData(data: data, decoder: decoder, vcDel: vcDelegate, completion: { (model: Type?) in
                completion(model)
                print("Data retrieved")
            })
        }
        print("network activity")
        task.resume()
    }
    
    private func decodeData<T: Codable>(data: Data, decoder: JSONDecoder, vcDel: VCAlertDelegate, completion: ((T?) -> ())){
        do {
            let model = try decoder.decode(T.self, from: data)
            completion(model)
        }
        catch {
            print(error.localizedDescription)
            decodeData(data: data, decoder: decoder, vcDel: vcDel) { (model: ServiceUnavailable?) in
                guard let message = model?.message else { return }
                let alert = Alert()
                alert.showAlert(title: message, message: serviceUnavailableErrorMessage, vcDelegate: vcDel)
                print(message)
            }
        }
    }
}
