//
//  Configuration.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import Foundation
import CoreLocation

enum Defaults {
    static let location = CLLocation(latitude: 37.335114, longitude: -122.008928)
}

enum WeatherService {
    static let apiKey = "ad68f7b77f722b1585a302ecfd316cf3"
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5/forecast"
  
}
