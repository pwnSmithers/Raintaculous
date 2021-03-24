//
//  DayViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 24/03/2021.
//

import UIKit

struct DayViewModel {
    
    let currentWeatherData: CurrentWeatherConditions
    let currentWind: CurrentWindConditions
    let todaysWeather: [WeatherConditions]
    
    var temp: String {
        return String(format: "%.1f °F", currentWeatherData.temp)
    }
    
    
    var humidity: String {
        return String("\(currentWeatherData.humidity)%")
    }
    
    var wind: String {
        return String(format: "%.f MPH", currentWind.speed)
    }
    
    var description: String {
        return todaysWeather[0].weatherDescription
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: todaysWeather[0].main, and: todaysWeather[0].icon)
    }
    
}
