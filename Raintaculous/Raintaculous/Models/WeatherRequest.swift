//
//  WeatherRequest.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import Foundation
import CoreLocation

struct WeatherRequest {
    let scheme: String
    let host: String
    let path: String
    let location: CLLocation
    
    private var latitude: Double {
        return location.coordinate.latitude
    }
    private var longitude: Double {
        return location.coordinate.longitude
    }
    
    let appId: String
    
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: String(latitude)),
            URLQueryItem(name: "lon", value: String(longitude)),
            URLQueryItem(name: "appid", value: appId)
        ]
        
        return components.url!
    }
}
