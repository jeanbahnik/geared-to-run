//
//  HomeViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var outfit = Recommendation()
    var weather = Weather()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        self.navigationItem.setHidesBackButton(true, animated: false)

//        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "promptForZipcode")
//        barButtonItem.tag = 1
//        self.navigationItem.rightBarButtonItem = barButtonItem

        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = Style.maroonColor
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black

        self.tableView.backgroundColor = Style.navyBlueColor

        if let locality = weather.locality {
            self.title = "Currently in \(locality)"
        }

        tableView.registerNib(UINib(nibName: "WeatherTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "WeatherTableViewCell")
    }



    // TableView

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 94.0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("WeatherTableViewCell", forIndexPath: indexPath) as! WeatherTableViewCell

            if let summaryText = weather.summary, summaryIcon = weather.summaryIcon, temperatureText = weather.temperature, apparentTemperatureText = weather.apparentTemperature, windSpeedText = weather.windSpeed, windBearingText = weather.windBearing {

                cell.summaryLabel.text = summaryText
                cell.summaryIcon.image = UIImage(named: summaryIcon)

                cell.temperatureLabel.attributedText = self.setupTemperatureText(temperatureText)
                cell.apparentTemperatureLabel.text = "Feels like \(apparentTemperatureText)\u{00B0}"

                cell.windSpeedLabel.text = "\(windSpeedText)"
                cell.windBearingLabel.text = windBearingText
            }

            return cell

        } else {
            return UITableViewCell()
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

    func promptForZipcode() {
        var inputTextField: UITextField?
        let alert : UIAlertController = UIAlertController(title: "Please enter a US Zipcode", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alert.addTextFieldWithConfigurationHandler { textField in
            textField.keyboardType = UIKeyboardType.NumberPad
            inputTextField = textField
        }
        alert.addAction(UIAlertAction(title: "Enter", style: .Default, handler: { alertAction in
            if let inputTextField = inputTextField, zipcodeText = inputTextField.text where zipcodeText.characters.count == 5, let zipcode = Int(zipcodeText) {
                self.resetWeatherAndRecommendation(zipcode)
            }
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    func resetWeatherAndRecommendation(zipcode: Int) {
        SVProgressHUD.show()
        Weather().getGeolocationFromZipcode(zipcode) { (weather, error) -> Void in
            if let error = error {
                SVProgressHUD.dismiss()
                print(error)
            }
            if let weather = weather {
                self.weather = weather
                Recommendation().getRecommendedOutfit(weather, completion: { (recommendation) -> Void in
                    self.outfit = recommendation
                    SVProgressHUD.dismiss()
                    self.setupView()
                })
            }
        }
    }
}
