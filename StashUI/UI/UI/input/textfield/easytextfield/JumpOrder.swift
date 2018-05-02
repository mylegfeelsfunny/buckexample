//
//  JumpOrder.swift
//  UITextFieldExtensions
//
//  Created by Andrew Goodwin on 8/19/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

private struct AssociatedKeys {
    static var fri = "jumpOrder"
    static var fra = "firstResponderArray"
    static var cfri = "currentjumpOrder"
    static var mnd = "moveNextDate"
    static var mnt = "moveNextTimer"
    static var fj = "formatJump"
    static var lj = "lengthJump"
    static var fn = "formatNotification"
    static var ln = "lengthNotification"
    static var tfn = "textFormatNotification"
    static var tln = "textLengthNotification"
}

public extension UITextField {
    public var formatJump: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fj) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fj, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var lengthJump: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.lj) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.lj, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate var textLengthNotification: Any? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tln)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tln, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    fileprivate var textFormatNotification: Any? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tfn)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tfn, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public var jumpOrder: Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fri) as? Int ?? -1
        }
        set {
            if textFormatNotification != nil {
                NotificationCenter.default.removeObserver(textFormatNotification!)
            }
            textFormatNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "text.MoveNext.Format"), object: nil, queue: OperationQueue.main) { [weak self] (_) in
                guard let sSelf = self else { return }
                if sSelf.formatJump {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "firstResponder.MoveNext.Format"), object: nil)
                }
            }
            if textLengthNotification != nil {
                NotificationCenter.default.removeObserver(textLengthNotification!)
            }
            textLengthNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "text.MoveNext.MaxLength"), object: nil, queue: OperationQueue.main) { [weak self] (_) in
                guard let sSelf = self else { return }
                if sSelf.lengthJump {
                    NotificationCenter.default.post(name: Notification.Name(rawValue: "firstResponder.MoveNext.MaxLength"), object: nil)
                }
            }
            objc_setAssociatedObject(self, &AssociatedKeys.fri, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc public func getjumpOrder() -> Int {
        return jumpOrder
        //NSNotificationCenter.defaultCenter().postNotificationName("firstResponder.MoveNext", object: jumpOrder + 1)
    }
}

public extension UITextView {
    
    public var jumpOrder: Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fri) as? Int ?? -1
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fri, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc public func getjumpOrder() -> Int {
        return jumpOrder
        //NSNotificationCenter.defaultCenter().postNotificationName("firstResponder.MoveNext", object: jumpOrder + 1)
    }
}

public extension UIViewController {
    
    public var currentjumpOrder: Int {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.cfri) as? Int ?? -1
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.cfri, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    public var textInputArray: [UIView] {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fra) as? [UIView] ?? [UIView]()
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.fra,
                newValue as [UIView]?,
                objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    fileprivate var moveNextDate: Date? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.mnd) as? Date ?? nil
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.mnd, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    fileprivate var formatNotification: Any? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.fn)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.fn, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    fileprivate var lengthNotification: Any? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.ln)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.ln, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func moveNext() {
        self.moveNextDate = Date()
        for view in self.textInputArray {
            if let tf = view as? STITextField {
                if tf.jumpOrder == currentjumpOrder + 1 {
                    tf.becomeFirstResponder()
                    currentjumpOrder = tf.jumpOrder
                    break
                }
            } else if let tf = view as? UITextView {
                if tf.jumpOrder == currentjumpOrder + 1 {
                    tf.becomeFirstResponder()
                    currentjumpOrder = tf.jumpOrder
                    break
                }
            }
        }
    }
    
    public func moveLast() {
        self.moveNextDate = Date()
        for view in self.textInputArray {
            if let tf = view as? STITextField {
                if tf.jumpOrder == currentjumpOrder - 1 {
                    tf.becomeFirstResponder()
                    currentjumpOrder = tf.jumpOrder
                    break
                }
            } else if let tf = view as? UITextView {
                if tf.jumpOrder == currentjumpOrder - 1 {
                    tf.becomeFirstResponder()
                    currentjumpOrder = tf.jumpOrder
                    break
                }
            }
        }
    }
    public func findAllTextInputs() {
        self.textInputArray = [UIView]()
        if formatNotification != nil {
            NotificationCenter.default.removeObserver(formatNotification!)
        }
        formatNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "firstResponder.MoveNext.Format"), object: nil, queue: OperationQueue.main) { [weak self](_) in
            guard let sSelf = self else { return }
            if sSelf.moveNextDate == nil {
                //nothing has fired before
                sSelf.moveNext()
            } else if sSelf.moveNextDate != nil {
                if abs(sSelf.moveNextDate!.timeIntervalSinceNow) < 0.1 {
                    //do nothing
                } else {
                    sSelf.moveNext()
                }
            }
        }
        if lengthNotification != nil {
            NotificationCenter.default.removeObserver(lengthNotification!)
        }
        lengthNotification = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "firstResponder.MoveNext.MaxLength"), object: nil, queue: OperationQueue.main) { [weak self](_) in
            guard let sSelf = self else { return }
            if sSelf.moveNextDate == nil {
                //nothing has fired before
                sSelf.moveNext()
            } else if sSelf.moveNextDate != nil {
                if abs(sSelf.moveNextDate!.timeIntervalSinceNow) < 0.1 {
                    //do nothing
                } else {
                    sSelf.moveNext()
                }
            }
        }
        findAllTextInputsInView(self.view)
    }
    
    fileprivate func findAllTextInputsInView(_ inputView: UIView) {
        for view in inputView.subviews {
            if view.responds(to: #selector(UITextField.getjumpOrder)) || view.responds(to: #selector(UITextView.getjumpOrder)) {
                if view is UITextField {
                    textInputArray.append(view)
                    if view.subviews.count > 0 {
                        findAllTextInputsInView(view)
                    }
                }
            }
        }
    }
}
