//
//  RootViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import Foundation

class RootViewModel {
    typealias DidFetchWeatherCompletion = (Data?, Error?) -> Void
    var didFetchWeatherData: DidFetchWeatherCompletion?
    
    //MARK:- Initializers
    init() {
        fetchWeatherData()
    }
    
    //MARK:- private methods
    private func fetchWeatherData() {
        let weatherRequest = WeatherRequest(scheme: WeatherService.scheme, host: WeatherService.host, path: WeatherService.path, location: Defaults.location, appId: WeatherService.apiKey)

        URLSession.shared.dataTask(with: weatherRequest.url) {[weak self] (data, response, error) in
            if let error = error{
                self?.didFetchWeatherData?(nil, error)
            } else if let data = data {
                self?.didFetchWeatherData?(data, nil)
            } else {
                self?.didFetchWeatherData?(nil, nil)
            }
            
        }.resume()
    }
    
}
