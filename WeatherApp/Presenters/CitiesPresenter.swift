//
//  CitiesPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CitiesPresenter {
    
    var citiesViewDelegate: CitiesViewDelegate!
    var citiesViewAlertDelegate: VCAlertDelegate!
    
    var citiesInteractor: CitiesInteractor {
        get {
            return CitiesInteractor(citiesViewAlertDelegate: citiesViewAlertDelegate)
        }
    }
    var  cityCellPresenter: CityCellPresenter {
        get {
            return CityCellPresenter(citiesViewAlertDelegate: citiesViewAlertDelegate)
        }
    }
    
    var citiesSearchCellPresenter = CitiesSearchCellPresenter()
    var detailsPresenter = DetailsPresenter()
    
    
    let realm = try! Realm()
    
    var cities: Results<Cities>!// = [//("324505", "Kyiv")
//                  ("326175", "Vinnytsia"),
//                  ("22889", "Sydney")
//                 ]
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
        if realm.objects(Cities.self).isEmpty {
            initialiseRealmDB()
        }
        cities = realm.objects(Cities.self)
        citiesViewDelegate = citiesVC
        citiesViewAlertDelegate = citiesVC
        citiesVC.searchActivityIndicator.stopAnimating()
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
    }
    
    func initialiseRealmDB() {
        let kyiv = Cities()
        kyiv.cityId = "324505"
        kyiv.cityName = "Kyiv"
        let vinnytsia = Cities()
        vinnytsia.cityId = "326175"
        vinnytsia.cityName = "Vinnytsia"
        try! realm.write {
            realm.add(kyiv)
            realm.add(vinnytsia)
        }
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
        let cityId = cities[index].cityId
        let cityName = cities[index].cityName
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
        let newCity = Cities()
        newCity.cityId = cityId
        newCity.cityName = cityName
        try! realm.write {
            realm.add(newCity)
        }
        currentConditions.append(nil)
        citiesViewDelegate.reloadView()
    }
    
    func presentDetailsController(citiesVC: CitiesViewController, index: Int) {
        if citiesVC.searchMode == false {
            let storyboard = UIStoryboard(name: "Details", bundle: nil)
            let detailsVC = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            detailsVC.detailsPresenter = detailsPresenter
            detailsPresenter.setDetails(numberOfCities: numberOfCities)
            let cityId = cities[index].cityId
            let cityName = cities[index].cityName
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
        citiesVC.searchBar.endEditing(true)
        self.searchText = citiesVC.searchBar.text
        citiesVC.searchBar.text = nil
        citiesVC.searchActivityIndicator.startAnimating()
        self.getSearchResultFor(city: self.searchText, completion: {
            DispatchQueue.main.async {
                citiesVC.tableView.reloadData()
                citiesVC.searchActivityIndicator.stopAnimating()
                citiesVC.viewDidLoad()
            }
        })
    }
    
    func backButtonAction(citiesVC: CitiesViewController) {
        citiesViewDelegate.reloadView()
    }
    
    func reloadViewController(viewController: CitiesViewController) {
        viewController.searchBar.endEditing(true)
        viewController.searchBar.text = ""
        viewController.searchMode = false
        viewController.tableView.reloadData()
        viewController.viewDidLoad()
    }
}
