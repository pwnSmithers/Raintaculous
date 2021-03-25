//
//  ForecastWeather.swift
//  Raintaculous
//
//  Created by Smithers on 24/03/2021.
//

import Foundation


// MARK: - ForecastWeather
struct ForecastWeather: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}


// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility
        case dtTxt = "dt_txt"
    }
}


// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}


enum Icon: String, Codable {
    case the01D = "01d"
    case the01N = "01n"
    case the03D = "03d"
    case the04D = "04d"
    case the04N = "04n"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case overcastClouds = "overcast clouds"
    case scatteredClouds = "scattered clouds"
}


extension ForecastWeather: ForecastWeatherData {
    var forecast: [ForecastWeatherConditions] {
        return list
    }
}

extension List: ForecastWeatherConditions {

}

