//
//  ItemDetailsViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class ItemDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var item: GearItem?

    private enum TableSection: Int {
        case Item, Actions, Constraints, Sections

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

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
        if let item = item {
            self.title = item.name
        }
    }

    // MARK: - TableView

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableSection.numberOfSections()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case .Item:
            return 1
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
        if let item = item {
            switch TableSection(rawValue: indexPath.section)! {
            case .Item:
                let cell = tableView.dequeueReusableCellWithIdentifier("GearCell", forIndexPath: indexPath)
                cell.textLabel?.text = item.name
            case .Actions:
                let cell = tableView.dequeueReusableCellWithIdentifier("GearCell", forIndexPath: indexPath)
                switch ActionsRows(rawValue: indexPath.row)! {
                case .Delete:
                    cell.textLabel?.text = "Delete item and constraints"
                case .Rows: break
                }
            case .Constraints:
                let cell = tableView.dequeueReusableCellWithIdentifier("ConstraintsCell", forIndexPath: indexPath)
                let gearConstraints = Array(item.constraints!) as! [GearConstraint]
                let gearConstraint = gearConstraints[indexPath.row]
                cell.textLabel?.text = gearConstraint.item?.name
            case .Sections: break
            }
        }

        let cell = tableView.dequeueReusableCellWithIdentifier("GearCell", forIndexPath: indexPath)
        return cell
    }
}
