//
//  Trip+CoreDataProperties.swift
//  Travelogue
//
//  Created by Kartik Sharma on 12/02/19.
//  Copyright © 2019 Kartik Sharma. All rights reserved.
//
//

import Foundation
import CoreData


extension Trip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
        return NSFetchRequest<Trip>(entityName: "Trip")
    }

    @NSManaged public var title: String?
    @NSManaged public var rawEntry: NSOrderedSet?

}

extension Trip {

    @objc(insertObject:inRawEntryAtIndex:)
    @NSManaged public func insertIntoRawEntry(_ value: Entry, at idx: Int)

    @objc(removeObjectFromRawEntryAtIndex:)
    @NSManaged public func removeFromRawEntry(at idx: Int)

    @objc(insertRawEntry:atIndexes:)
    @NSManaged public func insertIntoRawEntry(_ values: [Entry], at indexes: NSIndexSet)

    @objc(removeRawEntryAtIndexes:)
    @NSManaged public func removeFromRawEntry(at indexes: NSIndexSet)

    @objc(replaceObjectInRawEntryAtIndex:withObject:)
    @NSManaged public func replaceRawEntry(at idx: Int, with value: Entry)

    @objc(replaceRawEntryAtIndexes:withRawEntry:)
    @NSManaged public func replaceRawEntry(at indexes: NSIndexSet, with values: [Entry])

    @objc(addRawEntryObject:)
    @NSManaged public func addToRawEntry(_ value: Entry)

    @objc(removeRawEntryObject:)
    @NSManaged public func removeFromRawEntry(_ value: Entry)

    @objc(addRawEntry:)
    @NSManaged public func addToRawEntry(_ values: NSOrderedSet)

    @objc(removeRawEntry:)
    @NSManaged public func removeFromRawEntry(_ values: NSOrderedSet)

}
