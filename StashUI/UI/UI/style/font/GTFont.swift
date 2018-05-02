//
//  GTFont.swift
//  StashUI
//
//  Created by Scott Jones on 4/11/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import UIKit

private enum GTFont: String {
    
    case black                      = "GTWalsheim-Black"
    case blackOblique               = "GTWalsheim-BlackOblique"
    case bold                       = "GTWalsheim-Bold"
    case boldOblique                = "GTWalsheim-BoldOblique"
    case condensedBlack             = "GTWalsheim-CondensedBlack"
    case condensedBlackOblique      = "GTWalsheim-CondensedBlackOblique"
    case condensedBold              = "GTWalsheim-CondensedBold"
    case condensedBoldOblique       = "GTWalsheim-CondensedBoldOblique"
    case condensedLight             = "GTWalsheim-CondensedLight"
    case condensedLightOblique      = "GTWalsheim-CondensedLightOblique"
    case condensedRegular           = "GTWalsheim-CondensedRegular"
    case condensedRegularOblique    = "GTWalsheim-CondensedRegularOblique"
    case condensedMedium            = "GTWalsheim-CondensedMedium"
    case condensedMediumOblique     = "GTWalsheim-CondensedMediumOblique"
    case condensedThin              = "GTWalsheim-CondensedThin"
    case condensedThinOblique       = "GTWalsheim-CondensedThinOblique"
    case condensedUltraBold         = "GTWalsheim-CondensedUltraBold"
    case condensedUltraBoldOblique  = "GTWalsheim-CondensedUltraBoldOblique"
    case condensedUltraLight        = "GTWalsheim-CondensedUltraLight"
    case condensedUltraLightOblique = "GTWalsheim-CondensedUltraLightOblique"
    case light                      = "GTWalsheim-Light"
    case lightOblique               = "GTWalsheim-LightOblique"
    case medium                     = "GTWalsheim-Medium"
    case mediumOblique              = "GTWalsheim-MediumOblique"
    case thin                       = "GTWalsheim-Thin"
    case thinOblique                = "GTWalsheim-ThinOblique"
    case regular                    = "GTWalsheim-Regular"
    case regularOblique             = "GTWalsheim-RegularOblique"
    case ultraBold                  = "GTWalsheim-UltraBold"
    case ultraBoldOblique           = "GTWalsheim-UltraBoldOblique"
    case ultraLight                 = "GTWalsheim-UltraLight"
    case ultraLightOblique          = "GTWalsheim-UltraLightOblique"

    func ofSize(_ size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont(name: rawValue, size: deviceScaled ? size.deviceScaled : size)!
    }

}

public extension UIFont {
    
    static func blackGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.black.ofSize(size, deviceScaled: deviceScaled)
    }

    static func blackObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.blackOblique.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func boldGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.bold.ofSize(size, deviceScaled: deviceScaled)
    }

    static func boldObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.boldOblique.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedBlackGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedBlack.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedBlackObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedBlackOblique.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedBoldGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedBold.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedBoldObliquedGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedBoldOblique.ofSize(size, deviceScaled: deviceScaled)
    }

    static func condensedLightGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedLight.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedLightObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedLightOblique.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedRegularGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedRegular.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedRegularObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedRegularOblique.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedMediumGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedMedium.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedMediumObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedMediumOblique.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedThinGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedThin.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedThinObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedThinOblique.ofSize(size, deviceScaled: deviceScaled)
    }

    static func condensedUltraBoldGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedUltraBold.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedUltraBoldObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedUltraBoldOblique.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedUltraLightGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedUltraLight.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func condensedUltraLightObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.condensedUltraLightOblique.ofSize(size, deviceScaled: deviceScaled)
    }

    static func lightGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.light.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func lightObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.lightOblique.ofSize(size, deviceScaled: deviceScaled)
    }

    static func mediumObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.mediumOblique.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func mediumGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.medium.ofSize(size, deviceScaled: deviceScaled)
    }

    static func thinGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.thin.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func thinObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.thinOblique.ofSize(size, deviceScaled: deviceScaled)
    }

    static func regularGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.regular.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func regularObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.regularOblique.ofSize(size, deviceScaled: deviceScaled)
    }

    static func ultraBoldGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.ultraBold.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func ultraBoldObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.ultraBoldOblique.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func ultraLightGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.ultraLight.ofSize(size, deviceScaled: deviceScaled)
    }
    
    static func ultraLightObliqueGTFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return GTFont.ultraLightOblique.ofSize(size, deviceScaled: deviceScaled)
    }

}
