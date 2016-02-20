//
//  Gear.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/19/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

struct GearConstraints {
    let gearType: GearItem
    let minTemp: Int
    let maxTemp: Int
    let minWind: Int
    let maxWind: Int
    let rain: Float
    let slot: GearSlot
}

struct GearItem {
    let description: String
}

enum GearSlot: Int {
    case Head, Torso, Legs, Feet, Accessories, Count
}

class GearList {
    var gearList = [GearConstraints]()

    init() {
        let tshirt = GearItem(description: "T-shirt")
        let tshirt1 = GearConstraints(gearType: tshirt, minTemp: 0, maxTemp: 100, minWind: 0, maxWind: 100, rain: 0, slot: .Torso)
        gearList.append(tshirt1)
        let shorts = GearItem(description: "Shorts")
        let shorts1 = GearConstraints(gearType: shorts, minTemp: 40, maxTemp: 100, minWind: 0, maxWind: 100, rain: 0, slot: .Legs)
        gearList.append(shorts1)
        let lightSocks = GearItem(description: "Light Socks")
        let lightSocks1 = GearConstraints(gearType: lightSocks, minTemp: 30, maxTemp: 100, minWind: 0, maxWind: 100, rain: 0, slot: .Feet)
        gearList.append(lightSocks1)
        let heavySocks = GearItem(description: "Heavy Socks")
        let heavySocks1 = GearConstraints(gearType: heavySocks, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 100, rain: 0, slot: .Feet)
        gearList.append(heavySocks1)
        let pants = GearItem(description: "Pants")
        let pants1 = GearConstraints(gearType: pants, minTemp: 0, maxTemp: 40, minWind: 0, maxWind: 100, rain: 0, slot: .Feet)
        gearList.append(pants1)
        let faceMask = GearItem(description: "Face Mask")
        let faceMask1 = GearConstraints(gearType: faceMask, minTemp: 0, maxTemp: 20, minWind: 0, maxWind: 100, rain: 0, slot: .Head)
        gearList.append(faceMask1)
        let faceMask2 = GearConstraints(gearType: faceMask, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 100, rain: 0, slot: .Head)
        gearList.append(faceMask2)
        let lightHat = GearItem(description: "Light Hat")
        let lightHat1 = GearConstraints(gearType: lightHat, minTemp: 20, maxTemp: 40, minWind: 0, maxWind: 100, rain: 0, slot: .Head)
        gearList.append(lightHat1)
        let longSleevesShirt = GearItem(description: "Long sleeves shirt")
        let longSleevesShirt1 = GearConstraints(gearType: longSleevesShirt, minTemp: 0, maxTemp: 60, minWind: 0, maxWind: 100, rain: 0, slot: .Torso)
        gearList.append(longSleevesShirt1)
        let heavyJacket = GearItem(description: "Heavy Jacket")
        let heavyJacket1 = GearConstraints(gearType: heavyJacket, minTemp: 0, maxTemp: 35, minWind: 0, maxWind: 100, rain: 0, slot: .Torso)
        gearList.append(heavyJacket1)
        let windJacket = GearItem(description: "Wind Jacket")
        let windJacket1 = GearConstraints(gearType: windJacket, minTemp: 0, maxTemp: 40, minWind: 20, maxWind: 100, rain: 0, slot: .Torso)
        gearList.append(windJacket1)
        let lightGloves = GearItem(description: "Light Gloves")
        let lightGloves1 = GearConstraints(gearType: lightGloves, minTemp: 30, maxTemp: 50, minWind: 0, maxWind: 100, rain: 0, slot: .Torso)
        gearList.append(lightGloves1)
        let lightGloves2 = GearConstraints(gearType: lightGloves, minTemp: 0, maxTemp: 30, minWind: 15, maxWind: 100, rain: 0, slot: .Accessories)
        gearList.append(lightGloves2)
        let heavyGloves = GearItem(description: "Heavy Gloves")
        let heavyGloves1 = GearConstraints(gearType: heavyGloves, minTemp: 0, maxTemp: 30, minWind: 0, maxWind: 100, rain: 0, slot: .Accessories)
        gearList.append(heavyGloves1)
        let capSunglasses = GearItem(description: "Cap or Sunglasses")
        let capSunglasses1 = GearConstraints(gearType: capSunglasses, minTemp: 60, maxTemp: 100, minWind: 0, maxWind: 100, rain: 0, slot: .Accessories)
        gearList.append(capSunglasses1)
    }
}
