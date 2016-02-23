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

    var weather = [HourlyWeather]()
    var recommendation = Recommendation()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        view.backgroundColor = Style.navyBlueColor

        SVProgressHUD.setBackgroundColor(Style.navyBlueColor)
        SVProgressHUD.setForegroundColor(UIColor.whiteColor())
        SVProgressHUD.setOffsetFromCenter(UIOffset(horizontal: 0.0, vertical: view.frame.height / 4))
        
        LocationManager.sharedInstance.requestPermission() {
            [weak self] status in
            if status != .AuthorizedAlways {
                self?.displayError("Enable Location Services and Try Again")
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
        if Reachability.isConnectedToNetwork() == false {
            displayError("Connect Internet and Try Again")
        } else {
            messageLabel.text = nil
            LocationManager.sharedInstance.stopUpdatingLocation()
            SVProgressHUD.show()
            Weather().getWeatherData(locationManager, completion: { weather in
                if let weather = weather {
                    self.weather = weather
                    Recommendation().getRecommendedOutfit(weather[0], completion: { (recommendation : Recommendation?) -> Void in
                        if let recommendation = recommendation {
                            self.recommendation = recommendation
                            SVProgressHUD.dismiss()
                            self.performSegueWithIdentifier("Home", sender: nil)
                        }
                    })
                }
            })
        }
    }

    func displayError(error: String) {
        messageLabel.textAlignment = .Center
        messageLabel.textColor = UIColor.whiteColor()
        messageLabel.text = error
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