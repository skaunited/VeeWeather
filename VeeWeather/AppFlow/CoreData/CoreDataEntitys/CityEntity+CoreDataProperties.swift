//
//  CityEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 21/09/2021.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var population: Int64
    @NSManaged public var sunrise: Int64
    @NSManaged public var sunset: Int64
    @NSManaged public var timezone: Int64
    @NSManaged public var coord: CoordEntity?

}

extension CityEntity : Identifiable {

}
