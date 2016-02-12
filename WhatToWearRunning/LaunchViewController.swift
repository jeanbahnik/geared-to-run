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
    var recommendation = Recommendation()
    
    var weatherAndRecommendation: [String] = []

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
        self.locationManager.stopUpdatingLocation()
        SVProgressHUD.setBackgroundColor(Style.navyBlueColor)
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0.0, vertical: self.view.frame.height / 4))
        SVProgressHUD.show()
        Weather().getWeatherData(locationManager) { ( weather : Weather? ) in
            if let weather = weather {
                self.weather = weather
                Recommendation().getRecommendedOutfit(weather, completion: { (recommendation : Recommendation?) -> Void in
                    if let recommendation = recommendation {
                        self.recommendation = recommendation
                        SVProgressHUD.dismiss()
                        self.performSegueWithIdentifier("Home", sender: nil)
                    }
                })
            }
        }
    }

    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.messageLabel.textAlignment = .Center
        self.messageLabel.textColor = UIColor.whiteColor()
        self.messageLabel.text = "Enable Location Services and Try Again"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if (segue.identifier == "Home") {
            let vc = segue.destinationViewController as! HomeViewController
            vc.weather = self.weather
            vc.outfit = self.recommendation
        }
    }
}