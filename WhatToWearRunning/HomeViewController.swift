//
//  HomeViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import SVProgressHUD
import GoogleMobileAds

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private enum TableSection: Int {
        case Weather, PageControl, Runner, Quote, BannerAd, Sections
        
        static func numberOfSections() -> Int {
            return TableSection.Sections.rawValue
        }
    }

    var outfit: [[GearItem]]?
    var weather: [HourlyWeather]?
    var refreshControl: UIRefreshControl!
    var pullToRefreshView: UIView!
    var collectionViewItem = 0
    
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

        refreshControl.addTarget(self, action: #selector(HomeViewController.fetchData), forControlEvents: UIControlEvents.ValueChanged)
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

        if scrollView.isKindOfClass(UICollectionView) {
            let indexSet = NSIndexSet(indexesInRange: NSMakeRange(1, 2))
            if Float(scrollView.bounds.width) * Float(collectionViewItem) > Float(scrollView.contentOffset.x) {
                if collectionViewItem > 0 {
                    collectionViewItem -= 1
                    tableView.reloadSections(indexSet, withRowAnimation: .None)
                }
            } else if Float(scrollView.bounds.width) * Float(collectionViewItem) < Float(scrollView.contentOffset.x) {
                if collectionViewItem < kHourlyWeatherCount - 1 {
                    collectionViewItem += 1
                    tableView.reloadSections(indexSet, withRowAnimation: .None)
                }
            }
        }
    }

    private func setupView() {
        navigationItem.setHidesBackButton(true, animated: false)

        let barButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), style: .Plain, target: self, action: #selector(HomeViewController.segueToPreferences))
        barButtonItem.tintColor = UIColor.whiteColor()
        self.navigationItem.rightBarButtonItem = barButtonItem

        navigationController?.navigationBarHidden = false
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.barTintColor = Style.maroonColor
        navigationController?.navigationBar.barStyle = UIBarStyle.Black

        tableView.backgroundColor = Style.navyBlueColor
        tableView.alwaysBounceVertical = true

        tableView.registerNib(UINib(nibName: "PageControlTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "PageControlTableViewCell")
        tableView.registerNib(UINib(nibName: "QuoteTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "QuoteTableViewCell")
        tableView.registerNib(UINib(nibName: "AdmobTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "AdmobTableViewCell")

        // Can call first on this one since locality is the same for all HourlyWeather objects
        if let weather = weather?.first, locality = weather.locality {
            title = "Currently in \(locality)"
        }
    }

    // MARK: - TableView

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableSection.numberOfSections()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case .Weather, .PageControl, .Quote, .BannerAd, .Runner: return 1
        case .Sections: return 0
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch TableSection(rawValue: indexPath.section)! {
        case .Weather: return 115.0
        case .PageControl: return 37.0
        case .Runner: return 322.0
        case .Quote: return 60.0
        case .BannerAd: return 280.0
        case .Sections: return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch TableSection(rawValue: indexPath.section)! {
        case .Weather:
            let cell = tableView.dequeueReusableCellWithIdentifier("WeatherTableViewCell", forIndexPath: indexPath) as! WeatherTableViewCell
            return cell

        case .PageControl:
            let cell = tableView.dequeueReusableCellWithIdentifier("PageControlTableViewCell", forIndexPath: indexPath) as! PageControlTableViewCell

            cell.pageControl.numberOfPages = kHourlyWeatherCount
            cell.pageControl.currentPage = collectionViewItem
            return cell

        case .Runner:
            let cell = tableView.dequeueReusableCellWithIdentifier("RunnerTableViewCell", forIndexPath: indexPath) as! RunnerTableViewCell

            if NSUserDefaults.standardUserDefaults().boolForKey("prefersFemale") == true {
                cell.runnerImageView.image = UIImage(named: "runner-w")
            } else {
                cell.runnerImageView.image = UIImage(named: "runner-m")
            }
            cell.outfit = outfit?[collectionViewItem]
            cell.reloadView()
            return cell

        case .Quote:
            let cell = tableView.dequeueReusableCellWithIdentifier("QuoteTableViewCell", forIndexPath: indexPath) as! QuoteTableViewCell

            cell.quoteLabel.attributedText = Quote.sharedInstance.randomQuote()

            return cell

        case .BannerAd:
            let cell = tableView.dequeueReusableCellWithIdentifier("AdmobTableViewCell", forIndexPath: indexPath) as! AdmobTableViewCell

            cell.bannerView.adUnitID = "ca-app-pub-8751298084412936/7088781805"
            cell.bannerView.rootViewController = self
            cell.bannerView.adSize = kGADAdSizeMediumRectangle
            cell.bannerView.loadRequest(setupBannerAdRequest())

            return cell

        default: return UITableViewCell()
        }
    }

    func setupBannerAdRequest() -> GADRequest {
        let request = GADRequest()
        if NSUserDefaults.standardUserDefaults().boolForKey("prefersFemale") == true {
            request.gender = .Male
        } else {
            request.gender = .Female
        }
        LocationManager.sharedInstance.getLocation()
        LocationManager.sharedInstance.locationUpdatedBlock = { location in
            LocationManager.sharedInstance.stopUpdatingLocation()
            if let currentLocation = location {
                request.setLocationWithLatitude(CGFloat(currentLocation.coordinate.latitude),
                                                longitude: CGFloat(currentLocation.coordinate.longitude),
                                                accuracy: CGFloat(currentLocation.horizontalAccuracy))
            }
        }
        request.testDevices = [kGADSimulatorID, "baa701bcf71eaf89dd9f1255c0435d7d"]

        return request
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == TableSection.Weather.rawValue {
            guard let tableViewCell = cell as? WeatherTableViewCell else { return }

            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
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
            LocationManager.sharedInstance.locationUpdatedBlock = { [weak self] location in
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
                                Recommendation().getRecommendedOutfit(weather, completion: { recommendation in
                                    self?.outfit = recommendation
                                    SVProgressHUD.dismiss()
                                    self?.tableView.reloadData()
                                })
                            }
                        }
                    }
                }
            }
        }
    }
    
    func segueToPreferences() {
        performSegueWithIdentifier("Preferences", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if (segue.identifier == "Preferences") {
            let vc = segue.destinationViewController as! PreferencesViewController
            vc.preferencesUpdatedBlock = { Void in
                self.tableView.reloadData()
            }
        }
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kHourlyWeatherCount
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WeatherCollectionViewCell", forIndexPath: indexPath) as! WeatherCollectionViewCell

        cell.userInteractionEnabled = false
        cell.tag = indexPath.row

        if let weather = weather?[indexPath.row], summaryText = weather.summary, summaryIcon = weather.summaryIcon, temperatureText = weather.temperature, apparentTemperatureText = weather.apparentTemperature, windSpeedText = weather.windSpeed, windBearingText = weather.windBearing, weatherTime = weather.weatherTime {

            let formattedTime = self.formatTime(weatherTime)
            cell.weatherTimeLabel.text = "Weather at \(formattedTime)"

            cell.summaryLabel.text = summaryText
            cell.summaryIcon.image = UIImage(named: summaryIcon)

            cell.temperatureLabel.attributedText = self.setupTemperatureText(temperatureText)
            cell.apparentTemperatureLabel.text = "Feels like \(apparentTemperatureText)\u{00B0}"

            cell.windSpeedLabel.text = "\(windSpeedText)"
            cell.windBearingLabel.text = windBearingText
        }

        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return collectionView.bounds.size
    }

    func formatTime(date: NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.stringFromDate(date)
    }
}
