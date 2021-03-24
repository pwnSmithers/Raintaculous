//
//  WeatherData.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import Foundation

protocol CurrentWeatherData {
    var current: CurrentWeatherConditions {get}
}

protocol CurrentWeatherConditions { 
    var temp: Double {get}
    var feelsLike: Double {get}
    var tempMin: Double {get}
    var tempMax: Double {get}
    var humidity: Int {get}
}
