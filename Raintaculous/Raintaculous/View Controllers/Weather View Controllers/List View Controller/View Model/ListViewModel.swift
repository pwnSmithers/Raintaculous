//
//  ListViewModel.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//

import UIKit

struct ListViewModel {
    
    
    
}

extension ListViewModel: LocationnRepresentable{
    var locationName: String {
        return "Kampala"
    }
    
    var locationLatitude: String {
        return String(Defaults.location.latitude)
    }
    
    var locationLongitude: String {
        return String(Defaults.location.longitude)
    }
    
    
}
