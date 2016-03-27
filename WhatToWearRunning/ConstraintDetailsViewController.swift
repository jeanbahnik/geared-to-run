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

    @IBOutlet weak var minWindTextField: UITextField!
    @IBOutlet weak var maxWindTextField: UITextField!
    @IBOutlet weak var deleteRuleButton: UIButton!
    @IBOutlet weak var windRange: TTRangeSlider!
    @IBOutlet weak var rainRange: TTRangeSlider!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        fillPlaceholders()
    }
    
    func rangeSlider(sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        
    }

    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationItem.leftBarButtonItem?.title = "Done"

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButtonTapped")
        barButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = barButtonItem

        minWindTextField.keyboardType = .DecimalPad
        maxWindTextField.keyboardType = .DecimalPad
        
        windRange.delegate = self
        windRange.minValue = 0
        windRange.maxValue = 100
        windRange.enableStep = true
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        
        rainRange.delegate = self
        rainRange.minValue = 0.0
        rainRange.maxValue = 1.0
        rainRange.enableStep = true
        rainRange.step = 0.25
        rainRange.numberFormatterOverride = numberFormatter

        if let constraint = constraint, item = constraint.item {
            title = item.name
        } else {
            title = "New rule"
            deleteRuleButton.enabled = false
            deleteRuleButton.hidden = true
        }
    }

    func fillPlaceholders() {
        if let constraint = constraint {
            windRange.selectedMinimum = Float(constraint.minTemp)
            windRange.selectedMaximum = Float(constraint.maxTemp)
            rainRange.selectedMinimum = constraint.minRain
            rainRange.selectedMaximum = constraint.maxRain
            minWindTextField.text = "\(constraint.minWind)"
            maxWindTextField.text = "\(constraint.maxWind)"
        }
    }

    func saveButtonTapped() {
        if let minWind = minWindTextField.text, maxWind = maxWindTextField.text where (minWind > "" && maxWind > "") {
            if let constraint = constraint {
                constraint.updateConstraint(Int16(windRange.selectedMinimum), maxTemp: Int16(windRange.selectedMaximum), minWind: Int16(minWind)!, maxWind: Int16(maxWind)!, minRain: rainRange.selectedMinimum, maxRain: rainRange.selectedMaximum)
                self.navigationController?.popViewControllerAnimated(true)
                if let constraintCreatedOrUpdatedBlock = constraintCreatedOrUpdatedBlock { constraintCreatedOrUpdatedBlock() }
                
            } else if let item = item {
                GearConstraint.saveConstraint(item, minTemp: Int16(windRange.selectedMinimum), maxTemp: Int16(windRange.selectedMaximum), minWind: Int16(minWind)!, maxWind: Int16(maxWind)!, minRain: rainRange.selectedMinimum, maxRain: rainRange.selectedMaximum)
                    self.navigationController?.popViewControllerAnimated(true)
                    if let constraintCreatedOrUpdatedBlock = constraintCreatedOrUpdatedBlock { constraintCreatedOrUpdatedBlock() }
            } else {
                SVProgressHUD.showErrorWithStatus("Uh oh, There was a problem")
            }
        } else {
            SVProgressHUD.showErrorWithStatus("No slot can be blank")
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
