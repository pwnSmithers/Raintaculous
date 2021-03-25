//
//  ForeCastWeatherData.swift
//  Raintaculous
//
//  Created by Smithers on 24/03/2021.
//

import Foundation

protocol ForecastWeatherData {
    var forecast: [ForecastWeatherConditions] {get}
}

protocol ForecastWeatherConditions {
    var main: MainClass {get}
    var weather: [Weather] {get}
    var wind: Wind {get}
}
