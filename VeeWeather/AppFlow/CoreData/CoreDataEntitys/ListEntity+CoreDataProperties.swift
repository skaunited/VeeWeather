//
//  ListEntity+CoreDataProperties.swift
//  VeeWeather
//
//  Created by Skander Bahri on 19/09/2021.
//
//

import Foundation
import CoreData


extension ListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListEntity> {
        return NSFetchRequest<ListEntity>(entityName: "ListEntity")
    }

    @NSManaged public var dt: Int64
    @NSManaged public var visibility: Int64
    @NSManaged public var pop: Double
    @NSManaged public var dtTxt: String?
    @NSManaged public var weather: [WeatherEntity]?
    @NSManaged public var main: MainClassEntity?
    @NSManaged public var clouds: CloudsEntity?
    @NSManaged public var wind: WindEntity?
    @NSManaged public var sys: SysEntity?
    @NSManaged public var rain: RainEntity?

}

extension ListEntity : Identifiable {

}
