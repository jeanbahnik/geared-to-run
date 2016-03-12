//
//  Quote.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/9/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class Quote: NSObject {
    static let sharedInstance = Quote()
    
    // Quote format: Capitalized quote ending with a period
    // followed by a seperating comma and space
    // followerf by the capitalized author name
    let quotes: [String] = [
        "Any day I am too busy to run is a day that I am too busy., John Bryant",
        "It's supposed to get hard... that hard is what makes it great., Anonymous",
        "If you are losing faith in human nature, go out and watch a marathon., Kathrine Switzer",
        "Make each day your masterpiece., John Wooden",
        "Out on the roads, there is fitness and self-discovery and the person we were supposed to be., George Sheehan",
        "You must expect great things from yourself before you can do them., Michael Jordan",
        "Nothing will work unless you do., Maya Angelou",
        "There are no shortcuts to any place worth going., Beverly Sills",
        "With self-discipline, all things are possible., Theodore Roosevelt",
        "The long run puts the tiger in the cat., Bill Squires",
        "Go fast enough to get there, but slow enough to see., Jimmy Buffett",
        "If you want to win something, run 100 meters... If you want to experience something, run a marathon., Emil Zapotek",
        "Somebody may beat me, but they are going to have to bleed to do it., Steve Prefontaine",
        "To give anything less than your best, is to sacrifice the gift., Steve Prefontaine"
    ]

    func randomQuote() -> NSMutableAttributedString {
        let randomIndex = Int(arc4random_uniform(UInt32(quotes.count)))
        let quoteWithAuthor = quotes[randomIndex]
        let quoteAndAuthor = quoteWithAuthor.componentsSeparatedByString("., ")

        let attribute1 = [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Arial Rounded MT Bold", size: 18.0)! ]
        let quote = NSMutableAttributedString(string: "\"\(quoteAndAuthor[0])\" - ", attributes: attribute1)

        let attribute2 = [ NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont(name: "Arial-ItalicMT", size: 17.0)! ]
        let author = NSMutableAttributedString(string: quoteAndAuthor[1], attributes: attribute2)

        quote.appendAttributedString(author)
        return quote
    }
}
