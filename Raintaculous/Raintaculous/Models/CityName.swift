//
//  CityName.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import Foundation

// MARK: - CityNameElement

struct CityName: Codable {
    let name: String
    let lat, lon: Double
    let country, state: String

    enum CodingKeys: String, CodingKey {
        case name
        case lat, lon, country, state
    }
}

extension CityName: CurrentCityName{
    
}
