//
//  SFFont.swift
//  StashUI
//
//  Created by Scott Jones on 11/1/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public extension UIFont {

    static func blackSFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.systemFont(ofSize: deviceScaled ? size.deviceScaled : size, weight: .black)
    }

    static func boldSFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.systemFont(ofSize: deviceScaled ? size.deviceScaled : size, weight: .bold)
    }

    static func heavySFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.systemFont(ofSize: deviceScaled ? size.deviceScaled : size, weight: .heavy)
    }

    static func italicSFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.italicSystemFont(ofSize: deviceScaled ? size.deviceScaled : size)
    }

    static func lightSFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.systemFont(ofSize: deviceScaled ? size.deviceScaled : size, weight: .light)
    }

    static func mediumSFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.systemFont(ofSize: deviceScaled ? size.deviceScaled : size, weight: .medium)
    }

    static func regularSFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.systemFont(ofSize: deviceScaled ? size.deviceScaled : size, weight: .regular)
    }

    static func ultraLightSFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.systemFont(ofSize: deviceScaled ? size.deviceScaled : size, weight: .ultraLight)
    }

    static func semiboldSFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.systemFont(ofSize: deviceScaled ? size.deviceScaled : size, weight: .semibold)
    }

    static func thinSFFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont.systemFont(ofSize: deviceScaled ? size.deviceScaled : size, weight: .thin)
    }

}
