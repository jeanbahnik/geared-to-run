//
//  Gear.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/19/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import CoreData

class GearList: NSObject {
    static let sharedInstance = GearList()
    
    var gearList = [GearConstraint]()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

    private override init() {
        super.init()

        getGearList()
    }

    func getGearList() {
        if isDataStoreEmpty() == true && !User.sharedInstance.deletedSeedData() {
            createDefaultGearList()
        } else {
            if let gearList = getGearConstraints() as [GearConstraint]! {
                self.gearList = gearList
            }
        }
    }

    func createDefaultGearList() {
        let date = User.sharedInstance.setSeedDataDate()

        GearItem.saveNewItem("T-Shirt", slot: Int16(GearSlot.Torso.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 100, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
                GearConstraint.saveConstraint(item, minTemp: 50, maxTemp: 100, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Face Mask", slot: Int16(GearSlot.Head.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 20, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Light Hat", slot: Int16(GearSlot.Head.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 20, maxTemp: 40, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Long sleeve shirt", slot: Int16(GearSlot.Torso.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 60, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Heavy Jacket", slot: Int16(GearSlot.Torso.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 35, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Wind Jacket", slot: Int16(GearSlot.Torso.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 40, minWind: 20, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Pants", slot: Int16(GearSlot.Legs.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 40, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Shorts", slot: Int16(GearSlot.Legs.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 40, maxTemp: 100, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Light Gloves", slot: Int16(GearSlot.Accessories.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 30, maxTemp: 50, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Heavy Gloves", slot: Int16(GearSlot.Accessories.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Cap or Sunglasses", slot: Int16(GearSlot.Accessories.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 55, maxTemp: 100, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Light Socks", slot: Int16(GearSlot.Feet.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 30, maxTemp: 100, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })

        GearItem.saveNewItem("Heavy Socks", slot: Int16(GearSlot.Feet.rawValue), seedData: true, seedDate: date, completion: { item in
            if let item = item {
                GearConstraint.saveConstraint(item, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 50, minRain: 0.0, maxRain: 1.0)
            }
        })
        
        if let gearList = getGearConstraints() as [GearConstraint]! {
            self.gearList = gearList
        }
        
        User.sharedInstance.setDeletedSeedData(false)
    }

    func getGearConstraints() -> [GearConstraint]? {
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("GearConstraint", inManagedObjectContext: managedObjectContext)

        fetchRequest.entity = entityDescription

        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest)
            return result as? [GearConstraint]
            
        } catch {
            let fetchError = error as NSError
            print(fetchError.description)
        }
        
        return nil
    }

    func getGearItems() -> [GearItem]? {
        let managedObjectContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("GearItem", inManagedObjectContext: managedObjectContext)
        
        fetchRequest.entity = entityDescription
        
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest)
            return result as? [GearItem]
            
        } catch {
            let fetchError = error as NSError
            print(fetchError.description)
        }
        
        return nil
    }

    
    private func isDataStoreEmpty() -> Bool {
        var response = true

        let managedObjectContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("GearConstraint", inManagedObjectContext: managedObjectContext)
        
        fetchRequest.entity = entityDescription
        
        do {
            let result = try managedObjectContext.executeFetchRequest(fetchRequest)
            if result.count > 0 { response = false }
        } catch {
            let fetchError = error as NSError
            print(fetchError.description)
        }
        
        return response
    }
}
