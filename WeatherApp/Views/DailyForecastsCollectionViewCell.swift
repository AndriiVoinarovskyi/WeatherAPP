//
//  DailyForecastsCollectionViewCell.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.27.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import UIKit

class DailyForecastsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var dayImageView: UIImageView!
    @IBOutlet weak var nightImageView: UIImageView!
    
}
