//
//  ItemDetailsViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class ItemDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var constraint: GearConstraint? {
        didSet {
            print(constraint)
        }
    }

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
    }

    // MARK: - TableView

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return TableSection.numberOfSections()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case .Item, .Constraints:
            return 1
        case .Actions:
            return 2
        case .Sections:
            return 0
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GearCell", forIndexPath: indexPath)

        switch TableSection(rawValue: indexPath.section)! {
        case .Item:
            cell.textLabel?.text = "item name"
        case .Actions:
            switch ActionsRows(rawValue: indexPath.row)! {
            case .Delete:
                cell.textLabel?.text = "Delete item and constraints"
            case .Rows: break
            }
        case .Constraints:
            cell.textLabel?.text = "Constraints list in a table"
        case .Sections: break
        }

        return cell
    }
}
