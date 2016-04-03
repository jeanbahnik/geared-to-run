//
//  AdmobTableViewCell.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 4/3/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdmobTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerView: GADBannerView!

    override func awakeFromNib() {
        super.awakeFromNib()

        backgroundColor = UIColor.clearColor()
    }
}
