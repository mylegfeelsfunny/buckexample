//
//  LabelStyle.swift
//  StashInvest
//
//  Created by Dawid Skiba on 9/6/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public struct LabelStyle {
    public var font: UIFont
    public var textColor: UIColor
    public var numberOfLines: Int = 1
    public var textAlignment = NSTextAlignment.left
    public var backgroundColor = UIColor.clear
    
    public init(_ font: UIFont, _ textColor: UIColor, _ numberOfLines: Int = 1, _ textAlignment: NSTextAlignment = .left) {
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}

extension UILabel {
    public func stashalize(_ style: LabelStyle) {
        font = style.font
        textColor = style.textColor
        textAlignment = style.textAlignment
        numberOfLines = style.numberOfLines
        backgroundColor = style.backgroundColor
    }
    
    public var labelStyle: LabelStyle {
        var style = LabelStyle(font, textColor, numberOfLines, textAlignment)
        style.backgroundColor = backgroundColor ?? .clear
        return style
    }
}
