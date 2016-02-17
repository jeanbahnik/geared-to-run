//
//  Location.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/16/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationManager()

    private var locationManager: CLLocationManager!
    private var permissionBlock: (CLAuthorizationStatus -> Void)?
    var locationUpdatedBlock: (CLLocation? -> Void)?
    var locationErrorBlock: (NSError -> Void)?
    
    private override init() {
        super.init()
        commonInit()
    }

    private func commonInit() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
    
    func requestPermission(completion: (CLAuthorizationStatus -> Void)?) {
        permissionBlock = completion
        locationManager.requestAlwaysAuthorization()
    }

    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationUpdatedBlock?(locations.first)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        locationErrorBlock?(error)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        permissionBlock?(status)
    }
}