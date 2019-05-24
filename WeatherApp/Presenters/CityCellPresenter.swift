//
//  CityCellPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class CityCellPresenter {
    
    var metricTemperatureText = "N/A"
    var imperialTemperatureText = "N/A"
    
    func setCellData(cell: CityTableViewCell, model: CurrentConditionsModel) {
        guard let metricTemperature = model.first?.temperature?.metric?.value else { return }
        metricTemperatureText = "\(metricTemperature)ºC"
        guard let imperialTemperature = model.first?.temperature?.imperial?.value else { return }
        imperialTemperatureText = "\(imperialTemperature)ºF"
        let temperatureText = self.metricTemperatureText + " / " + self.imperialTemperatureText
        

        DispatchQueue.main.async {
            switch model.first?.isDayTime {
            case false:
                cell.viewContainer.layer.backgroundColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 0.5977400751)
                cell.cityNameLabel.textColor = .white
                cell.temperatureLabel.textColor = .white
            default:
                cell.viewContainer.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7004090665)
                cell.cityNameLabel.textColor = .black
                cell.temperatureLabel.textColor = .black
            }
            cell.temperatureLabel.text = temperatureText
        }
    }
}
