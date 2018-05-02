//
//  UISwitch+STI.swift
//  AFNetworking
//
//  Created by Anton Gladkov on 3/19/18.
//

import UIKit

private var key = "StashInvest.UISwitch.didSwitch"

extension UISwitch {
    public typealias On = Bool

    public var didSwitch: ((UISwitch) -> Void)? {
        get {
            return objc_getAssociatedObject(self, &key) as? ((UISwitch) -> Void)
        }

        set {
            objc_setAssociatedObject(self, &key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            removeTarget(nil, action: nil, for: .valueChanged)
            addTarget(self, action: #selector(didChangeValue(_:)), for: .valueChanged)
        }
    }
}

private extension UISwitch {

    @objc func didChangeValue(_ switch: UISwitch) {
        didSwitch?(`switch`)
    }
}


