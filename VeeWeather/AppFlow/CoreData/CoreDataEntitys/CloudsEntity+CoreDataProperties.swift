//
//  CloudsEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//
//

import Foundation
import CoreData


extension CloudsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CloudsEntity> {
        return NSFetchRequest<CloudsEntity>(entityName: "CloudsEntity")
    }

    @NSManaged public var all: Int64

}

extension CloudsEntity : Identifiable {

}
