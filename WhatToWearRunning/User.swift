//
//  User.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 4/11/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

let kPrefersFemale = "prefersFemale"
let kDeletedSeedData = "deletedSeedData"

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

    func setDeletedSeedData() {
        userPreferences.setBool(true, forKey: kDeletedSeedData)
    }
}