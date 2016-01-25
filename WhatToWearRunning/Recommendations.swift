//
//  Recommendations.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/18/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import Foundation
import ForecastIO

class Recommendations {

    let currentForecast: DataPoint?
    let gearList: [GearConstraints]?
    var recommendedOutfit = [String]()

    init(forecast: Forecast) {
        self.currentForecast = Weather(forecast: forecast).currentForecast
        self.gearList = GearList().gearList
    }

    func getRecommendedOutfit() {
        if let list = gearList {
            for item in list {
                getGear(item)
            }
        }
    }

    func getGear(gear: GearConstraints) {
        if recommendedOutfit.contains(gear.gearType.description) { return }
        
        var include = false
        
        if let currentForecast = self.currentForecast {
            
            if let temperature = currentForecast.temperature, let windSpeed = currentForecast.windSpeed, let precipitationProbability = currentForecast.precipProbability {
                
                if gear.minTemp ..< gear.maxTemp ~=
                    Int(temperature) {
                    include = true
                } else {
                    include = false
                }
                
                if let wind = gear.minWind {
                    if Int(windSpeed) >= wind {
                        include = true
                    } else {
                        include = false
                    }
                }
                
                if let rain = gear.rain {
                    if rain >= precipitationProbability {
                        include = true
                    } else {
                        include = false
                    }
                }
            }
        }
        
        if include == true {
            recommendedOutfit.append(gear.gearType.description)
        }
    }

    func recommendationText() -> String {
        getRecommendedOutfit()
        return recommendedOutfit.joinWithSeparator(", ")
    }
}