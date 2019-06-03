//
//  Realm.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 06.03.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation
import RealmSwift

class Cities: Object {
    @objc dynamic var cityId: String = ""
    @objc dynamic var cityName: String = ""
}

