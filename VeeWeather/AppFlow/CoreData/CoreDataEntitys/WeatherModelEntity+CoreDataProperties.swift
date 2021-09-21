//
//  WeatherModelEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 21/09/2021.
//
//

import Foundation
import CoreData


extension WeatherModelEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherModelEntity> {
        return NSFetchRequest<WeatherModelEntity>(entityName: "WeatherModelEntity")
    }

    @NSManaged public var cnt: Int64
    @NSManaged public var cod: String?
    @NSManaged public var list: [ListEntity]?
    @NSManaged public var message: Int64
    @NSManaged public var city: CityEntity?

}

extension WeatherModelEntity : Identifiable {

}
