//
//  Location+CoreDataProperties.swift
//  Raintaculous
//
//  Created by Smithers on 25/03/2021.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?

}
