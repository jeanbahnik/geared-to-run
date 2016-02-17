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

    @IBOutlet weak var messageLabel: UILabel!

    var weather = Weather()
    var recommendation = Recommendation()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        self.view.backgroundColor = Style.navyBlueColor

        SVProgressHUD.setBackgroundColor(Style.navyBlueColor)
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0.0, vertical: self.view.frame.height / 4))
        
        LocationManager.sharedInstance.requestPermission() {
            [weak self] status in
            if status != .AuthorizedAlways {
                self?.displayLocationError()
            }
        }

        LocationManager.sharedInstance.locationUpdatedBlock = {
            [weak self] location in
            if let location = location {
                self?.fetchData(location)
            }
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    func fetchData(locationManager: CLLocation) {
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

    func displayLocationError() {
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