//
//  Recommendations.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/18/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import ForecastIO

class Recommendations {

    var currentForecast: DataPoint?
    let gearList: [GearConstraints]?
    var recommendedOutfit = [String]()

    init() {
        self.gearList = GearList().gearList
    }

//    func getRecommendedOutfit(currentForecast: DataPoint) {
//        self.currentForecast = currentForecast
//        if let list = gearList {
//            for item in list {
//                getGear(item, self.currentForecast)
//            }
//        }
//    }
//
//    func getGear(gear: GearConstraints, currentForecast: Forecast) {
//        self.currentForecast = Weather(forecast: DataPoint).currentForecast
//        if recommendedOutfit.contains(gear.gearType.description) { return }
//        
//        var include = false
//        
//        if let currentForecast = self.currentForecast {
//            
//            if let temperature = currentForecast.temperature, let windSpeed = currentForecast.windSpeed, let precipitationProbability = currentForecast.precipProbability {
//
//                if (gear.minTemp ..< gear.maxTemp ~= Int(temperature)) && (Int(windSpeed) >= gear.minWind) && (gear.rain >= precipitationProbability) {
//                        include = true
//                    } else {
//                        include = false
//                    }
//            }
//        }
//        
//        if include == true {
//            recommendedOutfit.append(gear.gearType.description)
//        }
//    }
//
//    func recommendationText() -> String {
//        getRecommendedOutfit()
//        return recommendedOutfit.joinWithSeparator(", ")
//    }
}