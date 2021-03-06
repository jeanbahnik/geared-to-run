//
//  ItemDetailsViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import SVProgressHUD
import QuartzCore

class ItemDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private enum TableSection: Int {
        case Constraints, Slots, Actions, Sections

        static func numberOfSections() -> Int {
            return TableSection.Sections.rawValue
        }
    }

    private enum ActionsRows: Int {
        case AddConstraint, Delete, Rows

        static func numberOfRows() -> Int {
            return ActionsRows.Rows.rawValue
        }
    }

    private enum RuleCellLabels: Int {
        case Temperature, Rain, Wind
    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    var item: GearItem?
    var selectedSlot: NSIndexPath?
    var itemCreatedOrUpdatedBlock: (Void -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        // TODO: Does not work
        navigationController?.navigationItem.leftBarButtonItem?.title = "Done"

        view.backgroundColor = Style.navyBlueColor
        tableView.backgroundColor = Style.navyBlueColor
        tableView.separatorStyle = .None

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(ItemDetailsViewController.saveButtonTapped))
        barButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = barButtonItem

        itemNameTextField.backgroundColor = Style.navyBlueColor
        itemNameTextField.tintColor = UIColor.whiteColor()
        itemNameTextField.textColor = UIColor.whiteColor()
        itemNameTextField.layer.borderColor = UIColor.whiteColor().CGColor
        itemNameTextField.layer.borderWidth = 1
        itemNameTextField.layer.masksToBounds = true
        itemNameTextField.layer.cornerRadius = 8

        nameView.backgroundColor = Style.navyBlueColor

        tableView.registerNib(UINib(nibName: "RuleSummaryCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "RuleSummaryCell")

        if let item = item {
            selectedSlot = NSIndexPath(forRow: Int(item.slot), inSection: TableSection.Slots.rawValue)
            title = item.name
            itemNameTextField.text = item.name
        } else {
            title = "New Item"
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        itemNameTextField.resignFirstResponder()
    }

    func saveButtonTapped() {
        if let selectedSlot = selectedSlot, name = itemNameTextField.text where name > "" {
            if let item = item {
                item.updateItem(name, slot: Int16(selectedSlot.row), completion: { [weak self] item in
                    self?.navigationController?.popViewControllerAnimated(true)
                    if let itemCreatedOrUpdatedBlock = self?.itemCreatedOrUpdatedBlock { itemCreatedOrUpdatedBlock() }
                    })
            } else {
                GearItem.saveNewItem(name, slot: Int16(selectedSlot.row), seedData: false, seedDate: nil, completion: { [weak self] item in
                    if item != nil {
                        self?.item = item
                        self?.performSegueWithIdentifier("ConstraintDetail", sender: nil)
                        if let itemCreatedOrUpdatedBlock = self?.itemCreatedOrUpdatedBlock { itemCreatedOrUpdatedBlock() }
                    }
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
        case .Constraints:
            if let item = item {
                let gearConstraints = Array(item.constraints!) as! [GearConstraint]
                return gearConstraints.count
            }
            else {
                return 0
            }
        case .Slots:
            return GearSlot.Count.rawValue
        case .Actions:
            return ActionsRows.numberOfRows()
        case .Sections:
            return 0
        }
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self]).textColor = Style.aquaColor

        switch TableSection(rawValue: section)! {
        case .Constraints:
            if item != nil {
                return "Rules"
            }
            else {
                return ""
            }
        case .Slots:
            return "Slot"
        case .Actions:
            return "Actions"
        case .Sections:
            return ""
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == TableSection.Constraints.rawValue {
            return 63.0
        } else {
            return 44.0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch TableSection(rawValue: indexPath.section)! {
        case .Constraints:
            if item != nil {
                let cell = tableView.dequeueReusableCellWithIdentifier("RuleSummaryCell", forIndexPath: indexPath) as! RuleSummaryCell

                cell.temperatureLabel.text = constraintText(indexPath, label: .Temperature)
                cell.rainLabel.text = constraintText(indexPath, label: .Rain)
                cell.windLabel.text = constraintText(indexPath, label: .Wind)
                cell.backgroundColor = Style.navyBlueColor
                cell.userInteractionEnabled = true
                cell.accessoryType = .DisclosureIndicator
                return cell
            }
        case .Slots:
            let cell = tableView.dequeueReusableCellWithIdentifier("GearSlotCell", forIndexPath: indexPath)
            cell.backgroundColor = Style.navyBlueColor
            cell.tintColor = UIColor.whiteColor()
            
            cell.textLabel?.text = GearSlot(rawValue: indexPath.row)?.description
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.detailTextLabel?.text = GearSlot(rawValue: indexPath.row)?.detailedDescription
            cell.detailTextLabel?.textColor = Style.silverColor
            
            if let item = item {
                if Int(item.slot) == indexPath.row { cell.accessoryType = .Checkmark }
            }
            return cell
        case .Actions:
            let cell = tableView.dequeueReusableCellWithIdentifier("ActionCell", forIndexPath: indexPath)
            cell.backgroundColor = Style.navyBlueColor
            cell.textLabel?.textColor = Style.maroonColor
            cell.accessoryType = .None

            switch ActionsRows(rawValue: indexPath.row)! {
            case .AddConstraint:
                cell.textLabel?.text = "Add a rule"
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

        if indexPath.section == TableSection.Constraints.rawValue {
            if let item = item {
                let gearConstraint = (Array(item.constraints!) as! [GearConstraint])[indexPath.row]
                performSegueWithIdentifier("ConstraintDetail", sender: gearConstraint)
            }
        } else if indexPath.section == TableSection.Slots.rawValue {
            if let selectedSlot = selectedSlot {
                tableView.cellForRowAtIndexPath(selectedSlot)!.accessoryType = .None
            }
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark

            selectedSlot = indexPath
        } else if indexPath.section == TableSection.Actions.rawValue {
            switch ActionsRows(rawValue: indexPath.row)! {
            case .AddConstraint:
                performSegueWithIdentifier("ConstraintDetail", sender: nil)
            case .Delete:
                let alert = UIAlertController(title: "Are you sure you want to delete this item?", message: "This cannot be reversed", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { [weak self] alertAction in
                    if let item = self?.item {
                        item.deleteItem({ [weak self] in
                            self?.navigationController?.popViewControllerAnimated(true)
                            if let itemCreatedOrUpdatedBlock = self?.itemCreatedOrUpdatedBlock { itemCreatedOrUpdatedBlock() }
                        })
                    }
                }))
                self.presentViewController(alert, animated: true, completion: nil)

            case .Rows: break
            }
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if itemNameTextField.isFirstResponder() {
            itemNameTextField.resignFirstResponder()
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if (segue.identifier == "ConstraintDetail") {
            let vc = segue.destinationViewController as! ConstraintDetailsViewController
            vc.constraint = sender as? GearConstraint
            vc.item = item
            vc.constraintCreatedOrUpdatedBlock = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }

    private func constraintText(indexPath: NSIndexPath, label: RuleCellLabels) -> String {
        var constraintText = ""
        if let item = item {
            let gearConstraint = (Array(item.constraints!) as! [GearConstraint])[indexPath.row]
            let minWind = gearConstraint.minWindSpeed, maxWind = gearConstraint.maxWindSpeed, minTemp = gearConstraint.minTemperature, maxTemp = gearConstraint.maxTemperature, minRain = gearConstraint.minPrecipProbability, maxRain = gearConstraint.maxPrecipProbability
            switch RuleCellLabels(rawValue: label.rawValue)! {
            case .Temperature: constraintText = "Temperature: \(minTemp) - \(maxTemp)\u{00B0} F"
            case .Rain: constraintText = "Rain: \(Int(minRain*100))\u{0025} - \(Int(maxRain*100))\u{0025}"
            case .Wind: constraintText = "Wind: \(minWind) mph - \(maxWind) mph"
            }
        }
        return constraintText
    }
}
