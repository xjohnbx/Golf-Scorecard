//
//  hole.swift
//  golfApp
//
//  Created by John on 12/12/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import Unbox

struct Course {
    
    
    var name: String
    var slope: Int
    var rating: Double
    var totalPar: Int
    var holes: [CourseHole]
    
}

extension Course: Unboxable {
    init(unboxer: Unboxer) throws {
        self.name = try unboxer.unbox(key: "name")
        self.slope = try unboxer.unbox(key: "slope")
        self.rating = try unboxer.unbox(key: "rating")
        self.totalPar = try unboxer.unbox(key: "totalPar")
        self.holes = try unboxer.unbox(key: "holes")
    }
}

struct CourseHole {
    
    var number: String
    var yards: Int
    var par: Int
    
}

extension CourseHole: Unboxable {
    init(unboxer: Unboxer) throws {
        self.number = try unboxer.unbox(key: "number")
        self.yards = try unboxer.unbox(key: "yards")
        self.par = try unboxer.unbox(key: "par")
    }
}
