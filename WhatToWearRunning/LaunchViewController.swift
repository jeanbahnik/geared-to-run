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
    
    var weather = Weather()
    var Recommendation = Recommendations()

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
        SVProgressHUD.setBackgroundColor(Style.navyBlueColor)
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0.0, vertical: self.view.bounds.height / 4))
        SVProgressHUD.show()
//        if let manager = locationManager.location {
            locationManager.stopUpdatingLocation()
            Weather().getWeatherData(locationManager, completion: { (weather, error) -> Void in
                SVProgressHUD.dismiss()
                print(weather)
                self.performSegueWithIdentifier("Home", sender: nil)
            })
//        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.messageLabel.textAlignment = .Center
        self.messageLabel.textColor = UIColor.whiteColor()
        self.messageLabel.text = "Enable Location Services and Try Again"
    }

}