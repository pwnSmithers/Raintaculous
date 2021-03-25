//
//  WeekDayRepresentable.swift
//  Raintaculous
//
//  Created by Smithers on 24/03/2021.
//

import UIKit

protocol WeekDayRepresentable {
    var tempreture: String {get}
    var windSpeed: String {get}
    var humidity: String {get}
    var image: UIImage? {get}
    var description: String {get}
}
