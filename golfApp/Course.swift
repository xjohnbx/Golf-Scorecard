//
//  hole.swift
//  golfApp
//
//  Created by John on 12/12/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation
import Codextended

struct Course: Codable {
    var name: String
    var slope: Int
    var rating: Double
    var totalPar: Int
    var holes: [CourseHole]
	
	init(from decoder: Decoder) throws {
		name = try decoder.decode("name")
		slope = try decoder.decode("slope")
		rating = try decoder.decode("rating")
		totalPar = try decoder.decode("totalPar")
		holes = try decoder.decode("holes")
	}
}

struct CourseHole: Codable {
    var number: String
    var yards: Int
    var par: Int
	
	init(from decoder: Decoder) throws {
		number = try decoder.decode("number")
		yards = try decoder.decode("yards")
		par = try decoder.decode("par")
	}
}
