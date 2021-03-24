//
//  WeekDayViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 24/03/2021.
//

import UIKit

struct WeekDayViewModel {
    
    let weatherData: ForecastWeatherConditions
    
    var tempreture: String {
        let min = String(format: "%.1f °F", weatherData.main.tempMin)
        let max = String(format: "%.1f °F", weatherData.main.tempMax)
        return "\(min) - \(max)"
    }
    var windSpeed: String {
        return String("\(weatherData.wind.speed) MPH")
    }
 
    
    var humidity: String {
        return String("\(weatherData.main.humidity) %")
    }
    
    var image: UIImage? {
        return UIImage.imageForIcon(with: "\(weatherData.weather[0].main)", and: "\(weatherData.weather[0].icon)")
    }
    
    var description: String {
        return weatherData.weather[0].weatherDescription
    }
}

extension WeekDayViewModel: WeekDayRepresentable {
    
}
