//
//  Recommendation.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/18/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import ForecastIO

class Recommendation {
    let gearList: [GearConstraints]?
    var recommendedOutfit: [String] = []
    var recommendationText: String?

    init() {
        self.gearList = GearList().gearList
    }

    func getRecommendedOutfit(weather: Weather?, completion: (recommendation: Recommendation) -> Void) {
        if let weather = weather, currentWeather = weather.currentForecast {
            if let list = gearList {
                for item in list {
                    getGear(item, currentForecast: currentWeather)
                }
                self.recommendationText = getRecommendationText()
                completion(recommendation: self)
            }
        }
    }

    func getGear(gear: GearConstraints, currentForecast: DataPoint) {
        if recommendedOutfit.contains(gear.gearType.description) { return }
        
        var include = false
        if let temperature = currentForecast.temperature, windSpeed = currentForecast.windSpeed, precipitationProbability = currentForecast.precipProbability {

            if (gear.minTemp ..< gear.maxTemp ~= Int(temperature)) && (Int(windSpeed) >= gear.minWind) && (gear.rain >= precipitationProbability) {
                    include = true
                } else {
                    include = false
                }
        }

        if include == true {
            recommendedOutfit.append(gear.gearType.description)
        }
    }

    func getRecommendationText() -> String {
        return recommendedOutfit.joinWithSeparator(", ")
    }
}