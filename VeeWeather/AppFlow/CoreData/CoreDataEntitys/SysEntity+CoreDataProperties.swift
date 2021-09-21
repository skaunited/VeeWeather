//
//  SysEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 21/09/2021.
//
//

import Foundation
import CoreData


extension SysEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SysEntity> {
        return NSFetchRequest<SysEntity>(entityName: "SysEntity")
    }

    @NSManaged public var pod: PodEntity?

}

extension SysEntity : Identifiable {

}
