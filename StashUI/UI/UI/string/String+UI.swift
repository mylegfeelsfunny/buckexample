//
//  String+UI.swift
//  StashInvest
//
//  Created by Scott Jones on 3/29/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

extension String {
    
    public func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(boundingBox.height)
    }
    
    public func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    public func image(_ complete: (UIImage?) -> Void) {
        guard let dataDecoded = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            complete(nil)
            return
        }
        complete(UIImage(data: dataDecoded))
    }
    
    public func attributedStyle(font: UIFont = .body3, textColor: UIColor = .stashDarkFont, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let style = Attributes().withFont(font).withForegroundColor(textColor).withAlignment(alignment)
        return NSAttributedString(string: self, attributes: style.attributes)
    }

}

extension NSString {
    
    public func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        return String(self).heightWithConstrainedWidth(width, font: font)
    }
    
    public func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        return String(self).widthWithConstrainedHeight(height, font: font)
    }
    
    public func formattedToPhoneNumber() -> NSString {
        return NSString(string: String(self).formattedToPhoneNumber())
    }
    
    public func unformattedPhoneNumber() -> NSString {
        return NSString(string: String(self).unformattedPhoneNumber())
    }

    public static func style(text: String, font: UIFont = .body3, textColor: UIColor = .stashDarkFont, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let style = Attributes().withFont(font).withForegroundColor(textColor).withAlignment(alignment)
        return NSAttributedString(string: text, attributes: style.attributes)
    }

}

extension NSAttributedString {
    
    public func heightWithConstrainedWidth(_ width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
    
    public func widthWithConstrainedHeight(_ height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.width)
    }
    
}
