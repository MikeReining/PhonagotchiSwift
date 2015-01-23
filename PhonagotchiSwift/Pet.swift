//
//  Pet.swift
//  PhonagotchiSwift
//
//  Created by Michael Reining on 1/22/15.
//  Copyright (c) 2015 Mike Reining. All rights reserved.
//

import Foundation
import UIKit

class Pet {
    var mood: Mood = .Normal
    init() {
    }
    
    func petMonkey(velocity: CGFloat) {
        println("velocity: \(velocity)")
        if velocity > 400 {
            println("You are moving me too fast!")
            self.mood = .Sad
        }else {
            self.mood = .Happy
        }
//        if velocity == 0 {
//            self.mood = .Normal
//        }
//        if velocity > 10 && velocity < 100 {
//            self.mood = .Happy
//        }
    }
}


enum Mood {
    case Normal, Happy, Sad
}

