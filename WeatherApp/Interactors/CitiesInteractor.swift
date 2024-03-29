//
//  CitiesInteractor.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.24.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class CitiesInteractor {
    
    let citiesViewAlertDelegate: VCAlertDelegate
    
    init(citiesViewAlertDelegate: VCAlertDelegate) {
        self.citiesViewAlertDelegate = citiesViewAlertDelegate
    }
    
    func getSearchResult(for city: String, completion: @escaping (LocationSearchModel) -> ()) {
        
        DataService.shared.getData(for: .locationSearch, cityId: nil, parameters: ["q": city], vcDelegate: citiesViewAlertDelegate) { (locationSearchModel: LocationSearchModel?) in
            guard let locationSearchModel = locationSearchModel else { return }
            completion(locationSearchModel)
        }
    }
    
}
