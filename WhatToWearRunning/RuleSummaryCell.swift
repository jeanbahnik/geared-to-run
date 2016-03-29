//
//  RuleSummaryCell.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/29/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import UIKit

class RuleSummaryCell: UITableViewCell {

    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = Style.navyBlueColor
        tintColor = UIColor.whiteColor()

        temperatureLabel.textColor = UIColor.whiteColor()
        rainLabel.textColor = UIColor.whiteColor()
        windLabel.textColor = UIColor.whiteColor()
    }
}
