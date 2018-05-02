//
//  UIViewHelper.swift
//  StashInvest
//
//  Created by Dawid Skiba on 8/1/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

extension UIView {
    public var currentFirstResponder: UIResponder? {
        for subV in subviews {
            if subV.isFirstResponder { return subV }
            if let deeperResponder = subV.currentFirstResponder {
                return deeperResponder
            }
        }
        return nil
    }
    
    public func shake(count: Int, value: CGFloat = 5.0, duration: Double = 0.07) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = Float(count)
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - value, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + value, y: center.y))
        self.layer.add(animation, forKey: "position")
    }
}
