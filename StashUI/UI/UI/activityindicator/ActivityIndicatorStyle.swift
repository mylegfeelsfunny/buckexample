//
//  ActivityIndicatorStyle.swift
//  StashUI
//
//  Created by Anton Gladkov on 3/7/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation

public struct ActivityIndicatorStyle {
    public enum OverlayStyle {
        case clear, dimmed
    }

    public let overlay: OverlayStyle
    public let background: ActivityIndicatorBackgroundStyle

    public init(overlay: OverlayStyle, background: ActivityIndicatorBackgroundStyle) {
        self.overlay = overlay
        self.background = background
    }
    
    public static var `default`: ActivityIndicatorStyle {
        return ActivityIndicatorStyle(overlay: .clear, background: .dark)
    }

    public static var clear: ActivityIndicatorStyle {
        return ActivityIndicatorStyle(overlay: .clear, background: .clear)
    }

    public static var darkAndDimmed: ActivityIndicatorStyle {
        return ActivityIndicatorStyle(overlay: .dimmed, background: .dark)
    }
}
