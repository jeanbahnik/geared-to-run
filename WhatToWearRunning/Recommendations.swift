//
//  Recommendations.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/18/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import Foundation
import ForecastIO

enum Gear {
    enum Head {
        case CapSunglasses, LightHat, HeavyHat, FaceMask
        var description: String {
            switch self {
            case .CapSunglasses: return "Cap or Sunglasses"
            case .LightHat: return "Light Hat"
            case .HeavyHat: return "Heavy Hat"
            case .FaceMask: return "Face Mask"
            }
        }
    }
}

class Recommendations {
    
    var forecast: Forecast?
    var recommendedOutfit = [String]()
    
    init(forecast: Forecast) {
        self.forecast = forecast
        selectHeadGear()
    }
    
//    func outfitRecommendation() -> String {
//        var outfitRecommendation: String?
//        if let currently = forecast?.currently {
//            if let summary = currently.summary {
//                switch summary {
//                case "Mostly Cloudy":
//                    outfitRecommendation = "It's mostly cloudy so it may rain"
//                default:
//                    outfitRecommendation = "No instructions"
//                }
//            }
//        }
//        
//        return outfitRecommendation!
//    }
    
//    func selectGear {
//        if let forecast = self.forecast {
//            if let currently = forecast.currently {
//                
//            }
//        }
//    }
    
    func selectHeadGear() {
        if let forecast = self.forecast {
            if let currently = forecast.currently {
                print(Int(currently.temperature!))
                switch Int(currently.temperature!) {
                case 0..<20: recommendedOutfit.append(Gear.Head.FaceMask.description)
                case 20..<30: recommendedOutfit.append(Gear.Head.HeavyHat.description)
                case 80..<200: recommendedOutfit.append(Gear.Head.CapSunglasses.description)
                case 30..<50: recommendedOutfit.append(Gear.Head.LightHat.description)
                default: recommendedOutfit.append("No head gear")
                }
                
            }
        }
    }
    
    func recommendationText() -> String {
        return recommendedOutfit.joinWithSeparator(", ")
    }
}