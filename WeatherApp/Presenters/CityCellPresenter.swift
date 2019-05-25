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
    
    func setCellData(cell: CityTableViewCell, model: CurrentConditionsModelElement) {
        cell.selectionStyle = .none
        guard let metricTemperature = model.temperature?.metric?.value else { return }
        metricTemperatureText = "\(metricTemperature)ºC"
        guard let imperialTemperature = model.temperature?.imperial?.value else { return }
        imperialTemperatureText = "\(imperialTemperature)ºF"
        let temperatureText = self.metricTemperatureText + " / " + self.imperialTemperatureText
        let weatherIcon = getPictureName(iconIndex: model.weatherIcon ?? -1)

        DispatchQueue.main.async {
            switch model.isDayTime {
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
            cell.currentConditionsImage.image = UIImage(named: weatherIcon)
        }
    }
    
    private func getPictureName(iconIndex: Int) -> String {
        var iconName = ""
        for i in 1...45 {
            if i == iconIndex {
                if i < 10 {
                    iconName = "0\(i)-s"
                } else {
                    iconName = "\(i)-s"
                }
                break
            }
        }
        return iconName
    }
}
