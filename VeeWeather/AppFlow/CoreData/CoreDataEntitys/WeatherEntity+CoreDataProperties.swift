//
//  WeatherEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 21/09/2021.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var desc: String?
    @NSManaged public var icon: String?
    @NSManaged public var id: Int64
    @NSManaged public var main: String?

}

extension WeatherEntity : Identifiable {

}
