//
//  CitySearchTableViewCell.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.30.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import UIKit

class CitySearchTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var administrativeAreaLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var viewContainer: UIView!
    
    var addButtonAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        addButtonAction?()
    }
}
