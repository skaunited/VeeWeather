//
//  MainEnumEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//
//

import Foundation
import CoreData


extension MainEnumEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainEnumEntity> {
        return NSFetchRequest<MainEnumEntity>(entityName: "MainEnumEntity")
    }

    @NSManaged public var clear: String?
    @NSManaged public var clouds: String?
    @NSManaged public var rain: String?

}

extension MainEnumEntity : Identifiable {

}
