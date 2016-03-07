//
//  PreferencesViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/6/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class PreferencesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private enum TableSection: Int {
        case Gender, Sections

        static func numberOfSections() -> Int {
            return TableSection.Sections.rawValue
        }
    }

    let preferences = NSUserDefaults.standardUserDefaults()

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
        navigationController?.popViewControllerAnimated(true)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableSection.numberOfSections()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case .Gender:
            return 2
        case .Sections:
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        switch TableSection(rawValue: indexPath.section)! {
        case .Gender:
            if indexPath.row == 0 {
                cell.textLabel?.text = "Female"
                if preferences.boolForKey("prefersFemale") == true { cell.accessoryType = .Checkmark }
            } else {
                cell.textLabel?.text = "Male"
                if preferences.boolForKey("prefersFemale") == false { cell.accessoryType = .Checkmark }
            }
        case .Sections:
            return cell
        }
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == TableSection.Gender.rawValue {
            if indexPath.row == 0 {
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 1, inSection: TableSection.Gender.rawValue))!.accessoryType = .None
                preferences.setBool(true, forKey: "prefersFemale")
            } else if indexPath.row == 1 {
                tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: TableSection.Gender.rawValue))!.accessoryType = .None
                preferences.setBool(false, forKey: "prefersFemale")
            }
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        }
    }
}
