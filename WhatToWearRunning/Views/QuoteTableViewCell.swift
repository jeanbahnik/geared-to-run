//
//  QuoteTableViewCell.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/9/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class QuoteTableViewCell: UITableViewCell {

    @IBOutlet weak var quoteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        userInteractionEnabled = false
        backgroundColor = UIColor.clearColor()
    }
}
