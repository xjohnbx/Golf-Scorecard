//
//  Round.swift
//  golfApp
//
//  Created by John on 12/14/18.
//  Copyright © 2018 John. All rights reserved.
//

import Foundation

struct Round {
    
    var holes: [Hole]
    var totalFairways = 0
    var totalGIRs = 0
    var totalPutts = 0
    var totalScore = 0
    var userScoreToPar = 0
    
}

struct Hole {
    var holePlayed = false
    var holeFairway = false
    var holeGIR = false
    var holePutts = 0
    var holeScore = 0
}
