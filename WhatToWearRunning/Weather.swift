//
//  Weather.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/19/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import ForecastIO
import CoreLocation

struct HourlyWeather {
    var summary: String?
    var summaryIcon: String?
    var temperature: Int?
    var apparentTemperature: Int?
    var windSpeed: Int?
    var windBearing: String?
    var locality: String?
    var precipitationProbability: Float?
    var weatherTime: NSDate?
    var updatedAtDate: NSDate?
    var isDaytime: Bool?
}

class Weather {

    let forecastIOClient = APIClient(apiKey: forecastIOClientApiKey)

    func getWeatherData(location: CLLocation, completion: (weather: [HourlyWeather]?) -> Void) {
        self.getLocalityFromLocation(location, completion: { locality in
            self.forecastIOClient.getForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, completion: { forecast, error in
                if let forecast = forecast {
                    dispatch_async(dispatch_get_main_queue(), {
                        let hourlyWeather = self.constructHourlyWeather(forecast, locality: locality)
                        completion(weather: hourlyWeather)
                    })
                }
            })
        })
    }
    
    func constructHourlyWeather(forecast: Forecast, locality: String) -> [HourlyWeather]? {
        var threeHourlyWeather: [HourlyWeather] = []

        for i in 0 ..< 3 {
            if let hourly = forecast.hourly, hourlyData = hourly.data?[i*6], summary = hourlyData.summary, summaryIcon = hourlyData.icon, temperature = hourlyData.temperature, apparentTemperature = hourlyData.apparentTemperature, windSpeed = hourlyData.windSpeed, windBearing = hourlyData.windBearing, precipitationProbability = hourlyData.precipProbability, daily = forecast.daily {
                var hourlyWeather = HourlyWeather()
                hourlyWeather.locality = locality
                hourlyWeather.summary = summary
                hourlyWeather.summaryIcon = self.summaryIcon(summaryIcon)
                hourlyWeather.temperature = Int(temperature)
                hourlyWeather.apparentTemperature = Int(apparentTemperature)
                hourlyWeather.windSpeed = Int(windSpeed)
                hourlyWeather.windBearing = self.windBearing(windBearing)
                hourlyWeather.precipitationProbability = precipitationProbability
                hourlyWeather.weatherTime = hourlyData.time
                hourlyWeather.updatedAtDate = NSDate()
                hourlyWeather.isDaytime = self.isDaytime(daily)
                
                threeHourlyWeather.append(hourlyWeather)
            }
        }
        
        if threeHourlyWeather.isEmpty {
            return nil
        } else {
            return threeHourlyWeather
        }
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

    private func getLocalityFromLocation(location: CLLocation, completion: (locality: String) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) in
            if (error != nil) { print(error) }

            if let pm = placemarks where pm.count > 0 {
                if let local  = pm.first?.locality, state = pm.first?.administrativeArea {
                    completion(locality: "\(local), \(state)")
                }
            }
        })
    }

//    func getGeolocationFromZipcode(zipcode: Int, completion: (weather: Weather?, error: String?) -> Void) {
//        CLGeocoder().geocodeAddressString("\(zipcode) USA") { (placemarks, error) in
//            if (error != nil) { completion(weather: nil, error: "Could not find address") }
//
//            if let pm = placemarks where pm.count > 0 {
//                if let firstPlacemark = pm.first, local = firstPlacemark.locality, location = firstPlacemark.location {
//                    self.locality = local
//                    self.getWeatherData(location, completion: { (weather) -> Void in
//                        completion(weather: self, error: nil)
//                    })
//                }
//            }
//        }
//    }

    private func isDaytime(dailyForecast: DataBlock) -> Bool {
        var isDaytime: Bool = true
        if let sunrise = dailyForecast.data?.first?.sunriseTime, sunset = dailyForecast.data?.first?.sunsetTime {
            let now = NSDate()
            if (now.compare(sunrise) == .OrderedDescending) && (now.compare(sunset) == .OrderedAscending) {
                isDaytime = true
            } else {
                isDaytime = false
            }
        }
        return isDaytime
    }
}