//
//  Hole+CoreDataProperties.swift
//  golfApp
//
//  Created by John on 5/8/19.
//  Copyright © 2019 John. All rights reserved.
//
//

import Foundation
import CoreData


extension Hole {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hole> {
        return NSFetchRequest<Hole>(entityName: "Hole")
    }

    @NSManaged public var fairwayHit: Bool
    @NSManaged public var girHit: Bool
    @NSManaged public var holeNumber: Int16
    @NSManaged public var putts: Int16
    @NSManaged public var strokes: Int16
    @NSManaged public var round: Round?

}
