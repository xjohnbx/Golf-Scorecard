//
//  Round+CoreDataClass.swift
//  golfApp
//
//  Created by John on 5/8/19.
//  Copyright © 2019 John. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Round)
public class Round: NSManagedObject {
   
    var newDate: Date? {
        get {
          return date as Date?
        }
        set  {
            date = newValue as NSDate?
        }
    }
    var holeArray: [Hole]? {
        return self.holes?.array as? [Hole]
    }
    
    convenience init(courseName: String, date: Date, scoreToPar: Int16, totalFairways: Int16, totalGIRs: Int16, totalPutts: Int16, totalScore: Int16) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        let context = appDelegate?.persistentContainer.viewContext
        
        self.init(entity: Round.entity(), insertInto: context)
        
        self.courseName = courseName
        self.newDate = date
        self.scoreToPar = scoreToPar
        self.totalFairways = totalFairways
        self.totalGIRs = totalGIRs
        self.totalPutts = totalPutts
        self.totalScore = totalScore
    }
}
