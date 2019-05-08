//
//  Hole+CoreDataClass.swift
//  golfApp
//
//  Created by John on 5/8/19.
//  Copyright © 2019 John. All rights reserved.
//
//

import UIKit
import Foundation
import CoreData

@objc(Hole)
public class Hole: NSManagedObject {
    
    convenience init(holeNumber: Int16, putts: Int16, strokes: Int16, fairwayHit: Bool, girHit: Bool) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let context = appDelegate?.persistentContainer.viewContext
        

        
        self.init(entity: Hole.entity(), insertInto: context)
        
        self.holeNumber = holeNumber
        self.putts = putts
        self.strokes = strokes
        self.fairwayHit = fairwayHit
        self.girHit = girHit
    }
}
