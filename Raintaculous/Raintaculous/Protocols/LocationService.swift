//
//  LocationService.swift
//  Raintaculous
//
//  Created by Smithers on 31/03/2021.
//

import Foundation

enum LocationServiceError {
    case notAuthorizedToRequestLocation
}

enum LocationServiceResult {
    case success(LocationM)
    case failure(LocationServiceError)
}
protocol LocationService {
    typealias FetchLocationCompletion = (LocationServiceResult) -> Void
    func fetchLocation(completion: @escaping FetchLocationCompletion)
}
