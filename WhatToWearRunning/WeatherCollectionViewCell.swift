//
//  WeatherCollectionViewCell.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/24/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var summaryIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windBearingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = UIColor.clearColor()
    }
}
