//
//  GearConstraint.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/13/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import CoreData
import Ensembles

class GearConstraint: NSManagedObject {

    class func saveConstraint(gearItem: GearItem, minTemp: Int16, maxTemp: Int16, minWind: Int16, maxWind: Int16, minRain: Float, maxRain: Float) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("GearConstraint", inManagedObjectContext:managedContext)
        let gearConstraint = GearConstraint(entity: entity!, insertIntoManagedObjectContext: managedContext)

        gearConstraint.minTemperature = minTemp
        gearConstraint.maxTemperature = maxTemp
        gearConstraint.minWindSpeed = minWind
        gearConstraint.maxWindSpeed = maxWind
        gearConstraint.minPrecipProbability = minRain
        gearConstraint.maxPrecipProbability = maxRain
        gearConstraint.item = gearItem

        do {
            try gearConstraint.managedObjectContext?.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func updateConstraint(minTemp: Int16, maxTemp: Int16, minWind: Int16, maxWind: Int16, minRain: Float, maxRain: Float) {
        
        self.minTemperature = minTemp
        self.maxTemperature = maxTemp
        self.minWindSpeed = minWind
        self.maxWindSpeed = maxWind
        self.minPrecipProbability = minRain
        self.maxPrecipProbability = maxRain
        self.item?.seedData = false
        
        do {
            try self.managedObjectContext?.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func deleteConstaint(completion: (Void) -> Void) {
        self.managedObjectContext?.deleteObject(self)
        
        do {
            try self.managedObjectContext?.save()
            completion()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
