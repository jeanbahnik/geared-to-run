//
//  PreferencesViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/6/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import MessageUI

let kTCAppReviewLink = NSURL(string: "itms-apps://itunes.apple.com/app/id1075193930")
let kTCAppStoreUrl = "https://itunes.apple.com/us/app/geared-to-run/id1075193930"

class PreferencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    private enum TableSection: Int {
        case Communication, Pro, Gender, Gear, Who, Sections

        static func numberOfSections() -> Int {
            return TableSection.Sections.rawValue
        }
    }

    private enum CommunicationRows: Int {
        case Rate, SendFeedback, TellFriend, Rows

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

    private enum WhoRows: Int {
        case Jean, Brian, Rows

        static func numberOfRows() -> Int {
            return WhoRows.Rows.rawValue
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
        if let preferencesUpdatedBlock = preferencesUpdatedBlock { preferencesUpdatedBlock() }
        navigationController?.popViewControllerAnimated(true)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableSection.numberOfSections()
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch TableSection(rawValue: section)! {
        case .Communication, .Who, .Gender:
            return 30.0
        case .Gear:
            if User.sharedInstance.isPro() {
                return 30.0
            } else {
                return 0.1
            }
        case .Sections, .Pro:
            return 0.1
        }
    }

    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).textColor = Style.aquaColor

        switch TableSection(rawValue: section)! {
        case .Communication, .Pro:
            return ""
        case .Gear:
            // TODO: change it to insert/delete sections instead of hack
            // just return "Customize your gear" to see
            if User.sharedInstance.isPro() {
                return "Customize your gear"
            } else {
                return ""
            }
        case .Gender:
            return "Icon preference"
        case .Who:
            return "Who made this"
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
        case .Who:
            return WhoRows.numberOfRows()
        case .Gear:
            if User.sharedInstance.isPro() {
                return 1
            } else {
                return 0
            }
        case .Pro:
            if User.sharedInstance.isPro() {
                return 0
            } else {
                return 1
            }
        default: return 0
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
                return cell
            case .SendFeedback:
                cell.textLabel?.text = "Report a bug/Send Feedback"
                return cell
            case .TellFriend:
                cell.textLabel?.text = "Tell a friend about this app"
                return cell
            case .Rows: break
            }

        case .Gender:
            cell.tintColor = UIColor.whiteColor()
            switch GenderRows(rawValue: indexPath.row)! {
            case .Female:
                cell.textLabel?.text = "Female"
                if User.sharedInstance.prefersFemale() { cell.accessoryType = .Checkmark }
                return cell
            case .Male:
                cell.textLabel?.text = "Male"
                if !User.sharedInstance.prefersFemale() { cell.accessoryType = .Checkmark }
                return cell
            case .Rows: break
            }

        case .Pro:
            if !User.sharedInstance.isPro() {
                let attribute1 = [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 15.0)! ]
                let text = NSMutableAttributedString(string: "Go Pro to customize your gear, and more!", attributes: attribute1)
                cell.userInteractionEnabled = true
                cell.textLabel?.attributedText = text
                cell.textLabel?.textAlignment = .Center
                cell.backgroundColor = Style.maroonColor
                return cell
            } else {
                break
            }

        case .Who:
            switch WhoRows(rawValue: indexPath.row)! {
            case .Jean:
                cell.textLabel?.text = "Jean Bahnik"
                return cell
            case .Brian:
                cell.textLabel?.text = "Brian Drum"
                return cell
            case .Rows: break
            }

        case .Gear:
            cell.userInteractionEnabled = false
            if User.sharedInstance.isPro() {
                cell.userInteractionEnabled = true
                cell.accessoryType = .DisclosureIndicator
                cell.textLabel?.text = "My gear"
                return cell
            } else {
                break
            }

        case .Sections: break
        }

        cell.textLabel?.text = ""
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        switch TableSection(rawValue: indexPath.section)! {
        case .Pro:
            performSegueWithIdentifier("GoPro", sender: nil)

        case .Communication:
            switch CommunicationRows(rawValue: indexPath.row)! {
            case .Rate:
                UIApplication.sharedApplication().openURL(kTCAppReviewLink!)
            case .SendFeedback:
                Instabug.invoke()
            case .TellFriend:
                sendEmail()
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

        case .Who:
            switch WhoRows(rawValue: indexPath.row)! {
            case .Jean:
                UIApplication.sharedApplication().openURL(NSURL(string: "http://jeanbahnik.com")!)
            case .Brian:
                UIApplication.sharedApplication().openURL(NSURL(string: "http://briandrum.net")!)
            case .Rows: break
            }

        case .Gear:
            performSegueWithIdentifier("Gear", sender: nil)

        case .Sections: break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)

        if (segue.identifier == "GoPro") {
            let vc = segue.destinationViewController as! GoProViewController
            vc.isProBlock = { [weak self] Void in
                let indexPathForGear = NSIndexPath(forRow: 0, inSection: TableSection.Gear.rawValue)
                let indexPathForPro = NSIndexPath(forRow: 0, inSection: TableSection.Pro.rawValue)

                self?.tableView.beginUpdates()
                self?.tableView.insertRowsAtIndexPaths([indexPathForGear], withRowAnimation: .Automatic)
                self?.tableView.deleteRowsAtIndexPaths([indexPathForPro], withRowAnimation: .Automatic)
                self?.tableView.endUpdates()
                self?.tableView.reloadData()
            }
        }
    }

    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject("Check out this app: Geared to run")
            mail.setMessageBody("<p>Check out this app: <a href=\"\(kTCAppStoreUrl)\">Geared to Run</a></p>", isHTML: true)

            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}
