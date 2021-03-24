//
//  RootViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import Foundation

class RootViewModel {
    
    enum WeatherDataError: Error {
        case noWeatherDataAvailable
    }
    
    typealias DidFetchCurrentWeatherCompletion = (CurrentWeatherData?, WeatherDataError?) -> Void
    typealias DidFetchForecastWeatherCompletion = (ForecastWeatherData?, WeatherDataError?) -> Void
    var didFetchCurrentWeatherData: DidFetchCurrentWeatherCompletion?
    var didFetchForecastWeatherData: DidFetchForecastWeatherCompletion?
    
    //MARK:- Initializers
    init() {
        fetchCurrentWeatherData()
        fetchForecastWeatherData()
    }
    
    //MARK:- private methods
    private func fetchCurrentWeatherData() {
        let weatherRequest = WeatherRequest(scheme: WeatherService.scheme, host: WeatherService.host, path: WeatherService.currentWeatherPath, location: Defaults.location, appId: WeatherService.apiKey)

        URLSession.shared.dataTask(with: weatherRequest.url) {[weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                
                print("Status Code: \(response.statusCode) with response \(response)")
            }
            DispatchQueue.main.async {
                if let error = error{
                    print("Unable to fetch Weather Data \(error)")
                    self?.didFetchCurrentWeatherData?(nil, .noWeatherDataAvailable)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let currentWeatherResponnse = try decoder.decode(CurrentWeather.self, from: data)
                        self?.didFetchCurrentWeatherData?(currentWeatherResponnse, nil)
                    } catch {
                        print("Unable to decode JSON \(error)")
                        self?.didFetchCurrentWeatherData?(nil, .noWeatherDataAvailable)
                    }
                } else {
                    self?.didFetchCurrentWeatherData?(nil, .noWeatherDataAvailable)
                }
            }

            
        }.resume()
    }
    
    private func fetchForecastWeatherData() {
        let weatherRequest = WeatherRequest(scheme: WeatherService.scheme, host: WeatherService.host, path: WeatherService.forecastWeatherPath, location: Defaults.location, appId: WeatherService.apiKey)
        URLSession.shared.dataTask(with: weatherRequest.url) {[weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                
                print("Status Code: \(response.statusCode) with response \(response)")
            }
            DispatchQueue.main.async {
                if let error = error{
                    print("Unable to fetch Weather Data \(error)")
                    self?.didFetchForecastWeatherData?(nil, .noWeatherDataAvailable)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let forecastWeatherResponnse = try decoder.decode(ForecastWeather.self, from: data)
                        self?.didFetchForecastWeatherData?(forecastWeatherResponnse, nil)
                    } catch {
                        print("Unable to decode JSON \(error)")
                        self?.didFetchCurrentWeatherData?(nil, .noWeatherDataAvailable)
                    }
                } else {
                    self?.didFetchCurrentWeatherData?(nil, .noWeatherDataAvailable)
                }
            }
        }.resume()
    }
    
}
