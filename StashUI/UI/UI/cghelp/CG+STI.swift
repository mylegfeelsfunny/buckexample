//
//  CG+STI.swift
//  StashInvest
//
//  Created by Scott Jones on 9/3/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

extension CGPoint {
    
    public func shift(horizontally l: CGFloat) -> CGPoint {
        return CGPoint(x: x + l, y: y)
    }
    
    public func shift(vertically l: CGFloat) -> CGPoint {
        return CGPoint(x: x, y: y + l)
    }
    
}

extension CGSize {
    
    public func addTo(width l: CGFloat) -> CGSize {
        return CGSize(width: width + l, height: height)
    }
    
    public func addTo(height l: CGFloat) -> CGSize {
        return CGSize(width: width, height: height + l)
    }
    
}

extension CGRect {
    
    public func addTo(width l: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: size.addTo(width: l))
    }
    
    public func addTo(height l: CGFloat) -> CGRect {
        return CGRect(origin: origin, size: size.addTo(height: l))
    }

    public func shift(horizontally l: CGFloat) -> CGRect {
        return CGRect(origin: origin.shift(horizontally: l), size: size)
    }
    
    public func shift(vertically l: CGFloat) -> CGRect {
        return CGRect(origin: origin.shift(vertically: l), size: size)
    }
    
}

