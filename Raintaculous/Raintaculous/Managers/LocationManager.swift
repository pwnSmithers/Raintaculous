//
//  LocationManager.swift
//  Raintaculous
//
//  Created by Smithers on 24/03/2021.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, LocationService {
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private var didFetchLocation: FetchLocationCompletion?
    
    func fetchLocation(completion: @escaping FetchLocationCompletion) {
        didFetchLocation = completion
        locationManager.requestLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        } else {
            let result: LocationServiceResult = .failure(.notAuthorizedToRequestLocation)
            didFetchLocation?(result)
            didFetchLocation = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        let result: LocationServiceResult = .success(Location(location: location))
        didFetchLocation?(result)
        didFetchLocation = nil
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to fetch the location")
    }
}

fileprivate extension Location {
    init(location: CLLocation) {
        latitude = location.coordinate.latitude
        longitude = location.coordinate.longitude
    }
}
