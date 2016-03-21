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
    var itemCreatedOrUpdatedBlock: (Void -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationItem.leftBarButtonItem?.title = "Done"

        tableView.backgroundColor = Style.navyBlueColor
        tableView.separatorStyle = .None

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButtonTapped")
        barButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = barButtonItem

        if let item = item {
            selectedSlot = NSIndexPath(forRow: Int(item.slot), inSection: TableSection.Slots.rawValue)
            title = item.name
            itemNameTextField.text = item.name
        } else {
            title = "New Item"
        }
    }

    func saveButtonTapped() {
        if let selectedSlot = selectedSlot, name =  itemNameTextField.text where name > "" {
            if item == nil {
                GearItem.saveNewItem(name, slot: Int16(selectedSlot.row), completion: { [weak self] item in
                    if item != nil {
                        self?.navigationController?.popViewControllerAnimated(true)
                        if let itemCreatedOrUpdatedBlock = self?.itemCreatedOrUpdatedBlock { itemCreatedOrUpdatedBlock() }
                    }
                })
            } else if let item = item {
                GearItem.updateItem(name, slot: Int16(selectedSlot.row), item: item, completion: { [weak self] item in
                    self?.navigationController?.popViewControllerAnimated(true)
                    if let itemCreatedOrUpdatedBlock = self?.itemCreatedOrUpdatedBlock { itemCreatedOrUpdatedBlock() }
                })
            }

        } else {
            SVProgressHUD.showErrorWithStatus("Name or Slot can't be blank")
        }
    }

    // MARK: - TableView

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return item != nil ? TableSection.numberOfSections() : TableSection.numberOfSections() - 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case .Slots:
            return GearSlot.Count.rawValue
        case .Constraints:
            if let item = item {
                let gearConstraints = Array(item.constraints!) as! [GearConstraint]
                return gearConstraints.count
            }
            else {
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
            return cell
        case .Constraints:
            if item != nil {
                let cell = tableView.dequeueReusableCellWithIdentifier("ConstraintCell", forIndexPath: indexPath)
                cell.textLabel?.text = constraintText(indexPath.row)
                cell.userInteractionEnabled = true
                cell.accessoryType = .DisclosureIndicator
                return cell
            }
        case .Actions:
            let cell = tableView.dequeueReusableCellWithIdentifier("ActionCell", forIndexPath: indexPath)
            switch ActionsRows(rawValue: indexPath.row)! {
            case .Delete:
                cell.textLabel?.text = "Delete item and constraints"
            case .Rows: break
            }
            return cell
        case .Sections: break
        }

        return UITableViewCell()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if indexPath.section == TableSection.Slots.rawValue {
    //        tableView.becomeFirstResponder()

            if let selectedSlot = selectedSlot {
                tableView.cellForRowAtIndexPath(selectedSlot)!.accessoryType = .None
            }
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark
            
            selectedSlot = indexPath
        } else if indexPath.section == TableSection.Constraints.rawValue {
            if let item = item {
                let gearConstraint = (Array(item.constraints!) as! [GearConstraint])[indexPath.row]
                performSegueWithIdentifier("ConstraintDetail", sender: gearConstraint)
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if (segue.identifier == "ConstraintDetail") {
            let vc = segue.destinationViewController as! ConstraintDetailsViewController
            vc.constraint = sender as? GearConstraint
//            vc.itemCreatedOrUpdatedBlock = { [weak self] in
//                self?.gearList = GearList.sharedInstance.getGearItems()!
//                self?.tableView.reloadData()
//            }
        }
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
