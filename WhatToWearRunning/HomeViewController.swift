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
        case Weather, GearIcon, GearList, Sections
        
        static func numberOfSections() -> Int {
            return TableSection.Sections.rawValue
        }
    }

    var outfit: Recommendation?
    var weather: [HourlyWeather]?
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

        // Can call first on this one since locality is the same for all HourlyWeather objects
        if let weather = weather?.first, locality = weather.locality {
            title = "Currently in \(locality)"
        }
    }

    // TableView

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableSection.numberOfSections()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case .Weather, .GearIcon:
            return 1
        case .GearList:
            return GearSlot.Count.rawValue
        case .Sections:
            return 0
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch TableSection(rawValue: indexPath.section)! {
        case .Weather:
            return 94.0
        case .GearIcon:
            return self.view.frame.width
        case .GearList:
            return 30.0
        case .Sections:
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch TableSection(rawValue: indexPath.section)! {
        case .Weather:
            let cell = tableView.dequeueReusableCellWithIdentifier("WeatherTableViewCell", forIndexPath: indexPath) as! WeatherTableViewCell
            
            cell.userInteractionEnabled = false

            if let weather = weather?[indexPath.row], summaryText = weather.summary, summaryIcon = weather.summaryIcon, temperatureText = weather.temperature, apparentTemperatureText = weather.apparentTemperature, windSpeedText = weather.windSpeed, windBearingText = weather.windBearing {

                cell.summaryLabel.text = summaryText
                cell.summaryIcon.image = UIImage(named: summaryIcon)

                cell.temperatureLabel.attributedText = self.setupTemperatureText(temperatureText)
                cell.apparentTemperatureLabel.text = "Feels like \(apparentTemperatureText)\u{00B0}"

                cell.windSpeedLabel.text = "\(windSpeedText)"
                cell.windBearingLabel.text = windBearingText
            }
            return cell
        case .GearIcon:
            let cell = UITableViewCell()
            cell.userInteractionEnabled = false
            let catView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width))
            let icon = UIImage(named: "runner")
            let imageView = UIImageView(image: icon)
            imageView.contentMode = .Center
            imageView.frame = catView.bounds
            catView.addSubview(imageView)
            cell.addSubview(catView)
            cell.backgroundColor = UIColor.clearColor()
            return cell
        case .GearList:
            let cell = tableView.dequeueReusableCellWithIdentifier("GearListTableViewCell", forIndexPath: indexPath) as! GearListTableViewCell
            cell.userInteractionEnabled = false
            cell.backgroundColor = UIColor.clearColor()

            switch GearSlot(rawValue: indexPath.row)! {
            case .Head:
                cell.gearLabel.text = gearListForSlot(.Head)
            case .Torso:
                cell.gearLabel.text = gearListForSlot(.Torso)
            case .Legs:
                cell.gearLabel.text = gearListForSlot(.Legs)
            case .Feet:
                cell.gearLabel.text = gearListForSlot(.Feet)
            case .Accessories:
                cell.gearLabel.text = gearListForSlot(.Accessories)
            default: cell.gearLabel.text = nil
            }
            return cell
        default: return UITableViewCell()
        }
    }
    
    func gearListForSlot(slot: GearSlot) -> String {
        var text = ""
        var itemCount = 0
        if let outfit = outfit {
            for item in outfit.recommendedOutfit {
                if item.slot == slot {
                    itemCount++
                    text += "\(item.description), "
                }
            }
        }

        if itemCount == 0 {
            text = "-"
        } else {
            text = text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(0), end: text.endIndex.advancedBy(-2)))
        }

        return text
    }

    private func setupTemperatureText(temperature: Int) -> NSMutableAttributedString {
        let attribute1 = [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 42.0)! ]
        let string = NSMutableAttributedString(string: "\(temperature)\u{00B0}", attributes: attribute1)
        let attribute2 = [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 14.0)! ]
        let string2 = NSMutableAttributedString(string: "F", attributes: attribute2)
        string.appendAttributedString(string2)
        return string
    }

//    func promptForZipcode() {
//        var inputTextField: UITextField?
//        let alert : UIAlertController = UIAlertController(title: "Please enter a US Zipcode", message: nil, preferredStyle: .Alert)
//        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
//        alert.addTextFieldWithConfigurationHandler { textField in
//            textField.keyboardType = UIKeyboardType.NumberPad
//            inputTextField = textField
//        }
//        alert.addAction(UIAlertAction(title: "Enter", style: .Default, handler: { alertAction in
//            if let inputTextField = inputTextField, zipcodeText = inputTextField.text where zipcodeText.characters.count == 5, let zipcode = Int(zipcodeText) {
//                self.resetWeatherAndRecommendation(zipcode)
//            }
//        }))
//        self.presentViewController(alert, animated: true, completion: nil)
//    }

//    func resetWeatherAndRecommendation(zipcode: Int) {
//        SVProgressHUD.show()
//        Weather().getGeolocationFromZipcode(zipcode) { (weather, error) -> Void in
//            if let error = error {
//                SVProgressHUD.dismiss()
//                print(error)
//            }
//            if let weather = weather {
//                self.weather = weather
//                Recommendation().getRecommendedOutfit(weather, completion: { (recommendation) -> Void in
//                    self.outfit = recommendation
//                    SVProgressHUD.dismiss()
//                    self.setupView()
//                })
//            }
//        }
//    }
    
    func handleRefresh() -> Bool {
        // Can call first on weather since all weather objects share the same UpdatedAtDate
        if let weather = weather?.first, updatedAtDate = weather.updatedAtDate {
            let elapsedTime = -Int(updatedAtDate.timeIntervalSinceNow)
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
                        Weather().getWeatherData(location) { ( weather : [HourlyWeather]? ) in
                            if let weather = weather {
                                self?.weather = weather
                                Recommendation().getRecommendedOutfit(weather[0], completion: { (recommendation : Recommendation?) -> Void in
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
