//
//  Gear.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/19/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

struct GearConstraints {
    let gearItem: GearItem
    let minTemp: Int
    let maxTemp: Int
    let minWind: Int
    let maxWind: Int
    let minRain: Float
    let maxRain: Float
}

struct GearItem {
    let description: String
    let slot: GearSlot
}

enum GearSlot: Int {
    case Head, Torso, Legs, Feet, Accessories, Count
}

class GearList {
    var gearList = [GearConstraints]()

    init() {
        createDefaultGearList()
    }
    
    func createDefaultGearList() {
        let faceMask = GearItem(description: "Face Mask", slot: .Head)
        let faceMask1 = GearConstraints(gearItem: faceMask, minTemp: 0, maxTemp: 20, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(faceMask1)
        let faceMask2 = GearConstraints(gearItem: faceMask, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(faceMask2)
        let lightHat = GearItem(description: "Light Hat", slot: .Head)
        let lightHat1 = GearConstraints(gearItem: lightHat, minTemp: 20, maxTemp: 40, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(lightHat1)
        let longSleeveShirt = GearItem(description: "Long sleeve shirt", slot: .Torso)
        let longSleeveShirt1 = GearConstraints(gearItem: longSleeveShirt, minTemp: 0, maxTemp: 60, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(longSleeveShirt1)
        let heavyJacket = GearItem(description: "Heavy Jacket", slot: .Torso)
        let heavyJacket1 = GearConstraints(gearItem: heavyJacket, minTemp: 0, maxTemp: 35, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(heavyJacket1)
        let windJacket = GearItem(description: "Wind Jacket", slot: .Torso)
        let windJacket1 = GearConstraints(gearItem: windJacket, minTemp: 0, maxTemp: 40, minWind: 20, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(windJacket1)
        let tshirt = GearItem(description: "T-shirt", slot: .Torso)
        let tshirt1 = GearConstraints(gearItem: tshirt, minTemp: 0, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(tshirt1)
        let tshirt2 = GearConstraints(gearItem: tshirt, minTemp: 60, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(tshirt2)
        let pants = GearItem(description: "Pants", slot: .Legs)
        let pants1 = GearConstraints(gearItem: pants, minTemp: 0, maxTemp: 40, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(pants1)
        let shorts = GearItem(description: "Shorts", slot: .Legs)
        let shorts1 = GearConstraints(gearItem: shorts, minTemp: 40, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(shorts1)
        let lightGloves = GearItem(description: "Light Gloves", slot: .Accessories)
        let lightGloves1 = GearConstraints(gearItem: lightGloves, minTemp: 30, maxTemp: 50, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(lightGloves1)
        let lightGloves2 = GearConstraints(gearItem: lightGloves, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(lightGloves2)
        let heavyGloves = GearItem(description: "Heavy Gloves", slot: .Accessories)
        let heavyGloves1 = GearConstraints(gearItem: heavyGloves, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(heavyGloves1)
        let capSunglasses = GearItem(description: "Cap or Sunglasses", slot: .Accessories)
        let capSunglasses1 = GearConstraints(gearItem: capSunglasses, minTemp: 60, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(capSunglasses1)
        let lightSocks = GearItem(description: "Light Socks", slot: .Feet)
        let lightSocks1 = GearConstraints(gearItem: lightSocks, minTemp: 30, maxTemp: 100, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(lightSocks1)
        let heavySocks = GearItem(description: "Heavy Socks", slot: .Feet)
        let heavySocks1 = GearConstraints(gearItem: heavySocks, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 100, minRain: 0, maxRain: 1)
        gearList.append(heavySocks1)
    }
}
