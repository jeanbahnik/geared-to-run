//
//  HomeViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var navBarTitle: UINavigationItem!
    var outfit = Recommendation()
    var weather = Weather()

    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var summaryIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windBearingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Style.navyBlueColor
        self.navigationBar.barTintColor = Style.maroonColor
        self.navigationBar.translucent = false
        setupView()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    private func setupView() {
        if let locality = weather.locality, summaryText = weather.summary, summaryIcon = weather.summaryIcon, temperatureText = weather.temperature, apparentTemperatureText = weather.apparentTemperature, windSpeedText = weather.windSpeed, windBearingText = weather.windBearing {
            self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
            self.navBarTitle.title = "Currently in \(locality)"

            self.summaryLabel.text = summaryText
            self.summaryIcon.image = UIImage(named: summaryIcon)

            self.temperatureLabel.attributedText = self.setupTemperatureText(temperatureText)
            self.apparentTemperatureLabel.text = "Feels like \(apparentTemperatureText)\u{00B0}"

            self.windSpeedLabel.text = "\(windSpeedText)"
            self.windBearingLabel.text = windBearingText
        }
    }
    
    private func setupTemperatureText(temperature: Int) -> NSMutableAttributedString {
        let attribute1 = [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 42.0)! ]
        let string = NSMutableAttributedString(string: "\(temperature)\u{00B0}", attributes: attribute1)
        let attribute2 = [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 14.0)! ]
        let string2 = NSMutableAttributedString(string: "F", attributes: attribute2)
        string.appendAttributedString(string2)
        return string
    }
}
