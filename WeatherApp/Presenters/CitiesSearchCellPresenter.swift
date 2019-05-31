//
//  CitiesSearchPresenter.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.30.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class CitiesSearchCellPresenter {
    
    func setCellData(cell: CitySearchTableViewCell, model: LocationSearchModelElement) {
        cell.selectionStyle = .none
        cell.cityNameLabel.text = model.localizedName
        cell.administrativeAreaLabel.text = model.administrativeArea?.localizedName
        cell.countryLabel.text = model.country?.localizedName
        cell.viewContainer.layer.backgroundColor = dayBackgroundColor
        cell.viewContainer.layer.cornerRadius = cornerRadius
        cell.addButton.layer.cornerRadius = cornerRadius
    }
}
