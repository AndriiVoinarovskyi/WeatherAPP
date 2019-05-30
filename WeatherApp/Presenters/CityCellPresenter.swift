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
    
    var metricTemperatureText = "N/A"
    var imperialTemperatureText = "N/A"
    
    func setCellData(cell: CityTableViewCell, cityName: String, model: CurrentConditionsModelElement) {
        cell.selectionStyle = .none
        cell.cityNameLabel.text = cityName
        cell.viewContainer.layer.cornerRadius = cornerRadius
        metricTemperatureText = TemperatureTextGetter.shared.getText(model.temperature?.metric?.value) + "C"
        imperialTemperatureText = TemperatureTextGetter.shared.getText(model.temperature?.imperial?.value) + "F"
        let temperatureText = self.metricTemperatureText + " / " + self.imperialTemperatureText
        let weatherIcon = WeatherIconNameGetter.shared.getName(iconIndex: model.weatherIcon ?? -1)

        DispatchQueue.main.async {
            switch model.isDayTime {
            case false:
                cell.viewContainer.layer.backgroundColor = nightBackgroundColor
                cell.cityNameLabel.textColor = nightFontColor
                cell.temperatureLabel.textColor = nightFontColor
            default:
                cell.viewContainer.layer.backgroundColor = dayBackgroundColor
                cell.cityNameLabel.textColor = dayFontColor
                cell.temperatureLabel.textColor = dayFontColor
            }
            cell.temperatureLabel.text = temperatureText
            cell.currentConditionsImage.image = UIImage(named: weatherIcon)
        }
    }
}
