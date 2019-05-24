//
//  CitiesPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class CitiesPresenter {
    
    let cityCellPresenter = CityCellPresenter()
    
    var cities = ["324505", "326175", "22889"] //
    var numberOfCities: Int {
        get {
            return cities.count
        }
    }
    
    
    func setView(citiesVC: CitiesViewController) {
//        DispatchQueue.main.async {
//            citiesVC.tableView.reloadData()
//        }
    }
    
    func setCellData(cell: CityTableViewCell, for index: Int) {
        DataService.shared.getData(for: .currentConditions, locationId: cities[index], parameters: nil) { (model: CurrentConditionsModel?) in
            guard let model = model else { return }
            self.cityCellPresenter.setCellData(cell: cell, model: model)
        }
    }
}
