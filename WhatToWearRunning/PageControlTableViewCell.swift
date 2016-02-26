//
//  PageControlTableViewCell.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/25/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import UIKit

class PageControlTableViewCell: UITableViewCell {

    @IBOutlet weak var pageControl: UIPageControl!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clearColor()
    }
}
