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
    
    let citiesInteractor = CitiesInteractor()
    let cityCellPresenter = CityCellPresenter()
    let citiesSearchCellPresenter = CitiesSearchCellPresenter()
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
    
    var searchText: String? = nil
    private var searchResults: LocationSearchModel = []
    var numberOfSearchResults: Int {
        get {
            return searchResults.count
        }
    }
    
    private var currentConditions: CurrentConditionsModel = []

    
    func setCitiesView(citiesVC: CitiesViewController) {
        print("currentconditionsisepty = \(currentConditions.isEmpty)")
        configurateButton(button: citiesVC.searchButton, searchMode: citiesVC.searchMode)
        citiesVC.searchButtonAction = { self.searchButtonAction(citiesVC: citiesVC) }
        configurateButton(button: citiesVC.backButton, searchMode: citiesVC.searchMode)
        citiesVC.backButtonAction = { self.backButtonAction(citiesVC: citiesVC) }
        
        let searchMode = citiesVC.searchMode
        
        switch searchMode {
        case true:
            citiesVC.navigationItem.title = "Search"
            citiesVC.tableView.rowHeight = searchResultsRowHeight

        case false:
            citiesVC.navigationItem.title = "Cities"
            citiesVC.tableView.rowHeight = citiesRowHeight
            if currentConditions.isEmpty {
                currentConditions = Array(repeating: nil, count: numberOfCities)
            }

        }
        print("currentconditionsisepty = \(currentConditions.isEmpty)")
    }
    
    func configurateButton(button: UIButton, searchMode: Bool) {
        button.layer.cornerRadius = cornerRadius
        switch searchMode {
        case true:
            button.layer.opacity = 1
            button.isEnabled = searchMode
        case false:
            button.layer.opacity = 0.3
            button.isEnabled = searchMode
        }
    }
    
    func setCityCellData(cell: CityTableViewCell, for index: Int) {
        let cityId = cities[index].0
        let cityName = cities[index].1
        cityCellPresenter.setCellData(cell: cell, cityId: cityId, cityName: cityName, currentConditions: currentConditions[index]) { [weak self] (currentConditions) in
            self?.currentConditions[index] = currentConditions
        }
    }
    
    func setCitiesSearchData(cell: CitySearchTableViewCell, for index: Int) {
        let model = searchResults[index]
        citiesSearchCellPresenter.setCellData(cell: cell, model: model, addButtonAction: { self.addButtonAction(model: model) })
    }
    
    func addButtonAction(model: LocationSearchModelElement) {
        guard let cityName = model.localizedName else { return }
        guard let cityId = model.key else { return }
        let newCity = (cityId, cityName)
        print("Befor Add =", numberOfCities)
        cities.append(newCity)
        print("After Add =", numberOfCities)
        currentConditions.append(nil)
    }

    
//    private func downloadData() {
//        for item in cities {
//            let downloadGroup = DispatchGroup()
//            let cityId = item.0
//            downloadGroup.enter()
//            DataService.shared.getData(for: .currentConditions, cityId: cityId, parameters: nil) { [weak self] (model: CurrentConditionsModel?) in
//                guard let model = model else { return }
//                self?.currentConditions.append(contentsOf: model)
//                downloadGroup.leave()
//            }
//            downloadGroup.wait()
//        }
//    }
    
    func presentDetailsController(citiesVC: CitiesViewController, index: Int) {
        if citiesVC.searchMode == false {
            print("cell tapped")
            let storyboard = UIStoryboard(name: "Details", bundle: nil)
            print(storyboard)
            let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            print(detailsVC)
            detailsVC.detailsPresenter = detailsPresenter
            print("Set deetails", numberOfCities)
            detailsPresenter.setDetails(numberOfCities: numberOfCities)
            let cityId = cities[index].0
            let cityName = cities[index].1
            guard let currentConditions = currentConditions[index] else { return }
            let dateTime = currentConditions.localObservationDateTime
            let temperature = currentConditions.temperature?.metric?.value
            let weatherText = currentConditions.weatherText
            let weatherIcon = currentConditions.weatherIcon
            
            detailsPresenter.setDataInPresenter(index: index, cityId: cityId, cityName: cityName, dateTime: dateTime, temperature: temperature, weatherText: weatherText, weatherIcon: weatherIcon)
            citiesVC.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func setCitiesCells(tableView: UITableView, cellIdentifier: String, indexPath: IndexPath) -> (UITableViewCell) {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if let cell = cell as? CityTableViewCell {
            setCityCellData(cell: cell, for: indexPath.row)
        }
        if let cell = cell as? CitySearchTableViewCell {
            setCitiesSearchData(cell: cell, for: indexPath.row)
        }
        return cell
    }
    
    func getSearchResultFor(city: String?, completion: @escaping () -> ()) {
        guard let city = city else { return }
        if city != "" {
            citiesInteractor.getSearchResult(for: city, completion: { [weak self] (model: LocationSearchModel) in
                self?.searchResults = model
                completion()
            })
        }
    }
    
    func searchButtonAction(citiesVC: CitiesViewController) {
        print("SearchButton SearchMode before = \(citiesVC.searchMode)")
        citiesVC.searchBar.endEditing(true)
        self.searchText = citiesVC.searchBar.text
        citiesVC.searchBar.text = nil
        self.getSearchResultFor(city: self.searchText, completion: {
            DispatchQueue.main.async {
                citiesVC.viewDidLoad()
                citiesVC.tableView.reloadData()
            }
        })
        print("SearchButton SearchMode after = \(citiesVC.searchMode)")
    }
    
    func backButtonAction(citiesVC: CitiesViewController) {
        print("BackButton SearchMode before = \(citiesVC.searchMode)")
        citiesVC.searchBar.endEditing(true)
        citiesVC.searchBar.text = ""
        citiesVC.searchMode = false
        DispatchQueue.main.async {
            citiesVC.viewDidLoad()
            citiesVC.tableView.reloadData()
        }
        print("BackButton SearchMode before = \(citiesVC.searchMode)")
    }
}
