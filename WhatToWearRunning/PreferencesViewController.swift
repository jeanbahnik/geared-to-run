//
//  PreferencesViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/6/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

let kTCAppReviewLink = NSURL(string: "itms-apps://itunes.apple.com/app/id1075193930")

class PreferencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private enum TableSection: Int {
        case Communication, Gender, Sections

        static func numberOfSections() -> Int {
            return TableSection.Sections.rawValue
        }
    }
    
    private enum GenderRows: Int {
        case Female, Male, Rows
        
        static func numberOfRow() -> Int {
            return GenderRows.Rows.rawValue
        }
    }

    let preferences = NSUserDefaults.standardUserDefaults()
    var preferencesUpdatedBlock: (Void -> Void)?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        navigationItem.setHidesBackButton(true, animated: false)

        let barButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneButtonPressed")
        barButtonItem.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = barButtonItem

        navigationController?.navigationItem.leftBarButtonItem?.title = "Done"

        tableView.backgroundColor = Style.navyBlueColor
        tableView.separatorStyle = .None

        title = "Preferences"
    }

    func doneButtonPressed() {
        if let preferencesUpdatedBlock = preferencesUpdatedBlock {
            preferencesUpdatedBlock()
        }
        navigationController?.popViewControllerAnimated(true)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableSection.numberOfSections()
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).textColor = UIColor.whiteColor()

        switch TableSection(rawValue: section)! {
        case .Communication:
            return ""
        case .Gender:
            return "Gender preference"
        case .Sections:
            return ""
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case .Communication:
            return 1
        case .Gender:
            return GenderRows.numberOfRow()
        case .Sections:
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        switch TableSection(rawValue: indexPath.section)! {
        case .Communication:
            cell.textLabel?.text = "Rate us in the App Store"

        case .Gender:
            switch GenderRows(rawValue: indexPath.row)! {
            case .Female:
                cell.textLabel?.text = "Female"
                if preferences.boolForKey("prefersFemale") == true { cell.accessoryType = .Checkmark }
            case .Male:
                cell.textLabel?.text = "Male"
                if preferences.boolForKey("prefersFemale") == false { cell.accessoryType = .Checkmark }
            case .Rows: break
            }

        case .Sections:
            return cell
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        switch TableSection(rawValue: indexPath.section)! {
        case .Communication:
            UIApplication.sharedApplication().openURL(kTCAppReviewLink!)

        case .Gender:
            switch GenderRows(rawValue: indexPath.row)! {
            case .Female:
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: TableSection.Gender.rawValue))!.accessoryType = .None
                preferences.setBool(true, forKey: "prefersFemale")
            case .Male:
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: TableSection.Gender.rawValue))!.accessoryType = .None
                preferences.setBool(false, forKey: "prefersFemale")
            case .Rows: break
            }
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark

        case .Sections: break
        }
    }
}
