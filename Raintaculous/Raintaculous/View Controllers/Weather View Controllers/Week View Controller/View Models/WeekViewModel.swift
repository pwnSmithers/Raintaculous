//
//  WeekViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 24/03/2021.
//

import Foundation

struct WeekViewModel {
    let weatherData: [ForecastWeatherConditions]
    
    var numberOfDays: Int{
        return weatherData.count
    }
    
    func viewModel(for index: Int) -> WeekDayViewModel {
        return WeekDayViewModel(weatherData: weatherData[index])
    }
}
