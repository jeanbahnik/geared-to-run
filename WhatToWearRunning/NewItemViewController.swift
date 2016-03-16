//
//  NewItemViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/15/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import SVProgressHUD

class NewItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemNameTextField: UITextField!
    var selectedSlot: NSIndexPath?
    var itemCreatedBlock: (Void -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        navigationController?.navigationItem.leftBarButtonItem?.title = "Cancel"
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "addButtonPressed")
        barButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = barButtonItem

        tableView.backgroundColor = Style.navyBlueColor
        tableView.separatorStyle = .None

        title = "New Item"
    }
    
    func addButtonPressed() {
        if let name =  itemNameTextField.text, selectedSlot = selectedSlot {
            GearItem.saveItem(name, slot: selectedSlot.row)
            navigationController?.popViewControllerAnimated(true)
            if let itemCreatedBlock = itemCreatedBlock {
                itemCreatedBlock()
            }
        } else {
            SVProgressHUD.showErrorWithStatus("Name or Slot can't be blank")
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return GearSlot.Count.rawValue
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).textColor = UIColor.whiteColor()

        return "Gear slot:"
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GearSlotCell", forIndexPath: indexPath)

        cell.textLabel?.text = GearSlot(rawValue: indexPath.row)?.description

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.becomeFirstResponder()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if let selectedSlot = selectedSlot {
            tableView.cellForRowAtIndexPath(selectedSlot)?.accessoryType = .None
        }
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
        
        selectedSlot = indexPath
    }
}
