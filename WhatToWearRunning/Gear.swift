//
//  Gear.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/19/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class GearList: NSObject {
    static let sharedInstance = GearList()
    
    var gearList = [GearConstraints]()

    private override init() {
        super.init()
        createDefaultGearList()
    }

    func createDefaultGearList() {
        
//        let tshirt = GearItem(description: "T-shirt", slot: .Torso)
//        let tshirt1 = GearConstraints(gearItem: tshirt, minTemp: 0, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(tshirt1)
//        let tshirt2 = GearConstraints(gearItem: tshirt, minTemp: 60, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(tshirt2)
        GearItem.saveitem("T-shirt", slot: GearSlot.Torso.rawValue)
        
//        let faceMask = GearItem(description: "Face Mask", slot: .Head)
//        let faceMask1 = GearConstraints(gearItem: faceMask, minTemp: 0, maxTemp: 20, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(faceMask1)
//        let faceMask2 = GearConstraints(gearItem: faceMask, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(faceMask2)
        GearItem.saveitem("Face Mask", slot: GearSlot.Head.rawValue)

//        let lightHat = GearItem(description: "Light Hat", slot: .Head)
//        let lightHat1 = GearConstraints(gearItem: lightHat, minTemp: 20, maxTemp: 40, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(lightHat1)
        GearItem.saveitem("Light Hat", slot: GearSlot.Head.rawValue)

//        let longSleeveShirt = GearItem(description: "Long sleeve shirt", slot: .Torso)
//        let longSleeveShirt1 = GearConstraints(gearItem: longSleeveShirt, minTemp: 0, maxTemp: 60, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(longSleeveShirt1)
        GearItem.saveitem("Long sleeve shirt", slot: GearSlot.Torso.rawValue)

//        let heavyJacket = GearItem(description: "Heavy Jacket", slot: .Torso)
//        let heavyJacket1 = GearConstraints(gearItem: heavyJacket, minTemp: 0, maxTemp: 35, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(heavyJacket1)
        GearItem.saveitem("Heavy Jacket", slot: GearSlot.Torso.rawValue)

//        let windJacket = GearItem(description: "Wind Jacket", slot: .Torso)
//        let windJacket1 = GearConstraints(gearItem: windJacket, minTemp: 0, maxTemp: 40, minWind: 20, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(windJacket1)
        GearItem.saveitem("Wind Jacket", slot: GearSlot.Torso.rawValue)

//        let pants = GearItem(description: "Pants", slot: .Legs)
//        let pants1 = GearConstraints(gearItem: pants, minTemp: 0, maxTemp: 40, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(pants1)
        GearItem.saveitem("Pants", slot: GearSlot.Legs.rawValue)

//        let shorts = GearItem(description: "Shorts", slot: .Legs)
//        let shorts1 = GearConstraints(gearItem: shorts, minTemp: 40, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(shorts1)
        GearItem.saveitem("Shorts", slot: GearSlot.Legs.rawValue)

//        let lightGloves = GearItem(description: "Light Gloves", slot: .Accessories)
//        let lightGloves1 = GearConstraints(gearItem: lightGloves, minTemp: 30, maxTemp: 50, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(lightGloves1)
//        let lightGloves2 = GearConstraints(gearItem: lightGloves, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(lightGloves2)
        GearItem.saveitem("Light Gloves", slot: GearSlot.Accessories.rawValue)

//        let heavyGloves = GearItem(description: "Heavy Gloves", slot: .Accessories)
//        let heavyGloves1 = GearConstraints(gearItem: heavyGloves, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(heavyGloves1)
        GearItem.saveitem("Heavy Gloves", slot: GearSlot.Accessories.rawValue)
        
//        let capSunglasses = GearItem(description: "Cap or Sunglasses", slot: .Accessories)
//        let capSunglasses1 = GearConstraints(gearItem: capSunglasses, minTemp: 60, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(capSunglasses1)
        GearItem.saveitem("Cap or Sunglasses", slot: GearSlot.Accessories.rawValue)

//        let lightSocks = GearItem(description: "Light Socks", slot: .Feet)
//        let lightSocks1 = GearConstraints(gearItem: lightSocks, minTemp: 30, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(lightSocks1)
        GearItem.saveitem("Light Socks", slot: GearSlot.Accessories.rawValue)
        
//        let heavySocks = GearItem(description: "Heavy Socks", slot: .Feet)
//        let heavySocks1 = GearConstraints(gearItem: heavySocks, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
//        gearList.append(heavySocks1)
        GearItem.saveitem("Heavy Socks", slot: GearSlot.Accessories.rawValue)
    }
}
