//
//  UIVerticalAlignLabel.swift
//  WhatToWearRunning
//
//  Created by Jean Bahnik on 3/4/16.
//  Copyright © 2016 Jean Bahnik. All rights reserved.
//

class UIVerticalAlignLabel: UILabel {
    
    enum VerticalAlignment : Int {
        case VerticalAlignmentTop = 0
        case VerticalAlignmentMiddle = 1
        case VerticalAlignmentBottom = 2
    }
    
    var verticalAlignment : VerticalAlignment = .VerticalAlignmentTop {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines: Int) -> CGRect {
        let rect = super.textRectForBounds(bounds, limitedToNumberOfLines: limitedToNumberOfLines)
        
        switch(verticalAlignment) {
        case .VerticalAlignmentTop:
            return CGRectMake(bounds.origin.x, bounds.origin.y, rect.size.width, rect.size.height)
        case .VerticalAlignmentMiddle:
            return CGRectMake(bounds.origin.x, bounds.origin.y + (bounds.size.height - rect.size.height) / 2, rect.size.width, rect.size.height)
        case .VerticalAlignmentBottom:
            return CGRectMake(bounds.origin.x, bounds.origin.y + (bounds.size.height - rect.size.height), rect.size.width, rect.size.height)
        default:
            return bounds
        }
    }
    
    override func drawTextInRect(rect: CGRect) {
        let r = self.textRectForBounds(rect, limitedToNumberOfLines: self.numberOfLines)
        super.drawTextInRect(r)
    }
}