//
//  GearConstraint+CoreDataProperties.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/13/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

enum ConstraintList: Int {
    case MinTemp, MaxTemp, MinRain, MaxRain, MinWind, MaxWind, Count

    var description: String {
        switch(self) {
        case .MinTemp: return "Min temp"
        case .MaxTemp: return "Max temp"
        case .MinRain: return "Min rain"
        case .MaxRain: return "Max rain"
        case .MinWind: return "Min wind"
        case .MaxWind: return "Max wind"
        case .Count: return ""
        }
    }

    static func numberOfConstraints() -> Int {
        return ConstraintList.Count.rawValue
    }
    
    
}

extension GearConstraint {

    @NSManaged var maxRain: Float
    @NSManaged var maxTemp: Float
    @NSManaged var maxWind: Int16
    @NSManaged var minRain: Float
    @NSManaged var minTemp: Float
    @NSManaged var minWind: Int16
    @NSManaged var item: GearItem?

}
