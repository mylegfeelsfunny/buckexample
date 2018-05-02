//
//  SecureLabel.swift
//  StashInvest
//
//  Created by Scott Jones on 7/15/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class SecureLabel:  UILabel {
    
    public func setAsSecure() {
        backgroundColor                     = UIColor(red: 216.0 / 255.0, green: 216.0 / 255.0, blue: 216.0 / 255.0, alpha: 0.5)
        let check: String                   = .paddlock
        let localizedSecure                 = NSLocalizedString("Secure", comment: "Secure Label")
        let fullString                      = NSString(format:"\(check) \(localizedSecure)" as NSString)
        
        let gray                            = UIColor(red: 39.0 / 255.0, green: 39.0 / 255.0, blue: 39.0 / 255.0, alpha: 1.0)
        
        let paragraph                       = NSMutableParagraphStyle()
        paragraph.alignment                 = .center
        paragraph.lineHeightMultiple        = -5
        
        let awesomeAtt:[NSAttributedStringKey: Any]         = [
            NSAttributedStringKey.font             : UIFont.fontAwesomeFont(ofSize: 10),
            NSAttributedStringKey.foregroundColor  : gray,
            NSAttributedStringKey.paragraphStyle   : paragraph
        ]
        let regularAtt:[NSAttributedStringKey: Any]         = [
            NSAttributedStringKey.font             : UIFont.caption2,
            NSAttributedStringKey.foregroundColor  : gray,
            NSAttributedStringKey.paragraphStyle   : paragraph
        ]
        let rangeAwesome                    = NSMakeRange(0, 1)
        let rangeRegular                    = fullString.range(of: localizedSecure )
        
        let attString                       = NSMutableAttributedString(string:fullString as String)
        attString.setAttributes(awesomeAtt, range: rangeAwesome)
        attString.setAttributes(regularAtt, range: rangeRegular)
        attributedText                      = attString
        numberOfLines                       = 0
        
        let height                          = UIScreen.main.bounds.height * 0.038
        layer.cornerRadius                  = height * 0.5
        clipsToBounds                       = true
    }
    
    public override func drawText(in rect: CGRect) {
        if let stringText = attributedText?.string {
            let stringTextAsNSString        = stringText as NSString
            let constraintRect              = CGSize(width: self.frame.width, height: CGFloat.greatestFiniteMagnitude)
            let boundingBox                 = stringTextAsNSString.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
            let x                           = (frame.width * 0.5) - (boundingBox.width * 0.5)
            let y                           = (frame.height * 0.5) - (boundingBox.height * 0.5)
            super.drawText(in: CGRect(x: x, y: y - 2, width: boundingBox.width, height: boundingBox.height))
        } else {
            super.drawText(in: rect)
        }
    }
    
}
