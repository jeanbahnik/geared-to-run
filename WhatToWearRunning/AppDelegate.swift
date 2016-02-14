//
//  AppDelegate.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 1/14/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import HockeySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        // Crashlytics/Fabric
        Fabric.with([Crashlytics.self])
        
        // Instabug
        Instabug.startWithToken(instabugToken, captureSource: IBGCaptureSourceUIKit, invocationEvent: IBGInvocationEventShake)

        // Hockeyapp
        BITHockeyManager.sharedHockeyManager().configureWithIdentifier(hockeyAppIdentifier)
        BITHockeyManager.sharedHockeyManager().crashManager.crashManagerStatus = .AutoSend
        BITHockeyManager.sharedHockeyManager().startManager()

        return true
    }
}

