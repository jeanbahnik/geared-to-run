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
    
    enum TableSection: Int {
        case Weather, GearList, Sections
        
        static func numberOfSections() -> Int {
            return TableSection.Sections.rawValue
        }
    }

    var outfit: Recommendation?
    var weather: Weather?
    var refreshControl: UIRefreshControl!
    var pullToRefreshView: UIView!
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = UIColor.clearColor()
        refreshControl.tintColor = UIColor.clearColor()
        tableView.addSubview(refreshControl)
        
        loadCustomRefreshContents("")
        setupView()
    }
    
    func loadCustomRefreshContents(text: String) {
        if refreshControl.subviews.count > 0 {
            refreshControl.subviews.first?.removeFromSuperview()
        }
        let refreshContents = NSBundle.mainBundle().loadNibNamed("PullToRefreshView", owner: self, options: nil)
        let customView = refreshContents.first as! PullToRefreshView
        customView.frame = refreshControl.bounds
        customView.updatedAtLabel.text = text

        refreshControl.addTarget(self, action: "fetchData", forControlEvents: UIControlEvents.ValueChanged)
        refreshControl.addSubview(customView)
    }
    
    // MARK: UIScrollView delegate method implementation
    

    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        if handleRefresh() == true {
            loadCustomRefreshContents("Updating...")
        } else {
            loadCustomRefreshContents("Upgrade to Pro to update more than once an hour.")
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if refreshControl.refreshing { refreshControl.endRefreshing() }
    }
    
    private func setupView() {
        navigationItem.setHidesBackButton(true, animated: false)

//        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "promptForZipcode")
//        barButtonItem.tag = 1
//        self.navigationItem.rightBarButtonItem = barButtonItem

        navigationController?.navigationBarHidden = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.barTintColor = Style.maroonColor
        navigationController?.navigationBar.barStyle = UIBarStyle.Black

        tableView.backgroundColor = Style.navyBlueColor
        tableView.alwaysBounceVertical = true

        tableView.registerNib(UINib(nibName: "WeatherTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "WeatherTableViewCell")
        tableView.registerNib(UINib(nibName: "GearListTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "GearListTableViewCell")

        if let weather = weather, locality = weather.locality {
            title = "Currently in \(locality)"
        }
    }

    // TableView

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableSection.numberOfSections()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case .Weather:
            return 1
        case .GearList:
            return GearSlot.Count.rawValue
        case .Sections:
            return 0
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 94.0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch TableSection(rawValue: indexPath.section)! {
        case .Weather:
            let cell = tableView.dequeueReusableCellWithIdentifier("WeatherTableViewCell", forIndexPath: indexPath) as! WeatherTableViewCell
            
            cell.userInteractionEnabled = false

            if let weather = weather, summaryText = weather.summary, summaryIcon = weather.summaryIcon, temperatureText = weather.temperature, apparentTemperatureText = weather.apparentTemperature, windSpeedText = weather.windSpeed, windBearingText = weather.windBearing {

                cell.summaryLabel.text = summaryText
                cell.summaryIcon.image = UIImage(named: summaryIcon)

                cell.temperatureLabel.attributedText = self.setupTemperatureText(temperatureText)
                cell.apparentTemperatureLabel.text = "Feels like \(apparentTemperatureText)\u{00B0}"

                cell.windSpeedLabel.text = "\(windSpeedText)"
                cell.windBearingLabel.text = windBearingText
            }
            return cell
        case .GearList:
            let cell = tableView.dequeueReusableCellWithIdentifier("GearListTableViewCell", forIndexPath: indexPath) as! GearListTableViewCell
            cell.userInteractionEnabled = false
            cell.backgroundColor = UIColor.clearColor()

            switch GearSlot(rawValue: indexPath.row)! {
            case .Head:
                cell.gearLabel.text = "TEXT1"
            case .Torso:
                cell.gearLabel.text = "TEXT1"
            case .Legs:
                cell.gearLabel.text = "TEXT3"
            case .Feet:
                cell.gearLabel.text = "TEXT4"
            case .Accessories:
                cell.gearLabel.text = "TEsadf"
            default: cell.gearLabel.text = nil
            }
            return cell
        default: return UITableViewCell()
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
    
    func handleRefresh() -> Bool {
        if let weather = weather, updateAtDate = weather.updatedAtDate {
            let elapsedTime = -Int(updateAtDate.timeIntervalSinceNow)
            if elapsedTime > 3600 { return true }
        }
        return false
    }
    
    func fetchData() {
        if handleRefresh() == true {
            LocationManager.sharedInstance.getLocation()
            LocationManager.sharedInstance.locationUpdatedBlock = {
                [weak self] location in
                if let location = location {
                    if Reachability.isConnectedToNetwork() == false {
    //                    returns to previous screen and display an error message
    //                    displayError("Connect Internet and Try Again")
                    } else {
                        LocationManager.sharedInstance.stopUpdatingLocation()
                        SVProgressHUD.show()
                        Weather().getWeatherData(location) { ( weather : Weather? ) in
                            if let weather = weather {
                                self?.weather = weather
                                Recommendation().getRecommendedOutfit(weather, completion: { (recommendation : Recommendation?) -> Void in
                                    if let recommendation = recommendation {
                                        self?.outfit = recommendation
                                        SVProgressHUD.dismiss()
                                        self?.tableView.reloadData()
                                    }
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}
