//
//  ItemDetailsViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import SVProgressHUD

class ItemDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private enum TableSection: Int {
        case Slots, Constraints, Actions, Sections

        static func numberOfSections() -> Int {
            return TableSection.Sections.rawValue
        }
    }

    private enum ActionsRows: Int {
        case Delete, Rows

        static func numberOfRows() -> Int {
            return ActionsRows.Rows.rawValue
        }
    }

    @IBOutlet weak var tableView: UITableView!
    var item: GearItem?
    @IBOutlet weak var itemNameTextField: UITextField!
    var selectedSlot: NSIndexPath?
    var itemCreatedBlock: (Void -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationItem.leftBarButtonItem?.title = "Done"

        tableView.backgroundColor = Style.navyBlueColor
        tableView.separatorStyle = .None

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButtonPressed")
        barButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = barButtonItem

        if let item = item {
            title = item.name
            itemNameTextField.text = item.name
        } else {
            title = "New Item"
        }
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

    // MARK: - TableView

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableSection.numberOfSections()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case .Slots:
            return GearSlot.Count.rawValue
        case .Constraints:
            if let item = item {
                let gearConstraints = Array(item.constraints!) as! [GearConstraint]
                return gearConstraints.count
            } else {
                return 0
            }
        case .Actions:
            return ActionsRows.numberOfRows()
        case .Sections:
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch TableSection(rawValue: indexPath.section)! {
        case .Slots:
            let cell = tableView.dequeueReusableCellWithIdentifier("GearSlotCell", forIndexPath: indexPath)
            cell.textLabel?.text = GearSlot(rawValue: indexPath.row)?.description
            if let item = item {
                if Int(item.slot) == indexPath.row { cell.accessoryType = .Checkmark }
            }
        case .Constraints:
            if item != nil {
                let cell = tableView.dequeueReusableCellWithIdentifier("ConstraintCell", forIndexPath: indexPath)
                cell.textLabel?.text = constraintText(indexPath.row)
            }
        case .Actions:
            let cell = tableView.dequeueReusableCellWithIdentifier("ActionCell", forIndexPath: indexPath)
            switch ActionsRows(rawValue: indexPath.row)! {
            case .Delete:
                cell.textLabel?.text = "Delete item and constraints"
            case .Rows: break
            }
        case .Sections: break
        }

        let cell = tableView.dequeueReusableCellWithIdentifier("GearSlotCell", forIndexPath: indexPath)
        return cell
    }

    func constraintText(indexPath: Int) -> String {
        var constraintText = ""
        if let item = item {
            let gearConstraint = (Array(item.constraints!) as! [GearConstraint])[indexPath]
            let minWind = gearConstraint.minWind, maxWind = gearConstraint.maxWind, minTemp = gearConstraint.minTemp, maxTemp = gearConstraint.maxTemp, minRain = gearConstraint.minRain, maxRain = gearConstraint.maxRain
            constraintText = "minWind: \(minWind), maxWind: \(maxWind), minTemp: \(minTemp), maxTemp: \(maxTemp), minRain: \(minRain), maxRain: \(maxRain)"
        }
        return constraintText
    }
}
