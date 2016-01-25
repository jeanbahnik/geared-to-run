//
//  Gear.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/19/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import Foundation

struct GearConstraints {
    let gearType: GearItem
    let minTemp: Int
    let maxTemp: Int
    let minWind: Int?
    let rain: Float?
}

struct GearItem {
    let description: String
}

class GearList {
    var gearList = [GearConstraints]()

    init() {
        let capSunglasses = GearItem(description: "Cap or Sunglasses")
        let capSunglasses1 = GearConstraints(gearType: capSunglasses, minTemp: 80, maxTemp: 200, minWind: nil, rain: nil)
        gearList.append(capSunglasses1)
        let lightHat = GearItem(description: "Light Hat")
        let lightHat1 = GearConstraints(gearType: lightHat, minTemp: 30, maxTemp: 50, minWind: nil, rain: nil)
        gearList.append(lightHat1)
        let heavyHat = GearItem(description: "Heavy Hat")
        let heavyHat1 = GearConstraints(gearType: heavyHat, minTemp: 20, maxTemp: 30, minWind: nil, rain: nil)
        gearList.append(heavyHat1)
        let faceMask = GearItem(description: "Face Mask")
        let faceMask1 = GearConstraints(gearType: faceMask, minTemp: 0, maxTemp: 10, minWind: 10, rain: nil)
        gearList.append(faceMask1)
        let tshirt = GearItem(description: "T-shirt")
        let tshirt1 = GearConstraints(gearType: tshirt, minTemp: 20, maxTemp: 200, minWind: nil, rain: nil)
        gearList.append(tshirt1)
        let tshirt2 = GearConstraints(gearType: tshirt, minTemp: 20, maxTemp: 200, minWind: nil, rain: nil)
        gearList.append(tshirt2)
    }
}
