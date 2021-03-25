//
//  MainViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import Foundation

class MainViewModel: NSObject {
    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    enum CurrentWeatherDataResult {
        case success(CurrentWeatherData)
        case failure(WeatherDataError)
    }
    
    enum ForecastWeatherDataResult {
        case success(ForecastWeatherData)
        case failure(WeatherDataError)
    }
    
    
    typealias FetchCurrentWeatherCompletion = (CurrentWeatherDataResult) -> Void
    typealias FetchForecastWeatherCompletion = (ForecastWeatherDataResult) -> Void
    
    var didFetchCurrentWeatherData: FetchCurrentWeatherCompletion?
    var didFetchForecastWeatherData: FetchForecastWeatherCompletion?
    

    
    private let locationService: LocationService
    
    //MARK:- Initializers
    init(locationService: LocationService) {
        self.locationService = locationService
        super.init()
        fetchCurrentWeatherData(for: Defaults.location)
        fetchForecastWeatherData(for: Defaults.location)
        fetchLocation()
    }
    
    //MARK:- private methods
    
    private func fetchLocation() {
        locationService.fetchLocation {[weak self] (result) in
            switch result {
            case .success(let location):
                self?.fetchCurrentWeatherData(for: location)
                self?.fetchForecastWeatherData(for: location)
            case .failure(let error):
                let result: CurrentWeatherDataResult = .failure(.notAuthorizedToRequestLocation)
                
                print("Unable to fetch location \(error)")
                self?.didFetchCurrentWeatherData?(result)
            }
        }
    }
    
    private func fetchCurrentWeatherData(for location: LocationM) {
        let weatherRequest = WeatherRequest(scheme: WeatherService.scheme, host: WeatherService.host, path: WeatherService.currentWeatherPath, location: location, appId: WeatherService.apiKey)

        URLSession.shared.dataTask(with: weatherRequest.url) {[weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                
                print("Status Code: \(response.statusCode) with response \(response)")
            }
            DispatchQueue.main.async {
                if let error = error{
                    print("Unable to fetch Weather Data \(error)")
                    let result: CurrentWeatherDataResult = .failure(.noWeatherDataAvailable)
                    self?.didFetchCurrentWeatherData?(result)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    if #available(iOS 10.0, *) {
                        decoder.dateDecodingStrategy = .iso8601
                    } else {
                        // Fallback on earlier versions
                        decoder.dateDecodingStrategy = .secondsSince1970
                    }
                    do {
                        let currentWeatherResponnse = try decoder.decode(CurrentWeather.self, from: data)
                        let result: CurrentWeatherDataResult = .success(currentWeatherResponnse)
                        self?.didFetchCurrentWeatherData?(result)
                    } catch {
                        print("Unable to decode JSON \(error)")
                        let result: CurrentWeatherDataResult = .failure(.noWeatherDataAvailable)
                        self?.didFetchCurrentWeatherData?(result)
                    }
                } else {
                    let result: CurrentWeatherDataResult = .failure(.noWeatherDataAvailable)
                    self?.didFetchCurrentWeatherData?(result)
                }
            }

            
        }.resume()
    }
    
    private func fetchForecastWeatherData(for location: LocationM) {
        let weatherRequest = WeatherRequest(scheme: WeatherService.scheme, host: WeatherService.host, path: WeatherService.forecastWeatherPath, location: location, appId: WeatherService.apiKey)
        URLSession.shared.dataTask(with: weatherRequest.url) {[weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                
                print("Status Code: \(response.statusCode) with response \(response)")
            }
            DispatchQueue.main.async {
                if let error = error{
                    print("Unable to fetch Weather Data \(error)")
                    let result: ForecastWeatherDataResult = .failure(.noWeatherDataAvailable)
                    self?.didFetchForecastWeatherData?(result)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    do {
                        let forecastWeatherResponnse = try decoder.decode(ForecastWeather.self, from: data)
                        let result: ForecastWeatherDataResult = .success(forecastWeatherResponnse)
                        self?.didFetchForecastWeatherData?(result)
                    } catch {
                        print("Unable to decode JSON \(error)")
                        let result: ForecastWeatherDataResult = .failure(.noWeatherDataAvailable)
                        self?.didFetchForecastWeatherData?(result)
                    }
                } else {
                    let result: ForecastWeatherDataResult = .failure(.noWeatherDataAvailable)
                    self?.didFetchForecastWeatherData?(result)
                }
            }
        }.resume()
    }
    
}

