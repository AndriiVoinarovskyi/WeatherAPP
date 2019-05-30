//
//  CitiesInteractor.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.24.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class CitiesInteractor {
    
    func getCurrentConditions(for cityId: String, completion: @escaping (CurrentConditionsModel)->()) {
        DataService.shared.getData(for: .currentConditions, cityId: cityId, parameters: nil) { (currentConditionsModel: CurrentConditionsModel?) in
            guard let currentConditionsModel = currentConditionsModel else { return }
            completion(currentConditionsModel)
        }
    }
}
