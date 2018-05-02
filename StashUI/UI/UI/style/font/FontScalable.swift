//
//  FontScalable.swift
//  StashInvest
//
//  Created by Scott Jones on 10/12/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

extension UILabel {
    public var deviceScaled: Bool {
        set {
            if newValue {
                if let currentFont = self.font {
                    self.font = currentFont.withSize(currentFont.pointSize.deviceScaled)
                }
            }
        }
        get {
            return false
        }
    }
}

extension UITextField {
    public var deviceScaled: Bool {
        set {
            if newValue {
                if let currentFont = self.font {
                    self.font = currentFont.withSize(currentFont.pointSize.deviceScaled)
                }
            }
        }
        get {
            return false
        }
    }
}

extension CGFloat {
    
    public var deviceScaled: CGFloat {
        return self * UIDevice.scale
    }
    
}

public enum DeviceSize {
    case iphone4S
    case iphone5
    case iphone6
    case iphone6Zoomed
    case iphone6Plus
    case iphone6PlusZoomed
    case iphoneX
    case unsupported
}

extension UIDevice {
    
    public static var commonMargin: CGFloat {
        switch self.deviceSize {
        case .iphone5, .iphone4S:
            return 16
        default:
            return 24
        }
    }
    
    public static var scale: CGFloat {
        struct SecretDevice {
            static let size = UIDevice.deviceSize
        }
        struct SecretScale {
            static let scale = UIDevice.scale(device: SecretDevice.size)
        }
        return SecretScale.scale
    }
    
    public static func scale(device: DeviceSize) -> CGFloat {
        switch device {
        case .iphone4S:
            return 0.857
        case .iphone6, .iphone6PlusZoomed:
            return 1
        case  .iphone5, .iphone6Zoomed, .unsupported:
            return 0.857
        case .iphone6Plus:
            return 1
        case .iphoneX:
            return 1
        }
    }

    public static var deviceSize: DeviceSize {
        let idiom           = UIDevice.current.userInterfaceIdiom
        if idiom != .phone { return .unsupported }
        let height          = UIScreen.main.bounds.size.height
        let scale           = UIScreen.main.scale
        let nativeScale     = UIScreen.main.nativeScale
        if height == 568.0 {
            return .iphone5
        }
        if nativeScale != scale {
            if height == 568.0 {
                return .iphone6Zoomed
            }
            if height == 667.0 {
                return .iphone6PlusZoomed
            }
            if height == 736.0 {
                return .iphone6Plus
            }
            if height == 812.0 {
                return .iphoneX
            }
        } else {
            if height == 667.0 {
                return .iphone6
            }
            if height == 736.0 {
                return .iphone6Plus
            }
            if height == 812.0 {
                return .iphoneX
            }
        }
        return .iphone4S
    }
   
    public static var isIPhoneX: Bool {
        return deviceSize == .iphoneX
    }
    
    public static var isSmallerThaniPhone6: Bool {
        let size = deviceSize
        return size == .iphone5 || size == .iphone4S
    }

}
