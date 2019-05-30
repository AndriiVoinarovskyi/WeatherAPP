//
//  URLMaker.swift
//  WeatherApp
//
//  Created by Macbook Pro 13 on 05.23.19.
//  Copyright © 2019 My Company. All rights reserved.
//

import Foundation

class URLMaker {

    private let apikey = "FVpXsxiq2h9sj90lRzPqi082dqVs5TJK"
    
    static let shared = URLMaker()
    
    func getURL(baseLink: String, cityId: String?, parameters: Parameters) -> URL? {
        let params = parametersAsString(parameters: parameters)
        let link = baseLink + (cityId ?? "") + "?apikey=" + apikey + params
        print("\(link)")
        return URL(string: link)
    }
    
    private func parametersAsString(parameters: Parameters) -> String {
        var params = ""
        guard let parameters = parameters else { return "" }
        for item in parameters {
            params = params + "&" + item.key + "=" + item.value
        }
        return params
    }
}
