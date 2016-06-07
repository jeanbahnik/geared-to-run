//
//  PullToRefreshView.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/19/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import UIKit

class PullToRefreshView: UIView {
    
    @IBOutlet weak var updatedAtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
    }
}
