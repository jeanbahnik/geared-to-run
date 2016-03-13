//
//  GearConstraint+CoreDataProperties.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/13/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension GearConstraint {

    @NSManaged var gearItem: Int16
    @NSManaged var maxRain: Float
    @NSManaged var maxTemp: Float
    @NSManaged var maxWind: Int16
    @NSManaged var minRain: Float
    @NSManaged var minTemp: Float
    @NSManaged var minWind: Int16
    @NSManaged var item: NSSet?

}
