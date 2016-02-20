//
//  GearListTableViewCell.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/20/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class GearListTableViewCell: UITableViewCell {

    @IBOutlet weak var gearLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
        self.gearLabel.textColor = UIColor.whiteColor()
    }
}
