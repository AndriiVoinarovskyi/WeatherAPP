//
//  CitiesViewController.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.22.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchActivityIndicator: UIActivityIndicatorView!
    
    var searchButtonAction: (() -> ())?
    var backButtonAction: (() -> ())?
    
    let citiesPresenter = CitiesPresenter()
    
    var searchMode: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesPresenter.setCitiesView(citiesVC: self)
        
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
    @IBAction func searchButtonTapped(_ sender: Any) {
        print("SearchButton tapped")
        searchButtonAction?()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        print("Back Button tapped")
        backButtonAction?()
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchMode {
        case false: return citiesPresenter.numberOfCities
        case true: return citiesPresenter.numberOfSearchResults
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier = ""
        switch searchMode {
        case false:
            cellIdentifier = "CityTableViewCell"
        case true:
            cellIdentifier = "CitySearchTableViewCell"
        }
        return citiesPresenter.setCitiesCells(tableView: tableView, cellIdentifier: cellIdentifier, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        citiesPresenter.presentDetailsController(citiesVC: self, index: indexPath.row)
    }
    
}

extension CitiesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchMode = true
        DispatchQueue.main.async {
//            self.tableView.isHidden = true
            self.viewDidLoad()
        }
    }
}

extension CitiesViewController: CitiesViewDelegate {
    
    func reloadView() {
        searchBar.endEditing(true)
        searchBar.text = ""
        searchMode = false
        tableView.reloadData()
        self.viewDidLoad()
    }
}

extension CitiesViewController: VCAlertDelegate {
    
    func showAlert(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
}
