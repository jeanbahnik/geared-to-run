//
//  Quote.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/9/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class Quote: NSObject {
    static let sharedInstance = Quote()
    
    let quotes: [String] = [
        "first inspiring quote",
        "second inspiring quote",
        "third inspirational quote"
    ]

    func randomQuote() -> String {
        let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        return quotes[randomIndex]
    }
}
