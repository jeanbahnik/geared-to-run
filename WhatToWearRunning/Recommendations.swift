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
        self.currentForecast = forecast.currently
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
            print("wind: \(currentForecast.windSpeed!)")
            print("temperature: \(currentForecast.temperature!)")
            if gear.minTemp ..< gear.maxTemp ~= Int(currentForecast.temperature!) {
                include = true
                print(gear.minWind)
                if let wind = gear.minWind {
                    include = false
                    if Int(currentForecast.windSpeed!) >= wind {
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