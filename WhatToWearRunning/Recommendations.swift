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
    
    var forecast: Forecast?
    
    init(forecast: Forecast) {
        self.forecast = forecast
    }
    
    func summaryRecommendation() -> String {
        var summaryRecommendation: String?
        if let currently = forecast?.currently {
            if let summary = currently.summary {
                switch summary {
                case "Mostly Cloudy":
                    summaryRecommendation = "It's mostly cloudy so it may rain"
                default:
                    summaryRecommendation = "No instructions"
                }
            }
        }
        
        return summaryRecommendation!
    }
}