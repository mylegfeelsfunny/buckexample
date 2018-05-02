//
//  MoneyKeypadBrain.swift
//  StashInvest
//
//  Created by Daniel Ramteke on 7/26/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation

public enum MoneyKeypadType {
    case standard
    case increments
    case periodless
    
    public func buttonModels(style: KeypadButtonModel.Style = .light) -> [KeypadButtonModel] {
        switch self {
        case .standard:
            return self.standardKeyboard(lowerLeft: KeypadButtonTypes.period.model(forStyle: style),
                                         lowerRight: KeypadButtonTypes.delete.model(forStyle: style),
                                         style: style)
        case .increments:
            return self.standardKeyboard(lowerLeft: KeypadButtonTypes.dismissKeyboard.model(forStyle: style),
                                         lowerRight: KeypadButtonTypes.delete.model(forStyle: style),
                                         style: style)
        case .periodless:
            return self.standardKeyboard(lowerLeft: KeypadButtonTypes.empty.model(forStyle: style),
                                         lowerRight: KeypadButtonTypes.delete.model(forStyle: style),
                                         style: style)
        }
    }
    
    private func standardKeyboard(lowerLeft: KeypadButtonModel, lowerRight: KeypadButtonModel, style: KeypadButtonModel.Style) -> [KeypadButtonModel] {
        return [
            KeypadButtonModel(displayValue: "1", value: "1", style: style),
            KeypadButtonModel(displayValue: "2", value: "2", style: style),
            KeypadButtonModel(displayValue: "3", value: "3", style: style),
            KeypadButtonModel(displayValue: "4", value: "4", style: style),
            KeypadButtonModel(displayValue: "5", value: "5", style: style),
            KeypadButtonModel(displayValue: "6", value: "6", style: style),
            KeypadButtonModel(displayValue: "7", value: "7", style: style),
            KeypadButtonModel(displayValue: "8", value: "8", style: style),
            KeypadButtonModel(displayValue: "9", value: "9", style: style),
            lowerLeft,
            KeypadButtonModel(displayValue: "0", value: "0", style: style),
            lowerRight
        ]
    }
}

class MoneyKeypadBrain {
    struct CustomCharacters {
        static let dismiss: Character = "~"
        static let delete: Character = "X"
        static let period: Character = "."
    }
    
    private static let defaultValue             = "0"
    private static let Decimal: Character       = CustomCharacters.period
    private var valueString: String             = ""
    
    let allowedCharacters: [Character]          = Array("0123456789.")
    let maxValue: Double
    let queueTyping: Bool
    
    weak var output: MoneyKeypadOutput? {
        didSet {
            output?.updatedAmount(self.amount)
        }
    }
    
    public static var DecimalString: String {
        return String(Decimal)
    }
    
    init(maxValue: Double?, queueTyping: Bool) {
        self.maxValue = maxValue ?? Double(Int32.max)
        self.queueTyping = queueTyping
    }
    
    var amount: (doubleValue: Double, displayValue: String) {
        return (doubleValue: self.doubleValue, displayValue: self.displayValue)
    }
    
    public var doubleValue: Double {
        guard let doub = Double(valueString) else {
            return 0.0
        }
        return queueTyping ? ((round(doub * 100)/100) / 100.0) : doub
    }
    
    public var rawValue: String {
        return valueString
    }
    
    public var displayValue: String {
        get {
            if queueTyping {
                return String(format: "$%.2f", self.doubleValue)
            }
            
            if valueString.count < 1 {
                return "$\(format(value: MoneyKeypadBrain.defaultValue))"
            } else {
                return "$\(format(value: valueString))"
            }
        }
    }
    
    public func enter(value: Character) {
        defer {
            output?.updatedAmount(self.amount)
        }
        if value == CustomCharacters.delete { delete(); return }
        if value == CustomCharacters.dismiss { output?.dismissPressed(); return }
        if queueTyping && value == MoneyKeypadBrain.Decimal { return }
        guard allowedCharacters.contains(value) else { return }
        if valueString.contains(MoneyKeypadBrain.Decimal) {
            if String(value) == MoneyKeypadBrain.DecimalString { return }
            if isTwoPassedDecimal { return }
        }
        if valueString == "" && value == "0" { return }
        let newValue = valueString + String(value)
        if queueTyping == false && newValue == MoneyKeypadBrain.DecimalString {
            valueString = newValue
            cleanForCharacterCount()
        }
        
        if let dValue = Double(newValue), (queueTyping ? dValue/100 : dValue) <= maxValue {
            valueString = newValue
            cleanForCharacterCount()
        }
    }

    public func reset(to amount: Decimal) {
        let multiplier: Decimal = queueTyping ? 100 : 1

        valueString = "\(amount * multiplier)"
        cleanForCharacterCount()
    }
}

private extension MoneyKeypadBrain {
    func delete() {
        let charsToDrop = valueString.last == "." ? 2 : 1
        valueString = String(valueString.dropLast(charsToDrop))
    }
    
    func format(value: String) -> String {
        if valueString.contains(MoneyKeypadBrain.Decimal) {
            let num = numPassedDecimal
            if num == 0 {
                if doubleValue == 0.0 {
                    return "0."
                } else {
                    return value
                }
            } else {
                return decimalFormat(value: doubleValue, passedDecimalndex:num)
            }
        } else {
            guard let toInt = Int64(value) else {
                return value
            }
            return "\(toInt)"
        }
    }
    
    func decimalFormat(value: Double, passedDecimalndex: Int) -> String {
        let format = "%.\(passedDecimalndex)f"
        return String(NSString(format: format as NSString, value))
    }
    
    var isTwoPassedDecimal: Bool {
        let split = valueString.components(separatedBy: MoneyKeypadBrain.DecimalString)
        if let end = split.last, end.count >= 2 {
            return true
        }
        return false
    }
    
    var numPassedDecimal: Int {
        let split = valueString.components(separatedBy: MoneyKeypadBrain.DecimalString)
        if let end = split.last {
            return end.count
        }
        return 0
    }
    

    func cleanForCharacterCount() {
        if doubleValue != maxValue {
            if valueString.contains(MoneyKeypadBrain.Decimal) {
                if valueString.count > "\(Int64(maxValue))".count + 3 {
                    valueString = String(valueString.dropLast())
                }
            } else {
                let count = queueTyping ? valueString.count - 2 : valueString.count
                if count > "\(Int64(maxValue))".count {
                    valueString = String(valueString.dropLast())
                }
            }
        }
    }
    
}
