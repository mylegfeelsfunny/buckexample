//
//  UIButton+STI.swift
//  StashUI
//
//  Created by Dawid Skiba on 1/24/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import UIKit

private var key = "StashInvest.UIButton.didTap"

public typealias ButtonTapClosure = ((UIButton) -> Void)

extension UIButton {

    public var didTap: ButtonTapClosure? {
        get {
            return objc_getAssociatedObject(self, &key) as? ButtonTapClosure
        }
        
        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            removeTarget(nil, action: nil, for: .touchUpInside)
            addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        }
    }
    
    public func glossarize(tintColor tint: UIColor) {
        tintColor = tint
        setTitleColor(tint, for: .normal)
        
        let image = UIImage(named: "glossary-question-icon-white")?.withRenderingMode(.alwaysTemplate)
        setImage(image, for: .normal)
        setImage(image, for: .highlighted)
        
        transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -4.0, bottom: 0.0, right: 4.0)
    }
    
    public func setBackgroundColor(_ color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()?.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
}

private extension UIButton {
    @objc func didTapButton(_ button: UIButton) {
        didTap?(button)
    }
}
