//
//  MapViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import Foundation

class MapViewModel: NSObject {

    
    enum WeatherDataError: Error {
        case notAuthorizedToRequestLocation
        case failedToRequestLocation
        case noWeatherDataAvailable
    }
    
    enum CurrentLocationDataResult {
        case success(LocationM)
        case failure(WeatherDataError)
    }
    
    typealias FetchCurrentLocationCompletion = (CurrentLocationDataResult) -> Void
    
    var didFetchCurrentLocationData: FetchCurrentLocationCompletion?
    
    private var locationService: LocationService?
    
    
    override init() {
        super.init()
        fetchLocation()
    }
    
    private func fetchLocation() {
        locationService = LocationManager()
        locationService?.fetchLocation {[weak self] (result) in
            switch result {
            case .success(let location):
                let locationResult: CurrentLocationDataResult = .success(location)
                self?.didFetchCurrentLocationData?(locationResult)
            case .failure(_):
                let errorResult: CurrentLocationDataResult = .failure(.notAuthorizedToRequestLocation)
                self?.didFetchCurrentLocationData?(errorResult)
            }
        }
    }
}
