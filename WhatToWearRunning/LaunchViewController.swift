//
//  LaunchViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/1/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import CoreLocation
import SVProgressHUD

class LaunchViewController: UIViewController, CLLocationManagerDelegate {

    private var locationManager = CLLocationManager()
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Style.navyBlueColor

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationManager.location {
            locationManager.stopUpdatingLocation()
            self.performSegueWithIdentifier("Home", sender: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.messageLabel.textAlignment = .Center
        self.messageLabel.textColor = UIColor.whiteColor()
        self.messageLabel.text = "Enable Location Services and Try Again"
    }

}