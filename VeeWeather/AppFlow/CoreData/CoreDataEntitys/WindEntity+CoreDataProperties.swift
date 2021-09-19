//
//  WindEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//
//

import Foundation
import CoreData


extension WindEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WindEntity> {
        return NSFetchRequest<WindEntity>(entityName: "WindEntity")
    }

    @NSManaged public var speed: Double
    @NSManaged public var deg: Int64
    @NSManaged public var gust: Double

}

extension WindEntity : Identifiable {

}
