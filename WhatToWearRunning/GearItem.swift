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

    var detailedDescription: String {
        switch (self) {
        case .Head: return "e.g., cap, hat\u{2026}"
        case .Torso: return "e.g., t-shirt, sweater\u{2026}"
        case .Legs: return "e.g., shorts, pants\u{2026}"
        case .Feet: return "e.g., socks, shoes\u{2026}"
        case .Accessories: return "e.g., watch, sunglasses\u{2026}"
        case .Count: return ""
        }
    }
}

class GearItem: NSManagedObject {

    
//    bool if seed + date stored in nsuserdefault
    class func saveNewItem(name: String, slot: Int16, seedData: Bool, completion: (item: GearItem?) -> Void) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("GearItem", inManagedObjectContext:managedContext)
        let gearItem = GearItem(entity: entity!, insertIntoManagedObjectContext: managedContext)

        gearItem.name = name
        gearItem.slot = slot
        gearItem.seedData = seedData

        do {
            try gearItem.managedObjectContext?.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        completion(item: gearItem)
    }
    
    func updateItem(name: String, slot: Int16, completion: (item: GearItem?) -> Void) {

        self.name = name
        self.slot = slot
        self.seedData = false
        
        do {
            try self.managedObjectContext?.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        completion(item: self)
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
    
    class func deleteSeedData(completion: (Void) -> Void) {
        let gearList: [GearItem] = GearList.sharedInstance.getGearItems()!
        for item in gearList {
            if item.seedData == true {
                item.deleteItem({ (Void) in })
            }
        }
        User.sharedInstance.setDeletedSeedData()
        completion()
    }
}
