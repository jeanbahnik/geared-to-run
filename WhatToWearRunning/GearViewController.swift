//
//  GearViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class GearViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var head = [GearItem]()
    var torso = [GearItem]()
    var legs = [GearItem]()
    var feet = [GearItem]()
    var accessories = [GearItem]()
    var gearList: [GearItem]?

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGearArrays()

        navigationController?.navigationBar.tintColor = UIColor.whiteColor()

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(GearViewController.addButtonPressed))
        self.navigationItem.rightBarButtonItem = barButtonItem

        tableView.backgroundColor = Style.navyBlueColor
        tableView.separatorStyle = .None

        self.title = "Your gear"
    }
    
    func setupGearArrays() {
        gearList = GearList.sharedInstance.getGearItems()!
        
        head = []
        torso = []
        legs = []
        feet = []
        accessories = []

        for item in gearList! {
            if Int(item.slot) == GearSlot.Head.rawValue {
                head.append(item) }
            if Int(item.slot) == GearSlot.Torso.rawValue {
                torso.append(item) }
            if Int(item.slot) == GearSlot.Legs.rawValue {
                legs.append(item) }
            if Int(item.slot) == GearSlot.Feet.rawValue {
                feet.append(item) }
            if Int(item.slot) == GearSlot.Accessories.rawValue {
                accessories.append(item) }
        }
        tableView.reloadData()
    }

    func addButtonPressed() {
        performSegueWithIdentifier("ItemDetails", sender: nil)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return GearSlot.Count.rawValue + 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch GearSlot(rawValue: section)! {
        case .Head: return head.count
        case .Torso: return torso.count
        case .Legs: return legs.count
        case .Feet: return feet.count
        case .Accessories: return accessories.count
        case .Count: return 1
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).textColor = Style.aquaColor
        
        switch GearSlot(rawValue: section)! {
        case .Head: return GearSlot.Head.description
        case .Torso: return GearSlot.Torso.description
        case .Legs: return GearSlot.Legs.description
        case .Feet: return GearSlot.Feet.description
        case .Accessories: return GearSlot.Accessories.description
        case .Count: return ""
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GearCell", forIndexPath: indexPath)
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = Style.navyBlueColor
        cell.tintColor = Style.aquaColor

        switch GearSlot(rawValue: indexPath.section)! {
        case .Head:
            cell.textLabel?.text = head[indexPath.row].name
        case .Torso:
            cell.textLabel?.text = torso[indexPath.row].name
        case .Legs:
            cell.textLabel?.text = legs[indexPath.row].name
        case .Feet:
            cell.textLabel?.text = feet[indexPath.row].name
        case .Accessories:
            cell.textLabel?.text = accessories[indexPath.row].name
        case .Count:
            cell.textLabel?.text = "Delete default gear"
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch GearSlot(rawValue: indexPath.section)! {
        case .Head:
            performSegueWithIdentifier("ItemDetails", sender: head[indexPath.row])
        case .Torso:
            performSegueWithIdentifier("ItemDetails", sender: torso[indexPath.row])
        case .Legs:
            performSegueWithIdentifier("ItemDetails", sender: legs[indexPath.row])
        case .Feet:
            performSegueWithIdentifier("ItemDetails", sender: feet[indexPath.row])
        case .Accessories:
            performSegueWithIdentifier("ItemDetails", sender: accessories[indexPath.row])
        case .Count:
            GearItem.deleteSeedData({ [weak self] in
                self?.setupGearArrays()
                self?.tableView.reloadData()
            })
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if (segue.identifier == "ItemDetails") {
            let vc = segue.destinationViewController as! ItemDetailsViewController
            vc.item = sender as? GearItem
            vc.itemCreatedOrUpdatedBlock = { [weak self] in
                self?.gearList = GearList.sharedInstance.getGearItems()!
                self?.setupGearArrays()
                self?.tableView.reloadData()
            }
        }
    }
}
