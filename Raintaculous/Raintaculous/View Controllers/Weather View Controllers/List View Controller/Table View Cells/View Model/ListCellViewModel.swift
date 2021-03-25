//
//  ListCellViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import Foundation

class ListCellViewModel: NSObject {
    
    enum ReverseGeocodingError: Error {
        case noCityInformationAvailable
    }
    
    enum CurrentCityNameResult {
        case success(CurrentCityName)
        case failure(ReverseGeocodingError)
    }
    
    typealias FetchReverseGeocodingCompletion = (CurrentCityNameResult) -> Void
    
    //MARK:- properties
    var didFetchCurrentCityName: FetchReverseGeocodingCompletion?
    var location: LocationM
  
    
    init(location: LocationM) {
        self.location = location
        super.init()
        fetchCityName(for: location)
    }
    
    private func fetchCityName(for location: LocationM){
        let geoRequest = WeatherRequest(scheme: WeatherService.scheme, host: WeatherService.host, path: WeatherService.reverseGeocoding, location: location, appId: WeatherService.apiKey)
        
        URLSession.shared.dataTask(with: geoRequest.url) {[weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                
                print("Status Code: \(response.statusCode) with response \(response)")
            }
            
            DispatchQueue.main.async {
                if let error = error{
                    print("Unable to fetch Weather Data \(error)")
                    let result: CurrentCityNameResult = .failure(.noCityInformationAvailable)
                    self?.didFetchCurrentCityName?(result)
                } else if let data = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        let currentCityResponse = try decoder.decode([CityName].self, from: data)
                        let cityName =  currentCityResponse[0]
                        let result: CurrentCityNameResult = .success(cityName)
                        self?.didFetchCurrentCityName?(result)
                    } catch {
                        print("Unable to decode JSON \(error)")
                        let result: CurrentCityNameResult = .failure(.noCityInformationAvailable)
                        self?.didFetchCurrentCityName?(result)
                    }
                } else {
                    let result: CurrentCityNameResult = .failure(.noCityInformationAvailable)
                    self?.didFetchCurrentCityName?(result)
                }
            }
            
            
        }.resume()
    }
}
