//
//  GoProViewController.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 4/9/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import SwiftyStoreKit
import CoreData

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
//        migrateLocalStoreToiCloudStore()
        reloadStore(nil)
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

    // MARK: - Core Data

    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("WhatToWearRunning", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    func migrateLocalStoreToiCloudStore() {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)

        let storeOptions = [ NSPersistentStoreUbiquitousContentNameKey: "WhatToWearRunningCloudStore"]
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("WhatToWearRunning.sqlite")
        let failureReason = "There was an error creating or loading the application's saved data."
        let store = NSPersistentStore(persistentStoreCoordinator: coordinator, configurationName: nil, URL: url, options: nil)
//        do {
//            let store = try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
//        } catch {
//            var dict = [String: AnyObject]()
//            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
//            dict[NSLocalizedFailureReasonErrorKey] = failureReason
//            dict[NSUnderlyingErrorKey] = error as NSError
//            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
//            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
//            abort()
//        }

        do {
            try coordinator.migratePersistentStore(store, toURL: url, options: storeOptions, withType: NSSQLiteStoreType)
            print("migratePersistentStore")
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }

        reloadStore(store)
    }

    func reloadStore(store: NSPersistentStore?) {
        let failureReason = "There was an error creating or loading the application's saved data."

        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let storeOptions = [ NSPersistentStoreUbiquitousContentNameKey: "WhatToWearRunningCloudStore"]
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("WhatToWearRunning.sqlite")

        if store != nil {
            do {
                try coordinator.removePersistentStore(store!)
                print("removePersistentStore")
            } catch {
                // Report any error we got.
                var dict = [String: AnyObject]()
                dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
                dict[NSLocalizedFailureReasonErrorKey] = failureReason

                dict[NSUnderlyingErrorKey] = error as NSError
                let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
                // Replace this with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
                abort()
            }
        }

        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: storeOptions)
            print("addPersistentStoreWithType")
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason

            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
    }
}
