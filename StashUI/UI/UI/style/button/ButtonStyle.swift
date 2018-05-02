//
//  ButtonStyle.swift
//  StashUI
//
//  Created by Dawid Skiba on 2/8/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import UIKit

public enum ButtonStyle {
    
    case primary
    case secondary
    case dismiss
    case defaultShare
    case share(UIColor, UIColor)
    case remove
    case underlined(UIColor)
    case custom(ButtonModel)
    case hollow(UIColor)
    case clear(UIColor)
    
    public var model: ButtonModel {
        switch self {
        case .primary:
            return ButtonModel.primary
        case .secondary:
            return ButtonModel.secondary
        case .dismiss:
            return ButtonModel.dismiss
        case .defaultShare:
            return ButtonModel.defaultShare
        case .share(let textColor, let backgroundColor):
            return ButtonModel.share(textColor: textColor, backgroundColor: backgroundColor)
        case .remove:
            return ButtonModel.remove
        case .underlined(let textColor):
            return ButtonModel.underlined(textColor: textColor)
        case .custom(let style):
            return style
        case .hollow(let color):
            return ButtonModel.hollow(color: color)
        case .clear(let color):
            return ButtonModel.clear(textColor: color)
        }
    }
    
    public var description: String {
        switch self {
        case .share:
            return "customShare"
        case .custom:
            return "customButtonStyle"
        case .underlined:
            return "underlined"
        case .hollow:
            return "hollow"
        case .clear:
            return "clear"
        default:
            return String(describing: self)
        }
    }
    
}

public enum EdgeType {
    case sharp
    case semicircle
    case round
    case custom(radius: CGFloat)
    
    public static var defaultOne: EdgeType {
        return .semicircle
    }
    
    func cornerRadius(_ view: UIView) -> CGFloat {
        switch self {
        case .custom(let v):
            return v
        case .semicircle:
            return view.frame.height / 2
        case .round:
            return 8
        case .sharp:
            return 0
        }
    }
    
}

public struct ButtonModel {
    
    public var font: UIFont
    public var numberOfLines: Int = 1
    public var textAlignment = NSTextAlignment.center
    public var edgeType = EdgeType.defaultOne
    public var textColor: UIColor
    public var color: UIColor
    public var borderColor: UIColor = .clear
    public var borderWidth: CGFloat = .leastNormalMagnitude
    
    public init(font: UIFont, textColor: UIColor, backgroundColor: UIColor? = nil, edgeType: EdgeType = EdgeType.defaultOne, borderColor: UIColor = .clear, borderWidth: CGFloat = .leastNormalMagnitude) {
        self.font = font
        self.textColor = textColor
        self.color = backgroundColor ?? .clear
        self.edgeType = edgeType
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
    
    public static var primary: ButtonModel {
        return ButtonModel(font: .buttonTitle,
                           textColor: .white,
                           backgroundColor: .stashYellow,
                           edgeType: .defaultOne)
    }
    
    public static var secondary: ButtonModel {
        return ButtonModel(font: .buttonTitle,
                           textColor: .white,
                           backgroundColor: .stashPurple,
                           edgeType: .defaultOne)
    }
    
    public static var defaultShare: ButtonModel {
        return ButtonModel.share(textColor: .white, backgroundColor: .stashYellow)
    }
    
    public static var dismiss: ButtonModel {
        return .clear(textColor: UIColor.stashGray(116))
    }
    
    public static var remove: ButtonModel {
        return ButtonModel(font: .buttonTitle,
                           textColor: .white,
                           backgroundColor: .stashRed,
                           edgeType: .defaultOne)
    }
    
    public static func share(textColor: UIColor, backgroundColor: UIColor) -> ButtonModel {
        return ButtonModel(font: .buttonTitle,
                           textColor: textColor,
                           backgroundColor: backgroundColor,
                           edgeType: .defaultOne)
    }
    
    public static func underlined(textColor: UIColor) -> ButtonModel {
        return ButtonModel(font: .buttonTitle,
                           textColor: textColor,
                           backgroundColor: nil,
                           edgeType: .defaultOne)
    }
    
    public static func hollow(color: UIColor) -> ButtonModel {
        return ButtonModel(font: .buttonTitle,
                           textColor: color,
                           backgroundColor: .clear,
                           edgeType: .defaultOne,
                           borderColor: color,
                           borderWidth: 2)
    }
    
    public static func clear(textColor: UIColor) -> ButtonModel {
        return ButtonModel(font: .buttonTitle,
                           textColor: textColor,
                           backgroundColor: .clear,
                           edgeType: .defaultOne)
    }
    
}
