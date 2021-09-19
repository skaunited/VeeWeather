//
//  CoordEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//
//

import Foundation
import CoreData


extension CoordEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoordEntity> {
        return NSFetchRequest<CoordEntity>(entityName: "CoordEntity")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double

}

extension CoordEntity : Identifiable {

}
