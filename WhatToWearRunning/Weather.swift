//
//  Weather.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/19/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import ForecastIO
import CoreLocation

class Weather {
    
    let forecastIOClient = APIClient(apiKey: forecastIOClientApiKey)

    private var forecast: Forecast?
    var currentForecast: DataPoint?
    private var dailyForecast: DataBlock?

    var summary: String?
    var summaryIcon: String?
    var temperature: Int?
    var apparentTemperature: Int?
    var windSpeed: Int?
    var windBearing: String?
    var locality: String?
    var precipitationProbability: Float?
    var updatedAtDate: NSDate?
//    var daytime: String?

    func getWeatherData(location: CLLocation, completion: (weather: Weather) -> Void) {
        self.getLocalityFromLocation(location, completion: { void in
            self.forecastIOClient.getForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, completion: { (forecast, error) in
                if let forecast = forecast {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.forecast = forecast
                        self.currentForecast = forecast.currently
                        self.dailyForecast = forecast.daily

//                            self.isDaytime()

                        if let currentForecast = self.currentForecast {
                            if let summary = currentForecast.summary, summaryIcon = currentForecast.icon, temperature = currentForecast.temperature, apparentTemperature = currentForecast.apparentTemperature, windSpeed = currentForecast.windSpeed, windBearing = currentForecast.windBearing, precipitationProbability = currentForecast.precipProbability {
                                self.summary = summary
                                self.summaryIcon = self.summaryIcon(summaryIcon)
                                self.temperature = Int(temperature)
                                self.apparentTemperature = Int(apparentTemperature)
                                self.windSpeed = Int(windSpeed)
                                self.windBearing = self.windBearing(windBearing)
                                self.precipitationProbability = precipitationProbability
                                self.updatedAtDate = NSDate()
                                completion(weather: self)
                            }
                        }
                    })
                }
            })
        })
    }

    func windBearing(windBearing: Float) -> String {
        switch windBearing {
        case 0..<45:
            return "Wind from N"
        case 45..<135:
            return "Wind from E"
        case 135..<225:
            return "Wind from S"
        case 225..<315:
            return "Wind from W"
        case 305..<360:
            return "Wind from N"
        default:
            return "No Wind"
        }
    }

    private func summaryIcon(icon: Icon) -> String {
        switch icon {
        case .ClearDay:
            return "clear-day"
        case .ClearNight:
            return "clear-night"
        case .Rain:
            return "rain"
        case .Snow:
            return "snow"
        case .Sleet:
            return "sleet"
        case .Wind:
            return "wind"
        case .Fog:
            return "fog"
        case .Cloudy:
            return "cloudy"
        case .PartlyCloudyDay:
            return "partly-cloudy-day"
        case .PartlyCloudyNight:
            return "partly-cloudy-night"
        default:
            return ""
        }
    }

    private func getLocalityFromLocation(location: CLLocation, completion: () -> Void) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if (error != nil) { print(error) }

            if let pm = placemarks where pm.count > 0 {
                if let local  = pm[0].locality {
                    self.locality = local
                    completion()
                }
            }
        })
    }

    func getGeolocationFromZipcode(zipcode: Int, completion: (weather: Weather?, error: String?) -> Void) {
        CLGeocoder().geocodeAddressString("\(zipcode) USA") { (placemarks, error) in
            if (error != nil) { completion(weather: nil, error: "Could not find address") }

            if let pm = placemarks where pm.count > 0 {
                if let firstPlacemark = pm.first, local = firstPlacemark.locality, location = firstPlacemark.location {
                    self.locality = local
                    self.getWeatherData(location, completion: { (weather) -> Void in
                        completion(weather: self, error: nil)
                    })
                }
            }
        }
    }

//    private func isDaytime() {
//        if let dailyForecast = dailyForecast, sunrise = dailyForecast.data?[0].sunriseTime, sunset = dailyForecast.data?[0].sunsetTime {
//            let now = NSDate()
//            if (now.compare(sunrise) == .OrderedDescending) && (now.compare(sunset) == .OrderedAscending) {
//                self.daytime = "daytime"
//            } else {
//                self.daytime = "nighttime"
//            }
//        }
//    }
}