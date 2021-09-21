//
//  PodEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 21/09/2021.
//
//

import Foundation
import CoreData


extension PodEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PodEntity> {
        return NSFetchRequest<PodEntity>(entityName: "PodEntity")
    }

    @NSManaged public var d: String?
    @NSManaged public var n: String?

}

extension PodEntity : Identifiable {

}
