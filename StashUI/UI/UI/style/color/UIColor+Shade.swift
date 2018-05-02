//
//  UIColor+Shade.swift
//  StashUI
//
//  Created by Dawid Skiba on 2/16/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import UIKit

public let kDefaultPercentage: CGFloat = 10.0

public extension UIColor {
    func lighter(_ percentage: CGFloat = kDefaultPercentage) -> UIColor? {
        return adjust(abs(percentage) )
    }
    
    func darker(_ percentage: CGFloat = kDefaultPercentage) -> UIColor? {
        return adjust(-1.0 * abs(percentage) )
    }
    
    func adjust(_ percentage: CGFloat) -> UIColor? {
        let truePercentage = clamp(value: percentage, lower: 0, upper: 100)
        
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r + truePercentage/100, 1.0),
                           green: min(g + truePercentage/100, 1.0),
                           blue: min(b + truePercentage/100, 1.0),
                           alpha: a)
        } else {
            return nil
        }
    }
}

// 🗜ing for everyone
public func clamp<T: Comparable>(value: T, lower: T, upper: T) -> T {
    return min(max(value, lower), upper)
}
