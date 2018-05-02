//
//  KeyboardObserver.swift
//  StashInvest
//
//  Created by Dawid Skiba on 7/11/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

public typealias KOShowClosure = (Double, CGFloat) -> Void
public typealias KOHideClosure = (Double) -> Void

private let kAnimationDuration = 0.25

public class KeyboardObserver {
    
    /**
     A closure that will be called each time keyboard appears.
     - Double: animation duration
     - CGFloat: height of keyboard
     */
    public var showClosure: KOShowClosure?
    /**
     A closure that will be called each time keyboard dissapears.
     - Double: animation duration
     */
    public var hideClosure: KOHideClosure?
    public var observe: Bool = false {
        didSet {
            if oldValue == observe { return }
            observe ? self.addNotificationForKeyboard() : self.removeNotificationForKeyboard()
        }
    }
    
    
    public init() { /* NADA */ }
    public init(showClosure: KOShowClosure?, hideClosure: KOHideClosure?) {
        self.showClosure = showClosure
        self.hideClosure = hideClosure
    }
    
    deinit {
        self.removeNotificationForKeyboard()
        self.showClosure = nil
        self.hideClosure = nil
    }

    // MARK: KeyboarStuff
    func addNotificationForKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func removeNotificationForKeyboard() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if let closure = self.showClosure {
                closure(kAnimationDuration, keyboardSize.height)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        if let closure = self.hideClosure {
            closure(kAnimationDuration)
        }
    }
}
