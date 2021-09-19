//
//  WeatherEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var icon: String?
    @NSManaged public var main: MainEnumEntity?
    @NSManaged public var weatherDescription: DescriptionEntity?

}

extension WeatherEntity : Identifiable {

}
