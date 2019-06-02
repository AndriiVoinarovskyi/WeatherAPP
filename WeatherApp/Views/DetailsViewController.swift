//
//  DetailsViewController.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.24.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherTextLabel: UILabel!
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    @IBOutlet weak var hourlyForecastsCollectionView: UICollectionView!
    @IBOutlet weak var dailyForecastsCollectionView: UICollectionView!
    
    @IBOutlet weak var hourlyForecastsActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dailyForecastsActivityIndicator: UIActivityIndicatorView!
    
    var detailsPresenter = DetailsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailsPresenter.setDataInVC(detailsVC: self)

        // Do any additional setup after loading the view.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case hourlyForecastsCollectionView:
            return detailsPresenter.numberOfHourlyForecasts
        default:
            return detailsPresenter.numberOfDailyForecasts
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier: String
        switch collectionView {
        case hourlyForecastsCollectionView :
            identifier = "hourlyForecastsCollectionViewCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! HourlyForecastsCollectionViewCell
            let cellHeight = hourlyForecastsCollectionView.bounds.size.height
            detailsPresenter.setHourlyForecastsCollectionViewCell(cell: cell, index: indexPath.row, cellHeight: cellHeight)
            return cell
        default:
            identifier = "dailyForecastsCollectionViewCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! DailyForecastsCollectionViewCell
            let cellHeight = dailyForecastsCollectionView.bounds.size.height
            detailsPresenter.setDailyForecastsCollectionViewCell(cell: cell, index: indexPath.row, cellHeight: cellHeight)
            return cell
        }
    }
}

extension DetailsViewController: VCAlertDelegate {
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
}
