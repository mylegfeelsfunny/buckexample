//
//  KeypadButtonModel.swift
//  StashInvest
//
//  Created by Scott Jones on 12/11/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

private let kDefaultFont: UIFont = .headline2

public struct KeypadButtonModel {
    public enum Style {
        case light
        case dark
        case gray
        
        var labelStyle: LabelStyle {
            switch self {
            case .light:
                return LabelStyle(kDefaultFont, .white, 1, .center)
            case .dark:
                return LabelStyle(kDefaultFont, .black, 1, .center)
            case .gray:
                return LabelStyle(kDefaultFont, .stashGray(130), 1, .center)
            }
        }
        
        static var defaultStype: Style {
            return .light
        }
    }

    public enum DisplayValue: ExpressibleByStringLiteral {
        case templatedIcon(Image)
        case icon(Image)
        case text(String)

        public init(stringLiteral value: String) {
            self = .text(value)
        }
    }

    public let style: KeypadButtonModel.Style
    public let displayValue: DisplayValue
    public let value: String?

    public init(displayValue: DisplayValue, value: String? = nil, style: KeypadButtonModel.Style = .light) {
        self.displayValue           = displayValue
        self.value                  = value
        self.style = style
    }
}

public enum KeypadButtonTypes {
    case period
    case delete
    case dismissKeyboard
    case touchId
    case faceId
    case empty

    public func model(forStyle style: KeypadButtonModel.Style) -> KeypadButtonModel {
        switch self {
        case .period:
            return KeypadButtonModel(displayValue: .text(String(MoneyKeypadBrain.CustomCharacters.period)), value: String(MoneyKeypadBrain.CustomCharacters.period), style: style)
        case .dismissKeyboard:
            return KeypadButtonModel(displayValue: .templatedIcon(.keyboardKeypad), value: String(MoneyKeypadBrain.CustomCharacters.dismiss), style: style)
        case .delete:
            return KeypadButtonModel(displayValue: .icon(style == .light ? .keypadDeleteWhite : .keypadDeleteBlack), value: String(MoneyKeypadBrain.CustomCharacters.delete))
        case .touchId:
            return KeypadButtonModel(displayValue: .templatedIcon(.touchId), value: String(MoneyKeypadBrain.CustomCharacters.delete), style: style)
        case .faceId:
            return KeypadButtonModel(displayValue: .templatedIcon(.faceId), value: String(MoneyKeypadBrain.CustomCharacters.delete), style: style)
        default:
            return KeypadButtonModel(displayValue: "", value: nil)
        }
    }
}

extension KeypadButtonModel {

    var accessibilityIdentifier: String? {
        return value
    }
   
    var accessibilityLabel: String {
        switch displayValue {
        case .text(let string):
            return string
        case .icon(let icon):
            return icon.rawValue
        case .templatedIcon(let icon):
            return icon.rawValue
        }
    }

}

