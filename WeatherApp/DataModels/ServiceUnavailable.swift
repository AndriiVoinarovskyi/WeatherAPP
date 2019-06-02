//
//  ServiceUnavailable.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 06.02.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

struct ServiceUnavailable: Codable {
    let code, message, reference: String?
    
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case message = "Message"
        case reference = "Reference"
    }
}
