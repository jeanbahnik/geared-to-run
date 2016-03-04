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
        
        runnerImageView.image = StyleKit.imageOfRunnerw(frame: CGRectMake(0, 0, runnerImageView.frame.width - 90.0, ((runnerImageView.frame.width - 90.0) * 1.2375)))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(GearSlot.Count.rawValue)
        return GearSlot.Count.rawValue
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == GearSlot.Head.rawValue {
            return 3.0
        }
        return 70.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GearListTableViewCell", forIndexPath: indexPath) as! GearListTableViewCell

        cell.userInteractionEnabled = false
        cell.backgroundColor = UIColor.clearColor()
        
        switch GearSlot(rawValue: indexPath.row)! {
        case .Head:
            let gearLabelText = gearListForSlot(.Head)
            cell.gearLabel.text = gearLabelText
            if gearLabelText == "" { cell.hidden = true }
        case .Torso:
            let gearLabelText = gearListForSlot(.Torso)
            cell.gearLabel.text = gearLabelText
            if gearLabelText == "" { cell.hidden = true }
        case .Legs:
            let gearLabelText = gearListForSlot(.Legs)
            cell.gearLabel.text = gearLabelText
            if gearLabelText == "" { cell.hidden = true }
        case .Feet:
            let gearLabelText = gearListForSlot(.Feet)
            cell.gearLabel.text = gearLabelText
            if gearLabelText == "" { cell.hidden = true }
        case .Accessories:
            let gearLabelText = gearListForSlot(.Accessories)
            cell.gearLabel.text = gearLabelText
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
            text = ""
        } else {
            text = text.substringWithRange(Range<String.Index>(start: text.startIndex.advancedBy(0), end: text.endIndex.advancedBy(-2)))
        }

        return text
    }
    
    func reloadView() {
        tableView.reloadData()
    }
}

