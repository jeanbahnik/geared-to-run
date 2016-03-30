//
//  ConstraintDetailsViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/20/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import SVProgressHUD
import TTRangeSlider

class ConstraintDetailsViewController: UIViewController, TTRangeSliderDelegate {

    var item: GearItem?
    var constraint: GearConstraint?
    var constraintCreatedOrUpdatedBlock: (Void -> Void)?

    @IBOutlet weak var deleteRuleButton: UIButton!
    @IBOutlet weak var windRange: TTRangeSlider!
    @IBOutlet weak var rainRange: TTRangeSlider!
    @IBOutlet weak var temperatureRange: TTRangeSlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        fillPlaceholders()
    }
    
    func rangeSlider(sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        
    }

    func setupViews() {
        view.backgroundColor = Style.navyBlueColor

        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationItem.leftBarButtonItem?.title = "Done"

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(ConstraintDetailsViewController.saveButtonTapped))
        barButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = barButtonItem

        // temperatureRange
        temperatureRange.backgroundColor = Style.navyBlueColor
        temperatureRange.tintColor = UIColor.whiteColor()
        temperatureRange.selectedMinimum = 0.0
        temperatureRange.selectedMaximum = 100.0

        // rainRange
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .PercentStyle
        rainRange.delegate = self
        rainRange.backgroundColor = Style.navyBlueColor
        rainRange.tintColor = UIColor.whiteColor()
        rainRange.minValue = 0.0
        rainRange.maxValue = 1.0
        rainRange.enableStep = true
        rainRange.step = 0.25
        rainRange.numberFormatterOverride = numberFormatter

        // windRange
        windRange.delegate = self
        windRange.tintColor = UIColor.whiteColor()
        windRange.minValue = 0
        windRange.maxValue = 100
        windRange.enableStep = true
        windRange.backgroundColor = Style.navyBlueColor

        if let constraint = constraint, item = constraint.item {
            title = item.name
            deleteRuleButton.tintColor = Style.silverColor
        } else {
            title = "New rule"
            deleteRuleButton.enabled = false
            deleteRuleButton.hidden = true
        }
    }

    func fillPlaceholders() {
        if let constraint = constraint {
            temperatureRange.selectedMinimum = Float(constraint.minWind)
            temperatureRange.selectedMaximum = Float(constraint.maxWind)
            windRange.selectedMinimum = Float(constraint.minTemp)
            windRange.selectedMaximum = Float(constraint.maxTemp)
            rainRange.selectedMinimum = constraint.minRain
            rainRange.selectedMaximum = constraint.maxRain
        }
    }

    func saveButtonTapped() {
        if let constraint = constraint {
            constraint.updateConstraint(Int16(temperatureRange.selectedMinimum), maxTemp: Int16(temperatureRange.selectedMaximum), minWind: Int16(windRange.selectedMinimum), maxWind: Int16(windRange.selectedMaximum), minRain: rainRange.selectedMinimum, maxRain: rainRange.selectedMaximum)
            self.navigationController?.popViewControllerAnimated(true)
            if let constraintCreatedOrUpdatedBlock = constraintCreatedOrUpdatedBlock { constraintCreatedOrUpdatedBlock() }
            
        } else if let item = item {
            GearConstraint.saveConstraint(item, minTemp: Int16(temperatureRange.selectedMinimum), maxTemp: Int16(temperatureRange.selectedMaximum), minWind: Int16(windRange.selectedMinimum), maxWind: Int16(windRange.selectedMaximum), minRain: rainRange.selectedMinimum, maxRain: rainRange.selectedMaximum)
                self.navigationController?.popViewControllerAnimated(true)
                if let constraintCreatedOrUpdatedBlock = constraintCreatedOrUpdatedBlock { constraintCreatedOrUpdatedBlock() }
        } else {
            SVProgressHUD.showErrorWithStatus("Uh oh, There was a problem")
        }
    }

    @IBAction func deleteRuleButtonTapped(sender: UIButton) {
        if let constraint = constraint {
            constraint.deleteConstaint({ [weak self] in
                self?.navigationController?.popViewControllerAnimated(true)
                if let constraintCreatedOrUpdatedBlock = self?.constraintCreatedOrUpdatedBlock { constraintCreatedOrUpdatedBlock() }
            })
        }
    }
}
