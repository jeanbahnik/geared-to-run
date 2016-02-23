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
    var recommendedOutfit: [GearItem] = []

    init() {
        self.gearList = GearList().gearList
    }

    func getRecommendedOutfit(weather: HourlyWeather?, completion: (recommendation: Recommendation) -> Void) {
        if let weather = weather {
            if let list = gearList {
                for item in list {
                    getGear(item, currentForecast: weather)
                }
                recommendedOutfit = recommendedOutfit.flatMap{$0}
                completion(recommendation: self)
            }
        }
    }

    func getGear(gear: GearConstraints, currentForecast: HourlyWeather) {
        if let temperature = currentForecast.temperature, windSpeed = currentForecast.windSpeed, precipitationProbability = currentForecast.precipitationProbability {

            if (gear.minTemp ..< gear.maxTemp ~= Int(temperature)) && (Int(windSpeed) >= gear.minWind) && (gear.rain >= precipitationProbability) {
                    recommendedOutfit.append(gear.gearItem)
                }
        }
    }
}