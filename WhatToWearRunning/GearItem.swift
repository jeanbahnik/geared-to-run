//
//  GearItem.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/12/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import CoreData

enum GearSlot: Int {
    case Head, Torso, Legs, Feet, Accessories, Count
}

class GearItem: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var slot: Int
    
    class func saveitem(name: String, slot: Int) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("GearItem", inManagedObjectContext:managedContext)
        let gearItem = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        gearItem.setValue(name, forKey: "name")
        gearItem.setValue(slot, forKey: "slot")
        do {
            try gearItem.managedObjectContext?.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
