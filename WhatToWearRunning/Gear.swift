//
//  Gear.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/19/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import Foundation

struct GearItem {
    let description: String
    let minTemp: Int
    let maxTemp: Int
    let minWind: Int?
    let rain: Float?
}

class Gear {
    var gearList = [GearItem]()

    init() {
        let capSunglasses = GearItem(description: "Cap or Sunglasses", minTemp: 80, maxTemp: 200, minWind: nil, rain: 0.0)
        gearList.append(capSunglasses)
        let lightHat = GearItem(description: "Light Hat", minTemp: 30, maxTemp: 50, minWind: nil, rain: 0.0)
        gearList.append(lightHat)
        let heavyHat = GearItem(description: "Heavy Hat", minTemp: 20, maxTemp: 30, minWind: nil, rain: 0.0)
        gearList.append(heavyHat)
        let faceMask = GearItem(description: "Face Mask", minTemp: 0, maxTemp: 10, minWind: 10, rain: 0.0)
        gearList.append(faceMask)
    }
}
