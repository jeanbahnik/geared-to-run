//
//  WeatherTests.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 2/13/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

import XCTest

@testable import WhatToWearRunning

class WeatherTests: XCTestCase {
    var weather:Weather?

    override func setUp() {
        super.setUp()

        self.weather = Weather()
}
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testWindBearingNorth() {
        XCTAssertEqual(weather!.windBearing(0.0), "Wind from N")
        XCTAssertEqual(weather!.windBearing(315.0), "Wind from N")
    }
    
    func testWindBearingEast() {
        XCTAssertEqual(weather!.windBearing(45.0), "Wind from E")
    }
}
