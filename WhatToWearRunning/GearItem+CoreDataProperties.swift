//
//  GearItem+CoreDataProperties.swift
//  
//
//  Created by Jean Bahnik on 4/3/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension GearItem {

    @NSManaged var name: String?
    @NSManaged var slot: Int16
    @NSManaged var notes: String?
    @NSManaged var image: String?
    @NSManaged var seedData: Bool
    @NSManaged var constraints: NSSet?

}
