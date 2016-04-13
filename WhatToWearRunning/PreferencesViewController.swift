//
//  PreferencesViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/6/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import MessageUI

let kTCAppReviewLink = NSURL(string: "itms-apps://itunes.apple.com/app/id1075193930")

class PreferencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    private enum TableSection: Int {
        case Communication, Gender, Gear, Sections

        static func numberOfSections() -> Int {
            return TableSection.Sections.rawValue
        }
    }
    
    private enum CommunicationRows: Int {
        case Rate, SendFeedback, Rows
        
        static func numberOfRows() -> Int {
            return CommunicationRows.Rows.rawValue
        }
    }

    private enum GenderRows: Int {
        case Female, Male, Rows
        
        static func numberOfRows() -> Int {
            return GenderRows.Rows.rawValue
        }
    }

    var preferencesUpdatedBlock: (Void -> Void)?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    func setupView() {
        navigationItem.setHidesBackButton(true, animated: false)

        let barButtonItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: #selector(PreferencesViewController.doneButtonPressed))
        barButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = barButtonItem

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
        UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).textColor = Style.aquaColor

        switch TableSection(rawValue: section)! {
        case .Communication, .Gear:
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
            return CommunicationRows.numberOfRows()
        case .Gender:
            return GenderRows.numberOfRows()
        case .Gear:
            return 1
        case .Sections:
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.backgroundColor = Style.navyBlueColor
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.tintColor = UIColor.whiteColor()

        switch TableSection(rawValue: indexPath.section)! {
        case .Communication:
            cell.accessoryType = .DisclosureIndicator
            switch CommunicationRows(rawValue: indexPath.row)! {
            case .Rate:
                cell.textLabel?.text = "Rate us in the App Store"
            case .SendFeedback:
                cell.textLabel?.text = "Report a bug/Send Feedback"
            case .Rows: break
            }


        case .Gender:
            cell.tintColor = UIColor.whiteColor()
            switch GenderRows(rawValue: indexPath.row)! {
            case .Female:
                cell.textLabel?.text = "Female"
                if User.sharedInstance.prefersFemale() { cell.accessoryType = .Checkmark }
            case .Male:
                cell.textLabel?.text = "Male"
                if !User.sharedInstance.prefersFemale() { cell.accessoryType = .Checkmark }
            case .Rows: break
            }
            
        case .Gear:
            cell.accessoryType = .DisclosureIndicator
            cell.textLabel?.text = "My gear"

        case .Sections: break
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        switch TableSection(rawValue: indexPath.section)! {
        case .Communication:
            switch CommunicationRows(rawValue: indexPath.row)! {
            case .Rate:
                UIApplication.sharedApplication().openURL(kTCAppReviewLink!)
            case .SendFeedback:
                Instabug.invoke()
            case .Rows: break
            }

        case .Gender:
            switch GenderRows(rawValue: indexPath.row)! {
            case .Female:
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: TableSection.Gender.rawValue))!.accessoryType = .None
                User.sharedInstance.setGenderPreference(true)
            case .Male:
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: TableSection.Gender.rawValue))!.accessoryType = .None
                User.sharedInstance.setGenderPreference(false)
            case .Rows: break
            }
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
            
        case .Gear:
            performSegueWithIdentifier("Gear", sender: nil)

        case .Sections: break
        }
    }

    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["support@beebuzz.com"])
            mail.setMessageBody("<p>Feedback for What To Wear: Running</p>", isHTML: true)

            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
