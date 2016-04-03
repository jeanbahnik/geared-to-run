//
//  GearConstraint+CoreDataProperties.swift
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

extension GearConstraint {

    @NSManaged var maxPrecipProbability: Float
    @NSManaged var maxTemperature: Int16
    @NSManaged var maxWindSpeed: Int16
    @NSManaged var minPrecipProbability: Float
    @NSManaged var minTemperature: Int16
    @NSManaged var minWindSpeed: Int16
    @NSManaged var minPrecipIntensity: NSNumber?
    @NSManaged var maxPrecipIntensity: NSNumber?
    @NSManaged var minCloudCover: NSNumber?
    @NSManaged var maxCloudCover: NSNumber?
    @NSManaged var item: GearItem?
}
