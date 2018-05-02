//
//  Attributes.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 3/31/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

public struct Attributes {
    public let attributes: [NSAttributedStringKey: Any]
    
    public init() {
        self.attributes = [:]
    }

    public init(_ attributes: [NSAttributedStringKey: Any]? = nil) {
        self.attributes = attributes ?? [:]
    }
    
    private func withUpdatedAttributes(_ attributes: [NSAttributedStringKey: Any]) -> Attributes {
        return Attributes(self.attributes.updated(with: attributes))
    }
    
    public func withFont(_ font: UIFont) -> Attributes {
        return withUpdatedAttributes([NSAttributedStringKey.font: font])
    }
    
    public func withForegroundColor(_ foregroundColor: UIColor) -> Attributes {
        return withUpdatedAttributes([NSAttributedStringKey.foregroundColor: foregroundColor])
    }
    
    public func withUnderline(_ underlineStyle: NSUnderlineStyle = .styleSingle) -> Attributes {
        return withUpdatedAttributes([NSAttributedStringKey.underlineStyle: underlineStyle.rawValue])
    }

    public func withUnderlineColor(_ underlineColor: UIColor) -> Attributes {
        return withUpdatedAttributes([NSAttributedStringKey.underlineColor: underlineColor])
    }

    public func withLetterSpacing(_ letterSpacing: CGFloat) -> Attributes {
        return withUpdatedAttributes([NSAttributedStringKey.kern: letterSpacing])
    }

    // MARK: Paragraph style
    private func editableParagraphStyle() -> NSMutableParagraphStyle {
        return ((attributes[NSAttributedStringKey.paragraphStyle] as? NSParagraphStyle)?.mutableCopy() as? NSMutableParagraphStyle) ?? NSMutableParagraphStyle()
    }
    
    public func withUpdatedParagraphStyle(_ paragraphStyle: NSParagraphStyle) -> Attributes {
        return withUpdatedAttributes([NSAttributedStringKey.paragraphStyle: paragraphStyle])
    }

    public func withLineHeight(_ lineHeight: CGFloat) -> Attributes {
        let newParagraphStyle = editableParagraphStyle()
        newParagraphStyle.minimumLineHeight = lineHeight
        newParagraphStyle.maximumLineHeight = lineHeight

        return withUpdatedParagraphStyle(newParagraphStyle)
    }

    public func withLineSpacing(_ lineSpacing: CGFloat) -> Attributes {
        let newParagraphStyle = editableParagraphStyle()
        newParagraphStyle.lineSpacing = lineSpacing
        
        return withUpdatedParagraphStyle(newParagraphStyle)
    }
    
    public func withAlignment(_ alignment: NSTextAlignment) -> Attributes {
        let newParagraphStyle = editableParagraphStyle()
        newParagraphStyle.alignment = alignment
        
        return withUpdatedParagraphStyle(newParagraphStyle)
    }
}

extension Dictionary {
    
    func updated(with dictionary: Dictionary) -> Dictionary {
        var updatedDictionary = self
        
        for (key, value) in dictionary {
            updatedDictionary.updateValue(value, forKey: key)
        }
        
        return updatedDictionary
    }
    
}

