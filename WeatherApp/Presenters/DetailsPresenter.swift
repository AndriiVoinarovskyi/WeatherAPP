//
//  DetailsPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.25.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation
import UIKit

class DetailsPresenter {
    
    var details: [Details?]? = nil
    var index: Int = 0
    var numberOfHourlyForecasts: Int = 0
    var numberOfDailyForecasts: Int = 0
    
    var detailsViewAlertDelegate: VCAlertDelegate!
    
    var detailsInteractor: DetailsInteractor {
        get {
            return DetailsInteractor(detailsViewAlertDelegate: detailsViewAlertDelegate)
        }
    }
    
    let hourlyForecastsCollectionViewCellPresenter = HourlyForecastsCollectionViewCellPresenter()
    let dailyForecastsCollectionViewCellPresenter = DailyForecastsCollectionViewCellPresenter()
    
    private var temperatureText = "N/A"
    
    func setDetails(numberOfCities: Int) {
        if details == nil {
            details = Array(repeating: nil, count: numberOfCities)
        } else {
            guard let details = details else { return }
            let difference = numberOfCities - details.count
            if difference != 0 {
                for _ in 0..<difference {
                    self.details?.append(nil)
                }
            }
        }
        print("Details count = ", details?.count)
    }
    
    func setDataInPresenter(index: Int, cityId: String, cityName: String, dateTime: String?, temperature: Double?, weatherText: String?, weatherIcon: Int?) {
        self.index = index
        if self.details?[index] == nil {
            var details = Details()
            details.cityId = cityId
            details.cityName = cityName
            details.dateTime = dateTime
            details.temperature = temperature
            details.weatherText = weatherText
            details.weatherIcon = weatherIcon
            self.details?[index] = details
        }
    }
    
    func setDataInVC(detailsVC: DetailsViewController) {
        detailsVC.title = "Weather details"
        detailsViewAlertDelegate = detailsVC
        guard let item = details?[index] else { return }
        detailsVC.cityNameLabel.text = item.cityName
        guard let dateTime = item.dateTime else { return }
        detailsVC.dateTimeLabel.text = DateTimeFormatter.shared.formatDateTime(input: dateTime, format: .timeDate)
        temperatureText = TemperatureTextGetter.shared.getText(item.temperature) + "C"
        detailsVC.temperatureLabel.text = temperatureText
        detailsVC.weatherTextLabel.text = item.weatherText
        let weatherIconName = WeatherIconNameGetter.shared.getName(iconIndex: item.weatherIcon ?? -1)
        detailsVC.weatherIconImageView.image = UIImage(named: weatherIconName)
        
        detailsVC.cityNameLabel.textColor = dayFontColor
        detailsVC.dateTimeLabel.textColor = dayFontColor
        detailsVC.temperatureLabel.textColor = dayFontColor
        detailsVC.weatherTextLabel.textColor = dayFontColor
        
        let cityId = item.cityId
        
        if details?[index]?.hourlyForecasts == nil {
            detailsVC.hourlyForecastsActivityIndicator.startAnimating()
            detailsInteractor.getHourlyForecasts(cityId: cityId) { [weak self] (hourlyForecastsModel: HourlyForecastsModel) in
                guard let index = self?.index else { return }
                self?.details?[index]?.hourlyForecasts = hourlyForecastsModel
                self?.numberOfHourlyForecasts = hourlyForecastsModel.count
                DispatchQueue.main.async {
                    detailsVC.hourlyForecastsCollectionView.reloadData()
                    detailsVC.hourlyForecastsActivityIndicator.stopAnimating()
                }
            }
        }
        
        if details?[index]?.dailyForecasts == nil {
            detailsVC.dailyForecastsActivityIndicator.startAnimating()
            detailsInteractor.getDailyForecasts(cityId: cityId) { [weak self] (dailyForecasts: [DailyForecast]) in
                guard let index = self?.index else { return }
                self?.details?[index]?.dailyForecasts = dailyForecasts
                self?.numberOfDailyForecasts = dailyForecasts.count
                DispatchQueue.main.async {
                    detailsVC.dailyForecastsCollectionView.reloadData()
                    detailsVC.dailyForecastsActivityIndicator.stopAnimating()
                }
            }
        }
    }
    
    func setHourlyForecastsCollectionViewCell(cell: HourlyForecastsCollectionViewCell, index: Int, cellHeight: CGFloat) {
        guard let item = details?[self.index]?.hourlyForecasts?[index] else { return }
        hourlyForecastsCollectionViewCellPresenter.setCellData(item: item, cell: cell)
        guard let isDay = details?[self.index]?.hourlyForecasts?[index].isDaylight else { return }
        hourlyForecastsCollectionViewCellPresenter.configureCell(cell: cell, isDay: isDay, height: cellHeight)
            }
    
    func setDailyForecastsCollectionViewCell(cell: DailyForecastsCollectionViewCell, index: Int, cellHeight: CGFloat) {
        guard let item = details?[self.index]?.dailyForecasts?[index] else { return }
        dailyForecastsCollectionViewCellPresenter.setCellData(item: item, cell: cell)
        dailyForecastsCollectionViewCellPresenter.configureCell(cell: cell, height: cellHeight)
    }
}
