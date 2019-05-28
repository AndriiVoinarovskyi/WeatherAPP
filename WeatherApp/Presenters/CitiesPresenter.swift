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
    
    var cities = ["324505"] // "324505", "326175", "22889"
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
        let city = cities[index]
        self.cityCellPresenter.setCellData(cell: cell, city: city, model: model)
    }
    
    private func downloadData() {
        for item in cities {
            let downloadGroup = DispatchGroup()
            downloadGroup.enter()
            DataService.shared.getData(for: .currentConditions, locationId: item, parameters: nil) { [weak self] (model: CurrentConditionsModel?) in
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
        let locationId = cities[index]
        let cityName = cities[index]
        let dateTime = currentConditions[index].localObservationDateTime
        let temperature = currentConditions[index].temperature?.metric?.value
        let weatherText = currentConditions[index].weatherText
        let weatherIcon = currentConditions[index].weatherIcon
        
        detailsPresenter.setDataInPresenter(index: index, locationId: locationId, cityName: cityName, dateTime: dateTime, temperature: temperature, weatherText: weatherText, weatherIcon: weatherIcon)
        citiesVC.navigationController?.pushViewController(detailsVC, animated: true)
    }

    
}
