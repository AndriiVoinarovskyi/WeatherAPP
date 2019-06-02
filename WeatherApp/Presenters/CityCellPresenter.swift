//
//  CityCellPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation
import UIKit

class CityCellPresenter {
    
    let citiesViewAlertDelegate: VCAlertDelegate
    
    init(citiesViewAlertDelegate: VCAlertDelegate) {
        self.citiesViewAlertDelegate = citiesViewAlertDelegate
    }
    
    var cityCellInteractor: CityCellInteractor {
        get {
            return CityCellInteractor(citiesViewAlertDelegate: citiesViewAlertDelegate)
        }
    }
    
    var metricTemperatureText = "N/A"
    var imperialTemperatureText = "N/A"
    
    func setCellData(cell: CityTableViewCell, cityId: String, cityName: String, currentConditions: CurrentConditionsModelElement?, completion: @escaping (CurrentConditionsModelElement) -> ()) {
        cell.cityNameLabel.text = cityName
        cell.selectionStyle = .none
        cell.viewContainer.layer.cornerRadius = cornerRadius
        cell.viewContainer.layer.backgroundColor = dayBackgroundColor
        cell.cityNameLabel.textColor = dayFontColor
        cell.temperatureLabel.textColor = dayFontColor
        
        guard let currentConditions = currentConditions else {
            cell.currentConditionsActivityIndicator.startAnimating()
            cityCellInteractor.getCurrentConditions(for: cityId) { [weak self] (model) in
                guard let model = model.first else { return }
                guard let currentConditions = model else { return }
                self?.cellConfiguration(cell: cell, model: currentConditions)
                completion(currentConditions)
            }
            return
        }
        cellConfiguration(cell: cell, model: currentConditions)
    }
    
    func cellConfiguration(cell: CityTableViewCell, model: CurrentConditionsModelElement) {
        metricTemperatureText = TemperatureTextGetter.shared.getText(model.temperature?.metric?.value) + "C"
        imperialTemperatureText = TemperatureTextGetter.shared.getText(model.temperature?.imperial?.value) + "F"
        let temperatureText = self.metricTemperatureText + " / " + self.imperialTemperatureText
        let weatherIcon = WeatherIconNameGetter.shared.getName(iconIndex: model.weatherIcon ?? -1)
        
        DispatchQueue.main.async {
            if model.isDayTime == false {
                cell.viewContainer.layer.backgroundColor = nightBackgroundColor
                cell.cityNameLabel.textColor = nightFontColor
                cell.temperatureLabel.textColor = nightFontColor
            }
            cell.temperatureLabel.text = temperatureText
            cell.currentConditionsImage.image = UIImage(named: weatherIcon)
            cell.currentConditionsActivityIndicator.stopAnimating()
        }
    }
}
