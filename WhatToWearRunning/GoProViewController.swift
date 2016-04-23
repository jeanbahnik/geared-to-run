//
//  GoProViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 4/9/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import SwiftyStoreKit

class GoProViewController: UIViewController {

    let kProductID = "com.jeanbahnik.whattowearrunning.gopro"

    @IBOutlet weak var goProButton: UIButton!
    
    var isProBlock: (Void -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        retrieveProductInto()
        setupViews()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    func setupViews() {
        view.backgroundColor = Style.navyBlueColor

        goProButton.setTitleColor(Style.navyBlueColor, forState: .Normal)
    }
    
    func dismissView() {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func closeButtonTapped(sender: UIButton) {
        dismissView()
    }

    @IBAction func goProButtonTapped(sender: UIButton) {
//        purchaseProduct()
        User.sharedInstance.setIsPro()
        if let isProBlock = isProBlock { isProBlock() }
        dismissView()
    }
    
    func retrieveProductInto() {
        SwiftyStoreKit.retrieveProductInfo(kProductID) { result in
            switch result {
            case .Success(let product):
                let priceString = NSNumberFormatter.localizedStringFromNumber(product.price, numberStyle: .CurrencyStyle)
                print("Product: \(product.localizedDescription), price: \(priceString)")
            case .Error(let error):
                print("Error: \(error)")
            }
        }
    }

    func purchaseProduct() {
        SwiftyStoreKit.purchaseProduct(kProductID) { result in
            switch result {
            case .Success(let productId):
                print("Purchase Success: \(productId)")
            case .Error(let error):
                print("Purchase Failed: \(error)")
            }
        }
    }
}
