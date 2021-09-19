//
//  MainClassEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//
//

import Foundation
import CoreData


extension MainClassEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainClassEntity> {
        return NSFetchRequest<MainClassEntity>(entityName: "MainClassEntity")
    }

    @NSManaged public var temp: Double
    @NSManaged public var feelsLike: Double
    @NSManaged public var tempMin: Double
    @NSManaged public var tempMax: Double
    @NSManaged public var pressure: Int64
    @NSManaged public var seaLevel: Int64
    @NSManaged public var grndLevel: Int64
    @NSManaged public var humidity: Int64
    @NSManaged public var tempKf: Double

}

extension MainClassEntity : Identifiable {

}
