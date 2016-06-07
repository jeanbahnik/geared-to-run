//
//  Recommendation.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/18/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import ForecastIO

class Recommendation {
    private var gearList: [GearConstraint] = []
    private var recommendedOutfit: [[GearItem]] = []

    init() {
        if let gearList = GearList.sharedInstance.getGearConstraints() {
            self.gearList = gearList
        }
    }

    func getRecommendedOutfit(weather: [HourlyWeather], completion: (recommendation: [[GearItem]]) -> Void) {
        for hourlyWeather in weather {
            var hourlyItemSet: [GearItem] = []
            for item in gearList {
                if (self.getGear(item, currentForecast: hourlyWeather) == true) {
                    if !hourlyItemSet.contains(item.item!) {
                        hourlyItemSet.append(item.item!)
                    }
                }
            }

            recommendedOutfit.append(hourlyItemSet)
        }
        completion(recommendation: recommendedOutfit)
    }

    func getGear(gear: GearConstraint, currentForecast: HourlyWeather) -> Bool {
        if let temperature = currentForecast.temperature, windSpeed = currentForecast.windSpeed, precipitationProbability = currentForecast.precipitationProbability {
            // TODO: that +1 and that +0.001 are gross, and just a hack, because you can't have a range where end is less than (or equal) to start.
            if (Int(gear.minTemperature) ..< Int(gear.maxTemperature)+1 ~= Int(temperature)) && (Int(windSpeed) >= Int(gear.minWindSpeed)) && (gear.minPrecipProbability ..< gear.maxPrecipProbability+0.001 ~= precipitationProbability) { return true }
        }
        return false
    }
}