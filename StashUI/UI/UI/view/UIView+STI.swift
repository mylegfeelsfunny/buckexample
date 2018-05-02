//
//  UIView+Ext.swift
//  StashInvest
//
//  Created by Scott Jones on 6/21/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

extension UIView {

    public class func fromNib<T : UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }

    public func animateConstraintChanges(withDuration duration: TimeInterval, animations: () -> Void) {
        animations()

        UIView.animate(withDuration: duration, animations: {
            self.layoutIfNeeded()
        })
    }
}

extension UIView {
    public typealias DropShadowControls = (hide: () -> Void, show: () -> Void)

    @discardableResult
    public func addDropShadow() -> DropShadowControls {
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: bounds.size.width + 3, height: bounds.size.height + 3))
        layer.cornerRadius = 8
        layer.shadowColor = UIColor(r: 26, g: 35, b: 126).cgColor
        layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        layer.shadowOpacity = 0.27

        layer.shadowRadius = 8
        layer.shadowPath = shadowPath.cgPath
        layer.masksToBounds = false

        return (hide: { [weak self] in self?.layer.shadowOpacity = 0 },
                show: { [weak self] in self?.layer.shadowOpacity = 0.27 })
    }
}
