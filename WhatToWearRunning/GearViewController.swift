//
//  GearViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class GearViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var gearList = GearList.sharedInstance.getGearItems()!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gearList.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GearCell", forIndexPath: indexPath)

        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.text = gearList[indexPath.row].name

        return cell
    }
}
