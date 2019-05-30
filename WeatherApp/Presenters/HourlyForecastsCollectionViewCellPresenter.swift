//
//  HourlyForecastsCollectionViewCellPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.27.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation
import UIKit

class HourlyForecastsCollectionViewCellPresenter {
    
    private var temperatureText = "N/A"
    
    func setCellData(item: HourlyForecastsModelElement, cell: HourlyForecastsCollectionViewCell) {
        guard let dateTime = item.dateTime else { return }
        cell.dateTimeLabel.text = DateTimeFormatter.shared.formatDateTime(input: dateTime, format: .time)
        temperatureText = TemperatureTextGetter.shared.getText(item.temperature?.value) + "C"
        cell.maxTemperatureLabel.text = temperatureText
        let iconName = WeatherIconNameGetter.shared.getName(iconIndex: item.weatherIcon ?? -1)
        cell.weatherIconImageView.image = UIImage(named: iconName)
    }
    
    func configureCell (cell: HourlyForecastsCollectionViewCell, isDay: Bool, height: CGFloat) {
        cell.bounds.size.height = height
        cell.bounds.size.width = widthForecastsCell
        cell.layer.cornerRadius = cornerRadius
        switch isDay {
        case false:
            cell.layer.backgroundColor = nightBackgroundColor
            cell.dateTimeLabel.textColor = nightFontColor
            cell.maxTemperatureLabel.textColor = nightFontColor
        default:
            cell.layer.backgroundColor = dayBackgroundColor
            cell.dateTimeLabel.textColor = dayFontColor
            cell.maxTemperatureLabel.textColor = dayFontColor
        }
    }
}
