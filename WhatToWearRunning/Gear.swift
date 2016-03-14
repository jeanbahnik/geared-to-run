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

        if isDataStoreEmpty() == true {
            createDefaultGearList()
        } else {
            if let gearList = getGearConstraints() as [GearConstraint]! {
                self.gearList = gearList
            }
        }
    }

    func createDefaultGearList() {
        let tshirt = GearItem.saveItem("T-Shirt", slot: GearSlot.Torso.rawValue)
        GearConstraint.saveConstraint(tshirt, minTemp: 0, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)
        GearConstraint.saveConstraint(tshirt, minTemp: 60, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let faceMask = GearItem.saveItem("Face Mask", slot: GearSlot.Head.rawValue)
        GearConstraint.saveConstraint(faceMask, minTemp: 0, maxTemp: 20, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)
        GearConstraint.saveConstraint(faceMask, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let lightHat = GearItem.saveItem("Light Hat", slot: GearSlot.Head.rawValue)
        GearConstraint.saveConstraint(lightHat, minTemp: 20, maxTemp: 40, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let longSleeveShirt = GearItem.saveItem("Long sleeve shirt", slot: GearSlot.Torso.rawValue)
        GearConstraint.saveConstraint(longSleeveShirt, minTemp: 0, maxTemp: 60, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let heavyJacket = GearItem.saveItem("Heavy Jacket", slot: GearSlot.Torso.rawValue)
        GearConstraint.saveConstraint(heavyJacket, minTemp: 0, maxTemp: 35, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let windJacket = GearItem.saveItem("Wind Jacket", slot: GearSlot.Torso.rawValue)
        GearConstraint.saveConstraint(windJacket, minTemp: 0, maxTemp: 40, minWind: 20, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let pants = GearItem.saveItem("Pants", slot: GearSlot.Legs.rawValue)
        GearConstraint.saveConstraint(pants, minTemp: 0, maxTemp: 40, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let shorts = GearItem.saveItem("Shorts", slot: GearSlot.Legs.rawValue)
        GearConstraint.saveConstraint(shorts, minTemp: 40, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let lightGloves = GearItem.saveItem("Light Gloves", slot: GearSlot.Accessories.rawValue)
        GearConstraint.saveConstraint(lightGloves, minTemp: 30, maxTemp: 50, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)
        GearConstraint.saveConstraint(lightGloves, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let heavyGloves = GearItem.saveItem("Heavy Gloves", slot: GearSlot.Accessories.rawValue)
        GearConstraint.saveConstraint(heavyGloves, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let capSunglasses = GearItem.saveItem("Cap or Sunglasses", slot: GearSlot.Accessories.rawValue)
        GearConstraint.saveConstraint(capSunglasses, minTemp: 55, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let lightSocks = GearItem.saveItem("Light Socks", slot: GearSlot.Accessories.rawValue)
        GearConstraint.saveConstraint(lightSocks, minTemp: 30, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)

        let heavySocks = GearItem.saveItem("Heavy Socks", slot: GearSlot.Accessories.rawValue)
        GearConstraint.saveConstraint(heavySocks, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 100, minRain: 0.0, maxRain: 1.0)
        
        if let gearList = getGearConstraints() as [GearConstraint]! {
            self.gearList = gearList
        }
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
