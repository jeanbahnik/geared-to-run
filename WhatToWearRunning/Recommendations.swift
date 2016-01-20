//
//  Recommendations.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/18/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import Foundation
import ForecastIO

//enum Gear {
//    enum Head {
//        case CapSunglasses, LightHat, HeavyHat, FaceMask
//        var description: String {
//            switch self {
//            case .CapSunglasses: return "Cap or Sunglasses"
//            case .LightHat: return "Light Hat"
//            case .HeavyHat: return "Heavy Hat"
//            case .FaceMask: return "Face Mask"
//            }
//        }
//    }
//}

//class Gear {
//    var description: String?
//    
//    init(description: String) {
//        self.description = description
//    }
//}

struct Gear {
    var description: String
    var minTemp: Int
    var maxTemp: Int
    var minWind: Int?
//    var forTheRain: Bool
}

class Recommendations {
    
    var forecast: Forecast?
    var recommendedOutfit = [String]()
    var gearList = [Gear]()
    
    var capSunglasses = Gear(description: "Cap or Sunglasses", minTemp: 80, maxTemp: 200, minWind: nil) {
        didSet {
            gearList.append(capSunglasses)
        }
    }
    var lightHat = Gear(description: "Light Hat", minTemp: 30, maxTemp: 50, minWind: nil) {
        didSet {
            gearList.append(capSunglasses)
        }
    }
    var heavyHat = Gear(description: "Heavy Hat", minTemp: 20, maxTemp: 30, minWind: nil) {
        didSet {
            gearList.append(capSunglasses)
        }
    }
    var faceMask = Gear(description: "Face Mask", minTemp: 0, maxTemp: 10, minWind: 10) {
        didSet {
            gearList.append(capSunglasses)
        }
    }
    
    init(forecast: Forecast) {
        self.forecast = forecast
//        selectHeadGear()
//        getFaceMask()
//        getHeavyMask()
        getGear(heavyHat)
        getGear(faceMask)
//        for gear in gearList {
//            print(gear.description)
//            getGear(gear)
//        }
    }

    func getGear(gear: Gear) {
        var include = false
        if let forecast = self.forecast {
            if let currently = forecast.currently {
                print("wind: \(currently.windSpeed!)")
                if gear.minTemp ..< gear.maxTemp ~= Int(currently.temperature!) {
                    include = true
                    if let wind = gear.minWind {
                        include = false
                        if Int(currently.windSpeed!) >= wind {
                            include = true
                        }
                    }
                }
            }
        }
        
        if include == true {
            recommendedOutfit.append(gear.description)
        }
    }

    
    func getFaceMask() {
        if let forecast = self.forecast {
            if let currently = forecast.currently {
                print("wind: \(currently.windSpeed!)")
                if faceMask.minTemp ..< faceMask.maxTemp ~= Int(currently.temperature!) {
                    if let wind = faceMask.minWind {
                        if Int(currently.windSpeed!) >= wind {
                            recommendedOutfit.append(faceMask.description)
                        }
                    }
                }
            }
        }
    }
    
    func getHeavyMask() {
        if let forecast = self.forecast {
            if let currently = forecast.currently {
                if heavyHat.minTemp ..< heavyHat.maxTemp ~= Int(currently.temperature!) {
                    recommendedOutfit.append(heavyHat.description)
                }
            }
        }
    }
    
//    func selectHeadGear() {
//        if let forecast = self.forecast {
//            if let currently = forecast.currently {
//                print(Int(currently.temperature!))
//                switch Int(currently.temperature!) {
//                case 0..<20: recommendedOutfit.append(faceMask.description)
//                case 20..<30: recommendedOutfit.append(heavyHat.description)
//                case 80..<200: recommendedOutfit.append(capSunglasses.description)
//                case 30..<50: recommendedOutfit.append(lightHat.description)
//                default: recommendedOutfit.append("No head gear")
//                }
//            }
//        }
//    }
    
    func recommendationText() -> String {
        return recommendedOutfit.joinWithSeparator(", ")
    }
}