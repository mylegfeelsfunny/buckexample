//
//  LatoFont.swift
//  StashInvest
//
//  Created by Scott Jones on 12/28/16.
//  Copyright © 2016 Collective Returns, INC. All rights reserved.
//

import UIKit

private enum LatoFont: String {
    case black              = "Lato-Black"
    case blackItalic        = "Lato-BlackItalic"
    case bold               = "Lato-Bold"
    case boldItalic         = "Lato-BoldItalic"
    case regular            = "Lato-Regular"
    case italic             = "Lato-Italic"
    case light              = "Lato-Light"
    case lightItalic        = "Lato-LightItalic"
    case hairline           = "Lato-Hairline"
    case hairlineItalic     = "Lato-HairlineItalic"
    
    func ofSize(_ size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont(name: rawValue, size: deviceScaled ? size.deviceScaled : size)!
    }
}

public extension UIFont {
    
    static func blackLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.black.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func blackItalicLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.blackItalic.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func boldLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.bold.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func boldItalicLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.boldItalic.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func regularLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.regular.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func italicLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.italic.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func lightLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.light.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func lightItalicLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.lightItalic.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func hairlineLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.hairline.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func hairlineItalicLatoFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return LatoFont.hairlineItalic.ofSize(size, deviceScaled: deviceScaled)
    }
}
