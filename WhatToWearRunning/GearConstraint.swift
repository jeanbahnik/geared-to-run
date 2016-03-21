//
//  GearConstraint.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/13/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import CoreData

class GearConstraint: NSManagedObject {

    class func saveConstraint(gearItem: GearItem, minTemp: Float, maxTemp: Float, minWind: Int16, maxWind: Int16, minRain: Float, maxRain: Float) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("GearConstraint", inManagedObjectContext:managedContext)
        let gearConstraint = GearConstraint(entity: entity!, insertIntoManagedObjectContext: managedContext)

        gearConstraint.minTemp = minTemp
        gearConstraint.maxTemp = maxTemp
        gearConstraint.minWind = minWind
        gearConstraint.maxWind = maxWind
        gearConstraint.minRain = minRain
        gearConstraint.maxRain = maxRain
        gearConstraint.item = gearItem

        do {
            try gearConstraint.managedObjectContext?.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
