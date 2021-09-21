//
//  RainEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 21/09/2021.
//
//

import Foundation
import CoreData


extension RainEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RainEntity> {
        return NSFetchRequest<RainEntity>(entityName: "RainEntity")
    }

    @NSManaged public var the3H: Double

}

extension RainEntity : Identifiable {

}
