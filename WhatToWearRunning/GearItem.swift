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
    
    var description: String {
        switch (self) {
        case .Head: return "Head"
        case .Torso: return "Torso"
        case .Legs: return "Legs"
        case .Feet: return "Feet"
        case .Accessories: return "Accessories"
        case .Count: return ""
        }
    }
}

class GearItem: NSManagedObject {

    class func saveNewItem(name: String, slot: Int16, completion: (item: GearItem?) -> Void) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("GearItem", inManagedObjectContext:managedContext)
        let gearItem = GearItem(entity: entity!, insertIntoManagedObjectContext: managedContext)

        gearItem.name = name
        gearItem.slot = slot

        do {
            try gearItem.managedObjectContext?.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        completion(item: gearItem)
    }
    
    class func updateItem(name: String, slot: Int16, item: GearItem, completion: (item: GearItem?) -> Void) {

        let gearItem = item
        gearItem.name = name
        gearItem.slot = slot
        
        do {
            try gearItem.managedObjectContext?.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        completion(item: gearItem)
    }
    
    func deleteItem(completion: (Void) -> Void) {
        self.managedObjectContext?.deleteObject(self)
        
        do {
            try self.managedObjectContext?.save()
            completion()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
}
