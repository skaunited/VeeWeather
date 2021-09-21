//
//  WindEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 21/09/2021.
//
//

import Foundation
import CoreData


extension WindEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WindEntity> {
        return NSFetchRequest<WindEntity>(entityName: "WindEntity")
    }

    @NSManaged public var deg: Int64
    @NSManaged public var gust: Double
    @NSManaged public var speed: Double

}

extension WindEntity : Identifiable {

}
