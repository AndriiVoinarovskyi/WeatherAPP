//
//  CityCellPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class CityCellPresenter {
    
    func setCellData(cell: CityTableViewCell, cityName: String, conditions: String, temperature: String) {
        cell.cityNameLabel.text = cityName
        cell.temperatureLabel.text = temperature + " ºC"
    }
}
