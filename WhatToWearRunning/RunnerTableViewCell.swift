//
//  runnerTableViewCell.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/28/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class RunnerTableViewCell: UITableViewCell, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var runnerImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var outfit: [GearItem]?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.backgroundColor = UIColor.clearColor()
        tableView.backgroundColor = UIColor.clearColor()
        
        tableView.registerNib(UINib(nibName: "GearListTableViewCell", bundle: NSBundle.mainBundle()), forCellReuseIdentifier: "GearListTableViewCell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var rows = 0, n = 0
//        while let item = GearSlot(rawValue: n) {
//            if gearListForSlot(item) != "" { rows++ }
//            n++
//        }
//        return rows
        return GearSlot.Count.rawValue
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GearListTableViewCell", forIndexPath: indexPath) as! GearListTableViewCell

        cell.userInteractionEnabled = false
        cell.backgroundColor = UIColor.clearColor()

        switch GearSlot(rawValue: indexPath.row)! {
        case .Head:
            cell.gearLabel.text = "Head: \(gearListForSlot(GearSlot.Head))"
        case .Torso:
            cell.gearLabel.text = "Torso: \(gearListForSlot(GearSlot.Torso))"
        case .Legs:
            cell.gearLabel.text = "Legs: \(gearListForSlot(GearSlot.Legs))"
        case .Feet:
            cell.gearLabel.text = "Feet: \(gearListForSlot(GearSlot.Feet))"
        case .Accessories:
            cell.gearLabel.text = "Accessories: \(gearListForSlot(GearSlot.Accessories))"
            cell.dottedLineImageView.hidden = true
        default:
            cell.gearLabel.text = nil
            cell.dottedLineImageView.hidden = true
        }

        return cell
    }
    
    func gearListForSlot(slot: GearSlot) -> String {
        var text = ""
        var itemCount = 0
        if outfit?.count > 0 {
            if let outfit = outfit {
                for item in outfit {
                    if Int(item.slot) == slot.rawValue {
                        itemCount++
                        if let itemName = item.name {
                            text += "\(itemName), "
                        }
                    }
                }
            }
        }

        if itemCount == 0 {
            text = " -"
        } else {
            text = text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(0), end: text.endIndex.advancedBy(-2)))
        }

        return text
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}

