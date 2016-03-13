//
//  ItemConstraint.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/12/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import CoreData

class GearConstraints: NSManagedObject {
    @NSManaged var gearItem: GearItem
    @NSManaged var minTemp: Int
    @NSManaged var maxTemp: Int
    @NSManaged var minWind: Int
    @NSManaged var maxWind: Int
    @NSManaged var minRain: Float
    @NSManaged var maxRain: Float
}
