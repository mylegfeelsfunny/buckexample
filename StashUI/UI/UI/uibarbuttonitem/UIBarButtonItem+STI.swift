//
//  UIBarButtonItem+STI.swift
//  StashUI
//
//  Created by Dawid Skiba on 2/2/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import UIKit

private var keyDidTap = "com.stash.stash-invest.UIBarButtonItem.didTap"

extension UIBarButtonItem {
    public var didTap: ((UIBarButtonItem) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &keyDidTap) as? ((UIBarButtonItem) -> Void)
        }
        
        set {
            objc_setAssociatedObject(self, &keyDidTap, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            self.target = self
            self.action = #selector(didTapItem(_:))
        }
    }
}

private extension UIBarButtonItem {
    @objc func didTapItem(_ item: UIBarButtonItem) {
        didTap?(item)
    }
}

extension UIBarButtonItem {
    public static func custodianRegSupport(target: Any?, action: Selector?) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: Image.supportBubble.rawValue), style: .plain, target: target, action: action)
    }
}
