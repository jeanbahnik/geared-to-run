//
//  runnerTableViewCell.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/28/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class RunnerTableViewCell: UITableViewCell {

    @IBOutlet weak var headBubbleView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
//        self.headBubbleView.backgroundColor = UIColor.yellowColor()
    }
}
