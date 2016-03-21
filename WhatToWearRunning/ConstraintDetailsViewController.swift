//
//  ConstraintDetailsViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/20/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

//import SVProgressHUD

class ConstraintDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
//    private enum TableSection: Int {
//        case Slots, Constraints, Actions, Sections
//        
//        static func numberOfSections() -> Int {
//            return TableSection.Sections.rawValue
//        }
//    }
//    
//    private enum ActionsRows: Int {
//        case Delete, Rows
//        
//        static func numberOfRows() -> Int {
//            return ActionsRows.Rows.rawValue
//        }
//    }
    
    @IBOutlet weak var tableView: UITableView!
    var constraint: GearConstraint?
//    @IBOutlet weak var itemNameTextField: UITextField!
//    var selectedSlot: NSIndexPath?
//    var itemCreatedOrUpdatedBlock: (Void -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        navigationController?.navigationItem.leftBarButtonItem?.title = "Done"
        
        tableView.backgroundColor = Style.navyBlueColor
        tableView.separatorStyle = .None
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveButtonTapped")
        barButtonItem.tintColor = UIColor.whiteColor()
        navigationItem.rightBarButtonItem = barButtonItem
        
        if let constraint = constraint, item = constraint.item {
            title = item.name
        } else {
            title = "New Constraint"
        }
    }
    
    func saveButtonTapped() {
        print("save button tapped")
//        if let selectedSlot = selectedSlot, name =  itemNameTextField.text where name > "" {
//            if item == nil {
//                GearItem.saveNewItem(name, slot: Int16(selectedSlot.row), completion: { [weak self] item in
//                    if item != nil {
//                        self?.navigationController?.popViewControllerAnimated(true)
//                        if let itemCreatedOrUpdatedBlock = self?.itemCreatedOrUpdatedBlock { itemCreatedOrUpdatedBlock() }
//                    }
//                    })
//            } else if let item = item {
//                GearItem.updateItem(name, slot: Int16(selectedSlot.row), item: item, completion: { [weak self] item in
//                    self?.navigationController?.popViewControllerAnimated(true)
//                    if let itemCreatedOrUpdatedBlock = self?.itemCreatedOrUpdatedBlock { itemCreatedOrUpdatedBlock() }
//                    })
//            }
//            
//        } else {
//            SVProgressHUD.showErrorWithStatus("Name or Slot can't be blank")
//        }
    }
    
    // MARK: - TableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConstraintList.numberOfConstraints()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ConstraintEditTableViewCell
        cell.userInteractionEnabled = false

        return cell
    }
}
