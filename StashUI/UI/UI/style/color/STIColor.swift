//
//  STIColor.swift
//  StashInvest
//
//  Created by Scott Jones on 12/28/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public extension UIColor {
    
    public static let gradient = UIColor(patternImage: .gradient)
    
    public static var stashEggshell: UIColor {
        return UIColor(red: 248.0 / 255.0, green: 248.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashDarkGray: UIColor {
        return UIColor(white: 39.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashDarkFont: UIColor {
        return .stashGray(56.0)
    }
    
    public static var stashSoftBlack: UIColor {
        return UIColor(red: 43.0 / 255.0, green: 44.0 / 255.0, blue: 45.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashLightGray: UIColor {
        return UIColor(white: 130.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashOrange: UIColor {
        return UIColor(red: 242.0 / 255.0, green: 110.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashRedOrange: UIColor {
        return UIColor(red: 249.0 / 255.0, green: 187.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashYellow: UIColor {
        return UIColor(red: 245.0 / 255.0, green: 166.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashPaleYellow: UIColor {
        return UIColor(red:241 / 255.0, green: 255 / 255.0, blue: 84 / 255.0, alpha: 1.0).blend(with: .white, amount: 0.6)
    }
    
    public static var stashBlue: UIColor {
        return UIColor(red:52.0 / 255.0, green: 96.0 / 255.0, blue: 141.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashSkyBlue: UIColor {
        return UIColor(red:38.0 / 255.0, green: 146.0 / 255.0, blue: 222.0 / 255.0, alpha: 1.0)
    }
    
    public static func stashBlue(alpha: CGFloat) -> UIColor {
        return stashBlue.withAlphaComponent(alpha)
    }
    
    public static var stashVibrantBlue: UIColor {
        return UIColor(red:3.0 / 255.0, green: 122.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashLightBlue: UIColor {
        return stashBlue.blend(with: .white, amount: 0.9)
    }
    
    public static var stashPurple: UIColor {
        return UIColor(red: 99.0 / 255.0, green: 56.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashBrookPurple: UIColor {
        return UIColor(red: 105.0 / 255.0, green: 54.0 / 255.0, blue: 206.0 / 255.0, alpha: 1.0)
    }

    public static var stashDarkPurple: UIColor {
        return UIColor(red: 63.0 / 255.0, green: 52.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashPalePurple: UIColor {
        return UIColor(red: 63.0 / 255.0, green: 52.0 / 255.0, blue: 97.0 / 255.0, alpha: 1.0)
    }

    public static var stashPaleBlue: UIColor {
        return UIColor(red: 90.0 / 255.0, green: 141.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashGrayTableViewBackground: UIColor {
        return UIColor(red: 0.937254901960784, green: 0.952941176470588, blue: 0.964705882352941, alpha: 1.0)
    }
    
    public static var stashTeel: UIColor {
        return UIColor(red:68.0 / 255.0, green: 209.0 / 255.0, blue: 219.0 / 255.0, alpha: 1.0)
    }

    public static var stashAqua: UIColor {
        return UIColor(red:68.0 / 255.0, green: 206.0 / 255.0, blue: 231.0 / 255.0, alpha: 1.0)
    }

    public static var stashRed: UIColor {
        return UIColor(red:214.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashGreen: UIColor {
        return UIColor(red:114.0 / 255.0, green: 202.0 / 255.0, blue: 92.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashDarkGreen: UIColor {
        return UIColor(red:94.0 / 255.0, green: 161.0 / 255.0, blue: 79.0 / 255.0, alpha: 1.0)
    }
    
    public static var stashPaleRed: UIColor {
        return UIColor(red:243.0 / 255.0, green: 110.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
    }

    public static var stashLimeGreen: UIColor {
        return UIColor(red:126.0 / 255.0, green: 211.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0)
    }

    public static var activityIndicatorBackground: UIColor {
        return UIColor.black.withAlphaComponent(0.25)
    }
    
    public static func stashGray(_ val: CGFloat = 130.0) -> UIColor {
        return UIColor(red: val / 255.0, green: val / 255.0, blue: val / 255.0, alpha: 1.0)
    }
 
    public var selected: UIColor {
        return blend(with: .black, amount: 0.3)
    }
    
    public var highlighted: UIColor {
        return blend(with: .white, amount: 0.3)
    }
    
    public var disabled: UIColor {
        return withAlphaComponent(0.3)
    }
    
    public var dimmed: UIColor {
        return withAlphaComponent(0.7)
    }
    
    public func blend(with color: UIColor, amount: CGFloat) -> UIColor {
        if color == .clear { return color }
        let a = CGFloat(min(1.0, max( 0.0, Double(amount))))
        let firstColorAmount: CGFloat = CGFloat(1.0) - a
        
        var r1: CGFloat = 0.0
        var g1: CGFloat = 0.0
        var b1: CGFloat = 0.0
        var a1: CGFloat = 0.0
        
        var r2: CGFloat = 0.0
        var g2: CGFloat = 0.0
        var b2: CGFloat = 0.0
        var a2: CGFloat = 0.0
        
        getRed(&r1, green: &g1, blue: &b1, alpha:&a1)
        color.getRed(&r2, green: &g2, blue: &b2, alpha:&a2)
        
        let red     = r1 * firstColorAmount + r2 * a
        let green   = g1 * firstColorAmount + g2 * a
        let blue    = b1 * firstColorAmount + b2 * a
        let alpha   = a1 * firstColorAmount + a2 * a
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    public convenience init(hex: Int, alpha: CGFloat = 1) {
        self.init(r: CGFloat((hex >> 16) & 0xff), g: CGFloat((hex >> 08) & 0xff), b: CGFloat((hex >> 00) & 0xff), a: alpha)
    }

}


public extension UIColor {
    public static var navigationBar: UIColor {
        return .stashPurple
    }
    
    public static var cellSelectionColor: UIColor {
        return UIColor.stashGray(245)
    }
}
