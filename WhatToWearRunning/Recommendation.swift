//
//  Recommendation.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/18/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import ForecastIO

class Recommendation {
    private let gearList: [GearConstraint]
    private var recommendedOutfit: [[GearItem]] = []

    init() { gearList = GearList.sharedInstance.gearList }

    func getRecommendedOutfit(weather: [HourlyWeather], completion: (recommendation: [[GearItem]]) -> Void) {
        for hourlyWeather in weather {
            var hourlyItemSet: [GearItem] = []
            for item in gearList {
                if (self.getGear(item, currentForecast: hourlyWeather) == true) { hourlyItemSet.append(item.item!) }
            }

            hourlyItemSet = hourlyItemSet.flatMap{$0}
            if !hourlyItemSet.isEmpty { recommendedOutfit.append(hourlyItemSet) }
        }
        completion(recommendation: recommendedOutfit)
    }

    func getGear(gear: GearConstraint, currentForecast: HourlyWeather) -> Bool {
        if let temperature = currentForecast.temperature, windSpeed = currentForecast.windSpeed, precipitationProbability = currentForecast.precipitationProbability {
            if (Int(gear.minTemp) ..< Int(gear.maxTemp) ~= Int(temperature)) && (Int(windSpeed) >= Int(gear.minWind)) && (gear.minRain ..< gear.maxRain ~= precipitationProbability) { return true }
        }
        return false
    }
}