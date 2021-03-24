//
//  WeatherData.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import Foundation

protocol CurrentWeatherData {
    var current: CurrentWeatherConditions {get}
    var currentWind: CurrentWindConditions {get}
    var currentWeather: [WeatherConditions] {get}
}

protocol CurrentWeatherConditions { 
    var temp: Double {get}
    var feelsLike: Double {get}
    var tempMin: Double {get}
    var tempMax: Double {get}
    var humidity: Int {get}
}

protocol CurrentWindConditions {
    var speed: Double {get}
}

protocol WeatherConditions {
    var main: String {get}
    var weatherDescription: String {get}
    var icon: String {get}
}
