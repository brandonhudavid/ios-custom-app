//
//  Habit.swift
//  Habbit
//
//  Created by Brandon David on 4/18/18.
//  Copyright © 2018 IrisBrandon. All rights reserved.
//

import Foundation
import UIKit

class Habit {
    let habitName: String
    let habitIconPath: String
    let habitDays: [String:Bool]
    let performedToday: Bool
    
    init(habitName: String, habitIconPath: String, habitDays: [String:Bool], performedToday: Bool) {
        self.habitName = habitName
        self.habitIconPath = habitIconPath
        self.habitDays = habitDays
        self.performedToday = performedToday
    }
}
