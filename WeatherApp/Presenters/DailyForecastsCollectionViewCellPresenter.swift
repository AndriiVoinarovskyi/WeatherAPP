//
//  DailyForecastsCollectionViewCellPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.27.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation
import UIKit

class DailyForecastsCollectionViewCellPresenter {
    
    private var minTemperatureText = "N/A"
    private var maxTemperatureText = "N/A"
    
    func setCellData(item: DailyForecast, cell: DailyForecastsCollectionViewCell) {
        guard let dateTime = item.date else { return }
        cell.dateTimeLabel.text = DateTimeFormatter.shared.formatDateTime(input: dateTime, format: .date)
        
        maxTemperatureText = TemperatureTextGetter.shared.getText(item.temperature?.maximum?.value) + "C"
        cell.maxTemperature.text = maxTemperatureText
        
        minTemperatureText = TemperatureTextGetter.shared.getText(item.temperature?.minimum?.value) + "C"
        cell.minTemperature.text = minTemperatureText

        let dayIconName = WeatherIconNameGetter.shared.getName(iconIndex: item.day?.icon ?? -1)
        cell.dayImageView.image = UIImage(named: dayIconName)
        
        let nightIconName = WeatherIconNameGetter.shared.getName(iconIndex: item.night?.icon ?? -1)
        cell.nightImageView.image = UIImage(named: nightIconName)
    }
    
    func configureCell (cell: DailyForecastsCollectionViewCell, height: CGFloat) {
        cell.bounds.size.height = height
        cell.bounds.size.width = widthForecastsCell
        cell.layer.cornerRadius = cornerRadius
        cell.layer.backgroundColor = dayBackgroundColor
        cell.dateTimeLabel.textColor = dayFontColor
        cell.maxTemperature.textColor = dayFontColor
        cell.minTemperature.textColor = dayFontColor
    }
}
