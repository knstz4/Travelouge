//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Brock Gibson on 4/19/19.
//  Copyright © 2019 Brock Gibson. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var title: String?
    @NSManaged public var rawTrip: NSSet?

}

// MARK: Generated accessors for rawTrip
extension Entry {

    @objc(addRawTripObject:)
    @NSManaged public func addToRawTrip(_ value: Trip)

    @objc(removeRawTripObject:)
    @NSManaged public func removeFromRawTrip(_ value: Trip)

    @objc(addRawTrip:)
    @NSManaged public func addToRawTrip(_ values: NSSet)

    @objc(removeRawTrip:)
    @NSManaged public func removeFromRawTrip(_ values: NSSet)

}
