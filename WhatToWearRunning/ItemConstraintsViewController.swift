//
//  ItemConstraintsViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class ItemConstraintsViewController: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var gearConstraints = [GearConstraint]()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        tableView.dataSource = self
        tableView.delegate = self

        setupViews()
    }
    
    func setupViews() {

    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gearConstraints.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ConstraintCell", forIndexPath: indexPath)
        
        let constraint = gearConstraints[indexPath.row]
        cell.textLabel?.text = constraint.item?.name
        
        return cell
    }
}
