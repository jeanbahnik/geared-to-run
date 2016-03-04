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
        
        runnerImageView.image = UIImage(named: "runner")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GearSlot.Count.rawValue
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GearListTableViewCell", forIndexPath: indexPath) as! GearListTableViewCell

        cell.userInteractionEnabled = false
        cell.backgroundColor = UIColor.clearColor()
        
        switch GearSlot(rawValue: indexPath.row)! {
        case .Head:
            cell.gearLabel.text = gearListForSlot(.Head)
        case .Torso:
            cell.gearLabel.text = gearListForSlot(.Torso)
        case .Legs:
            cell.gearLabel.text = gearListForSlot(.Legs)
        case .Feet:
            cell.gearLabel.text = gearListForSlot(.Feet)
        case .Accessories:
            cell.gearLabel.text = gearListForSlot(.Accessories)
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
                    if item.slot == slot {
                        itemCount++
                        text += "\(item.description), "
                    }
                }
            }
        }

        if itemCount == 0 {
            text = "-"
        } else {
            text = text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(0), end: text.endIndex.advancedBy(-2)))
        }

        return text
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}

