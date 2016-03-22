//
//  GearItem+CoreDataProperties.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/13/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

//import Foundation
//import CoreData

extension GearItem {

    @NSManaged var name: String?
    @NSManaged var slot: Int16
    @NSManaged var constraints: NSSet?

}
