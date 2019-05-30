//
//  CitiesPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation
import UIKit

class CitiesPresenter {
    
    let cityCellPresenter = CityCellPresenter()
    let detailsPresenter = DetailsPresenter()
    
    var cities = [("324505", "Kyiv")
//                  ("326175", "Vinnytsia"),
//                  ("22889", "Sydney")
                 ]
    var numberOfCities: Int {
        get {
            return cities.count
        }
    }
    private var currentConditions: CurrentConditionsModel = []
    
    func setView(citiesVC: CitiesViewController) {
        citiesVC.navigationItem.title = "Cities"
        downloadData()
//        DispatchQueue.main.async {
//            citiesVC.tableView.reloadData()
//        }
    }
    
    func setCellData(cell: CityTableViewCell, for index: Int) {
        let model = currentConditions[index]
        let cityName = cities[index].1
        self.cityCellPresenter.setCellData(cell: cell, cityName: cityName, model: model)
    }
    
    private func downloadData() {
        for item in cities {
            let downloadGroup = DispatchGroup()
            let cityId = item.0
            downloadGroup.enter()
            DataService.shared.getData(for: .currentConditions, cityId: cityId, parameters: nil) { [weak self] (model: CurrentConditionsModel?) in
                guard let model = model else { return }
                self?.currentConditions.append(contentsOf: model)
                downloadGroup.leave()
            }
            downloadGroup.wait()
        }
    }
    
    func presentDetailsController(citiesVC: CitiesViewController, index: Int) {
        print("cell tapped")
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        print(storyboard)
        let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        print(detailsVC)
        detailsVC.detailsPresenter = detailsPresenter
        detailsPresenter.setDetails(numberOfCities: numberOfCities)
        let cityId = cities[index].0
        let cityName = cities[index].1
        let dateTime = currentConditions[index].localObservationDateTime
        let temperature = currentConditions[index].temperature?.metric?.value
        let weatherText = currentConditions[index].weatherText
        let weatherIcon = currentConditions[index].weatherIcon
        
        detailsPresenter.setDataInPresenter(index: index, cityId: cityId, cityName: cityName, dateTime: dateTime, temperature: temperature, weatherText: weatherText, weatherIcon: weatherIcon)
        citiesVC.navigationController?.pushViewController(detailsVC, animated: true)
    }

    
}
