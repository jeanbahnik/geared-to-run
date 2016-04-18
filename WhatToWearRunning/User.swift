//
//  User.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 4/11/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

let kPrefersFemale = "prefersFemale"
let kDeletedSeedData = "deletedSeedData"
let kSeedDataDate = "seedDataDate"
let kIsPro = "isPro"

class User: NSObject {
    static let sharedInstance = User()
    let userPreferences = NSUserDefaults.standardUserDefaults()

    // MARK: - Gender

    func prefersFemale() -> Bool {
        return userPreferences.boolForKey(kPrefersFemale) == true
    }

    func setGenderPreference(bool: Bool) {
        userPreferences.setBool(bool, forKey: kPrefersFemale)
    }

    // MARK: - Deleted seed data

    func deletedSeedData() -> Bool {
        return userPreferences.boolForKey(kDeletedSeedData)
    }

    func setDeletedSeedData(bool: Bool) {
        userPreferences.setBool(bool, forKey: kDeletedSeedData)
    }

    // MARK: - Seed data date

    func getSeedDataDate() -> NSDate {
        return userPreferences.objectForKey(kSeedDataDate) as! NSDate
    }

    func setSeedDataDate() -> NSDate {
        let date = NSDate()
        userPreferences.setObject(date, forKey: kSeedDataDate)
        return date
    }

    // MARK: - Is pro
    func isPro() -> Bool {
        return userPreferences.boolForKey(kIsPro)
    }

    func setIsPro() {
        userPreferences.setBool(true, forKey: kIsPro)
    }
}