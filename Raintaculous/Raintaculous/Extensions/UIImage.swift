//
//  UIImage.swift
//  Raintaculous
//
//  Created by Smithers on 24/03/2021.
//

import UIKit

extension UIImage {
    class func imageForIcon(with name: String, and icon: String) -> UIImage? {
        switch name {
        case "Clouds",
            "Clear",
            "Snow",
            "Rain",
            "Drizzle",
            "Thunderstorm":
            return UIImage(named: icon)
        default:
            return UIImage(named: "01d")
        }
    }
}
