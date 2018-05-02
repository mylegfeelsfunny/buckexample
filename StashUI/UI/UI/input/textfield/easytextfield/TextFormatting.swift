//
//  TextFormatting.swift
//
//  Created by Andrew Goodwin on 8/17/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

// swiftlint:disable cyclomatic_complexity

import Foundation
import UIKit

private struct AssociatedKeys {
    static var format = "format"
    static var fi = "fi"
    static var ld = "ld"
}

//@IBDesignable
public extension UITextField {
    //    @IBInspectable
    public var format: String {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.format) as? String ?? ""
        }
        set {
            
            let oldFormat = self.format
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.format,
                newValue as NSString,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            
            if self.text != nil && self.text!.count > 0 {
                formatChanged(oldFormat)
            }
            
        }
    }
    fileprivate var textSourceArray: [String] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ld) as? [String] ?? []
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.ld,
                newValue as [NSString]?,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    // swiftlint:disable function_body_length
    public func formatText(_ string: String) -> Bool {
        //string is the newest character to be added
        if self.format != "" && self.text != nil {
            let backspace = string == ""
            var textFieldIndex = self.text!.count > 0 ? self.text!.count - 1 : -1
            var textFieldArray = Array(self.text!)
            let newStringArray = Array(string)
            let formatArray = Array(self.format)
            var newText = ""
            if backspace == false {
                textFieldArray += newStringArray
                for _ in newStringArray {
                    if textSourceArray.count < formatArray.count {
                        if String(formatArray[textSourceArray.count]).lowercased() == "x"{
                            newText += String(textFieldArray[textFieldIndex+1])
                            textFieldIndex += 1
                            textSourceArray.append("u")
                        } else {
                            while String(formatArray[textSourceArray.count]).lowercased() != "x"{
                                if String(formatArray[textSourceArray.count]).lowercased() == "\\"{
                                    newText += "x"
                                    textSourceArray.append("e")
                                    textSourceArray.append("f")
                                } else {
                                    newText += String(formatArray[textSourceArray.count])
                                    textSourceArray.append("f")
                                }
                            }
                            newText += String(textFieldArray[textFieldIndex+1])
                            textFieldIndex += 1
                            textSourceArray.append("u")
                        }
                        
                    } else if textFieldIndex < textFieldArray.count {
                        newText += String(textFieldArray[textFieldIndex+1])
                        textFieldIndex += 1
                    }
                }
                self.text = self.text! + newText
                if self.text?.count == formatArray.count {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "text.MoveNext.Format"), object: nil)
                }
                self.sendActions(for: .editingChanged)
                return false
            } else {
                if textSourceArray.count > 0 && textFieldArray.count <= formatArray.count {
                    
                    if textSourceArray.last! == "u"{
                        textSourceArray.removeLast()
                        textFieldArray.removeLast()
                    }
                    
                    while textSourceArray.count > 0 && textSourceArray.last! != "u"{
                        textSourceArray.removeLast()
                        if textSourceArray.count > 0 && textSourceArray.last! != "e"{
                            textFieldArray.removeLast()
                        } else if textSourceArray.count == 0 && textFieldArray.count > 0 {
                            textFieldArray.removeLast()
                        }
                        
                    }
                    
                } else if textFieldArray.count > 0 {
                    textFieldArray.removeLast()
                }
                
                for ch in textFieldArray {
                    newText += String(ch)
                }
                
                self.text = newText
                self.sendActions(for: .editingChanged)
                return false
            }
        }
        
        return true
    }
    // swiftlint: enable function_body_length
    
    fileprivate func formatChanged(_ oldFormat: String?) {
        var newText = ""
        var enteredText = self.text
        enteredText = getUserEnteredCharacters(oldFormat!)
        textSourceArray = []
        var formatIndex = 0
        var enteredIndex = 0
        let enteredArray = Array(enteredText!)
        let formatArray = Array(self.format)
        while enteredIndex < enteredArray.count && formatIndex < formatArray.count {
            if String(formatArray[formatIndex]).lowercased() == "\\"{
                textSourceArray.append("e")
                textSourceArray.append("f")
                newText += "x"
                formatIndex += 2
            } else if String(formatArray[formatIndex]).lowercased() == "x"{
                newText += String(enteredArray[enteredIndex])
                enteredIndex += 1
                formatIndex += 1
                textSourceArray.append("u")
            } else {
                newText += String(formatArray[formatIndex])
                formatIndex += 1
                textSourceArray.append("f")
            }
        }
        while enteredIndex < enteredArray.count {
            newText += String(enteredArray[enteredIndex])
            enteredIndex += 1
        }
        
        self.text = newText
        
    }
    
    fileprivate func getUserEnteredCharacters(_ fromFormat: String) -> String {
        if fromFormat == ""{
            return self.text!
        }
        var enteredText = ""
        let enteredArray = Array(self.text!)
        var userEnteredIndices = [Int]()
        let _ = textSourceArray.enumerated().filter {(index, element) in
            if element == "u"{
                userEnteredIndices.append(index)
                return true
            }
            return false
        }
        for ent in userEnteredIndices {
            let char = String(enteredArray[ent])
            enteredText += char
        }
        return enteredText
    }
}
