//
//  Round+CoreDataProperties.swift
//  golfApp
//
//  Created by John on 5/8/19.
//  Copyright © 2019 John. All rights reserved.
//
//

import Foundation
import CoreData

extension Round {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Round> {
        return NSFetchRequest<Round>(entityName: "Round")
    }

    @NSManaged public var courseName: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var scoreToPar: Int16
    @NSManaged public var totalFairways: Int16
    @NSManaged public var totalGIRs: Int16
    @NSManaged public var totalPutts: Int16
    @NSManaged public var totalScore: Int16
    @NSManaged public var holes: NSOrderedSet?

}

// MARK: Generated accessors for holes
extension Round {

    @objc(insertObject:inHolesAtIndex:)
    @NSManaged public func insertIntoHoles(_ value: Hole, at idx: Int)

    @objc(removeObjectFromHolesAtIndex:)
    @NSManaged public func removeFromHoles(at idx: Int)

    @objc(insertHoles:atIndexes:)
    @NSManaged public func insertIntoHoles(_ values: [Hole], at indexes: NSIndexSet)

    @objc(removeHolesAtIndexes:)
    @NSManaged public func removeFromHoles(at indexes: NSIndexSet)

    @objc(replaceObjectInHolesAtIndex:withObject:)
    @NSManaged public func replaceHoles(at idx: Int, with value: Hole)

    @objc(replaceHolesAtIndexes:withHoles:)
    @NSManaged public func replaceHoles(at indexes: NSIndexSet, with values: [Hole])

    @objc(addHolesObject:)
    @NSManaged public func addToHoles(_ value: Hole)

    @objc(removeHolesObject:)
    @NSManaged public func removeFromHoles(_ value: Hole)

    @objc(addHoles:)
    @NSManaged public func addToHoles(_ values: NSOrderedSet)

    @objc(removeHoles:)
    @NSManaged public func removeFromHoles(_ values: NSOrderedSet)
	
}
