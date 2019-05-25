//
//  CitiesPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class CitiesPresenter {
    
    let cityCellPresenter = CityCellPresenter()
    
    var cities = ["324505", "326175", "22889"] //
    var numberOfCities: Int {
        get {
            return cities.count
        }
    }
    var currentConditions: CurrentConditionsModel = []
    
    func setView(citiesVC: CitiesViewController) {
        downloadData()
//        DispatchQueue.main.async {
//            citiesVC.tableView.reloadData()
//        }
    }
    
    func setCellData(cell: CityTableViewCell, for index: Int) {
        let model = currentConditions[index]
        self.cityCellPresenter.setCellData(cell: cell, model: model)
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
    
    
    
}
