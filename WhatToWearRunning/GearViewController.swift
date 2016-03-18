//
//  GearViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class GearViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var gearList: [GearItem] = GearList.sharedInstance.getGearItems()!

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addButtonPressed")
        self.navigationItem.rightBarButtonItem = barButtonItem

        tableView.backgroundColor = Style.navyBlueColor
        tableView.separatorStyle = .None

        self.title = "Your gear"
    }
    
    func addButtonPressed() {
        performSegueWithIdentifier("ItemDetails", sender: nil)
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

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ItemDetails", sender: gearList[indexPath.row])
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if (segue.identifier == "ItemDetails") {
            let vc = segue.destinationViewController as! ItemDetailsViewController
            vc.item = sender as? GearItem
        }
    }
}
