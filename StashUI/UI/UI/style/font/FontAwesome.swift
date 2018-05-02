//
//  FontAwesome.swift
//  StashInvest
//
//  Created by Scott Jones on 6/8/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

private enum FontAwesome: String {
    case regular           			= "FontAwesome"
    
    func ofSize(_ size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return UIFont(name: rawValue, size: deviceScaled ? size.deviceScaled : size)!
    }
}

public extension UIFont {
    
    static func fontAwesomeFont(ofSize size: CGFloat, deviceScaled: Bool = true) -> UIFont {
        return FontAwesome.regular.ofSize(size, deviceScaled: deviceScaled)
    }

}

public extension String {
    static let check             	= "\u{f00c}"
    static let paddlock           	= "\u{f023}"
    static let secureEye          	= "\u{f06e}"
    static let insecureEye        	= "\u{f070}"
    static let checkUnchecked     	= "\u{f096}"
    static let checkChecked         = "\u{f14a}"
    static let thumbsUp             = "\u{f44d}"
    static let chevronDown          = "\u{f078}"
}
