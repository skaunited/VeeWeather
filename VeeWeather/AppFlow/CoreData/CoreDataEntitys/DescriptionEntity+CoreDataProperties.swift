//
//  DescriptionEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//
//

import Foundation
import CoreData


extension DescriptionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DescriptionEntity> {
        return NSFetchRequest<DescriptionEntity>(entityName: "DescriptionEntity")
    }

    @NSManaged public var brokenClouds: String?
    @NSManaged public var clearSky: String?
    @NSManaged public var fewClouds: String?
    @NSManaged public var lightRain: String?
    @NSManaged public var overcastClouds: String?
    @NSManaged public var scatteredClouds: String?

}

extension DescriptionEntity : Identifiable {

}
