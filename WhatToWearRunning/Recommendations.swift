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
    let gearList: [GearItem]?
    var recommendedOutfit = [String]()

    init(forecast: Forecast) {
        self.currentForecast = Weather(forecast: forecast).currentForecast
        self.gearList = Gear().gearList
    }

    func getRecommendedOutfit() {
        if let list = gearList {
            for item in list {
                getGear(item)
            }
        }
    }

    func getGear(gear: GearItem) {
        var include = false
        if let currentForecast = self.currentForecast {
            if let temperature = currentForecast.temperature, let windSpeed = currentForecast.windSpeed, let precipitationProbability = currentForecast.precipProbability {
                if gear.minTemp ..< gear.maxTemp ~=
                    Int(temperature) {
                    include = true
                }
                if let wind = gear.minWind {
                    include = false
                    if Int(windSpeed) >= wind {
                        include = true
                    }
                }
                if let rain = gear.rain {
                    include = false
                    if rain >= precipitationProbability {
                        include = true
                    }
                }
            }
        }
        
        if include == true {
            recommendedOutfit.append(gear.description)
        }
    }

    func recommendationText() -> String {
        getRecommendedOutfit()
        return recommendedOutfit.joinWithSeparator(", ")
    }
}