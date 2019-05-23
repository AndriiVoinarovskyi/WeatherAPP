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
    
    var cities = ["Kyiv", "Vinnytsia"]
    var numberOfCities: Int {
        get {
            return cities.count
        }
    }
    
    
    
    func setView(citiesVC: CitiesViewController) {
        DispatchQueue.main.async {
            citiesVC.tableView.reloadData()
        }
    }
    
    func setCellData(cell: CityTableViewCell, index: Int) {
        let cityName = cities[index]
        cityCellPresenter.setCellData(cell: cell, cityName: cityName, conditions: "conditions", temperature: "15")
    }
}
