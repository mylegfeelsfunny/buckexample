//
//  UILabel+STI.swift
//  StashInvest
//
//  Created by Scott Jones on 3/26/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

extension UILabel {
    
    public func height(forWidth width: CGFloat) -> CGFloat {
        guard  let f = font else { return 0 }
        if let t = text, t.count > 0 {
            return t.heightWithConstrainedWidth(width, font: f)
        } else {
            return 0
        }
    }
    
    public func attributedHeight(forWidth width: CGFloat) -> CGFloat {
        if let att = attributedText, att.length > 0 {
            return att.heightWithConstrainedWidth(width)
        } else {
            return 0
        }
    }
    
    public func width(forHeight height: CGFloat) -> CGFloat {
        guard  let f = font else { return 0 }
        if let t = text, t.count > 0 {
            return t.widthWithConstrainedHeight(height, font: f)
        } else {
            return 0
        }
    }
    
    public func attributedWidth(forHeight height: CGFloat) -> CGFloat {
        if let att = attributedText, att.length > 0 {
            return att.widthWithConstrainedHeight(height)
        } else {
            return 0
        }
    }
    
}
