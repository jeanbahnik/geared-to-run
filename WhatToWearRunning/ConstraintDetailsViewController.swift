//
//  ConstraintDetailsViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/20/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import SVProgressHUD

class ConstraintDetailsViewController: UIViewController {

    var item: GearItem?
    var constraint: GearConstraint?
    var constraintCreatedOrUpdatedBlock: (Void -> Void)?

    @IBOutlet weak var minTempTextField: UITextField!
    @IBOutlet weak var maxTempTextField: UITextField!
    @IBOutlet weak var minRainTextField: UITextField!
    @IBOutlet weak var maxRainTextField: UITextField!
    @IBOutlet weak var minWindTextField: UITextField!
    @IBOutlet weak var maxWindTextField: UITextField!
    @IBOutlet weak var deleteRuleButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        fillPlaceholders()
    }

    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationItem.leftBarButtonItem?.title = "Done"

        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButtonTapped")
        barButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = barButtonItem

        minTempTextField.keyboardType = .DecimalPad
        maxTempTextField.keyboardType = .DecimalPad
        minRainTextField.keyboardType = .DecimalPad
        maxRainTextField.keyboardType = .DecimalPad
        minWindTextField.keyboardType = .DecimalPad
        maxWindTextField.keyboardType = .DecimalPad

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
            minTempTextField.text = "\(constraint.minTemp)"
            maxTempTextField.text = "\(constraint.maxTemp)"
            minRainTextField.text = "\(constraint.minRain)"
            maxRainTextField.text = "\(constraint.maxRain)"
            minWindTextField.text = "\(constraint.minWind)"
            maxWindTextField.text = "\(constraint.maxWind)"
        }
    }

    func saveButtonTapped() {
        if let minTemp = minTempTextField.text, maxTemp = maxTempTextField.text, minRain = minRainTextField.text, maxRain = maxRainTextField.text, minWind = minWindTextField.text, maxWind = maxWindTextField.text where (minTemp > "" && maxTemp > "" && minRain > "" && maxRain > "" && minWind > "" && maxWind > "") {
            if let constraint = constraint {
                constraint.updateConstraint(Float(minTemp)!, maxTemp: Float(maxTemp)!, minWind: Int16(minWind)!, maxWind: Int16(maxWind)!, minRain: Float(minRain)!, maxRain: Float(maxRain)!)
                self.navigationController?.popViewControllerAnimated(true)
                if let constraintCreatedOrUpdatedBlock = constraintCreatedOrUpdatedBlock { constraintCreatedOrUpdatedBlock() }
                
            } else if let item = item {
                GearConstraint.saveConstraint(item, minTemp: Float(minTemp)!, maxTemp: Float(maxTemp)!, minWind: Int16(minWind)!, maxWind: Int16(maxWind)!, minRain: Float(minRain)!, maxRain: Float(maxRain)!)
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
