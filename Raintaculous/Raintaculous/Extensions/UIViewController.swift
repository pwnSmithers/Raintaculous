//
//  UIViewController.swift
//  Raintaculous
//
//  Created by Smithers on 23/03/2021.
//

import UIKit

extension UIViewController {
    //MARK:- Static properties
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
