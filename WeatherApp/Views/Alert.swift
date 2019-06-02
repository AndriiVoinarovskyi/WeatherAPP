//
//  Alert.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 06.02.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    func showAlert(title: String?, message: String?, vcDelegate: VCAlertDelegate){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(alertAction)
        DispatchQueue.main.async {
            vcDelegate.showAlert(alert: alert)
        }
    }
}
