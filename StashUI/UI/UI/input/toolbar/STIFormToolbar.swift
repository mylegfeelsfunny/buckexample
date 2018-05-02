//
//  STIFormToolbar.swift
//  StashInvest
//
//  Created by Scott Jones on 12/23/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

private let RightButtonTag                  = 1100
private let BackArrowButtonTag              = 1101
private let ForwardArrowButtonTag           = 1102

public class STIFormToolbar: UIToolbar {
    
    public static func toolBar(target: Any, nextSel: Selector, next: Selector, last: Selector) -> STIFormToolbar {
        let doneButton                      = UIBarButtonItem(title: "Next", style: .plain, target: target, action: nextSel)
        doneButton.tag                      = RightButtonTag
        
        let toolBar                         = toolBarBackForward(target: target, next: next, last: last)
        if let bItems = toolBar.items {
            toolBar.items                   = bItems + [doneButton]
        }
        return toolBar
    }
    
    public static func toolBar(target: Any, doneSel: Selector, next: Selector, last: Selector) -> STIFormToolbar {
        let doneButton                      = UIBarButtonItem(title: "Done", style: .plain, target: target, action: doneSel)
        doneButton.tag                      = RightButtonTag
        
        let toolBar                         = toolBarBackForward(target: target, next: next, last: last)
        if let bItems = toolBar.items {
            toolBar.items                   = bItems + [doneButton]
        }
        return toolBar
    }
    
    public static func toolBarBackForward(target: Any, next: Selector, last: Selector) -> STIFormToolbar {
        let toolbar                         = STIFormToolbar()
        toolbar.barStyle                    = .default
        toolbar.isTranslucent               = true
        toolbar.sizeToFit()
        
        let flexibleSpaceButton             = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let fixedSpaceButton                = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        
        let nextButton                      = UIBarButtonItem(image: UIImage(named: "arrow-forward-blue"), style: .plain, target: target, action: next)
        nextButton.width                    = 40.0
        nextButton.tag                      = ForwardArrowButtonTag
        let previousButton                  = UIBarButtonItem(image: UIImage(named: "arrow-back-blue"), style: .plain, target: target, action: last)
        previousButton.width                = 40.0
        previousButton.tag                  = BackArrowButtonTag
        
        toolbar.setItems([fixedSpaceButton, previousButton, fixedSpaceButton, nextButton, flexibleSpaceButton], animated: false)
        toolbar.isUserInteractionEnabled    = true
        return toolbar
    }
    
    public func changeToDoneButton(target: Any, doneSel: Selector) {
        guard var bItems = items else { return }
        let doneButton                      = UIBarButtonItem(title: "Done", style: .plain, target: target, action: doneSel)
        doneButton.tag                      = RightButtonTag
        bItems.removeLast()
        items                               = bItems + [doneButton]
    }
    
    public func changeToNextButton(target: Any, nextSel: Selector) {
        guard var bItems = items else { return }
        let doneButton                      = UIBarButtonItem(title: "Next", style: .plain, target: target, action: nextSel)
        doneButton.tag                      = RightButtonTag
        bItems.removeLast()
        items                               = bItems + [doneButton]
    }
    
    public func disableAccessoryBack() {
        backItemButton(enabled: false)
        forwardItemButton(enabled: true)
    }
    
    public func disableAccessoryForward() {
        backItemButton(enabled: true)
        forwardItemButton(enabled: false)
    }
    
    public func enableBackForwardButtons() {
        backItemButton(enabled: true)
        forwardItemButton(enabled: true)
    }
    
    fileprivate func backItemButton(enabled: Bool) {
        let buttons = items?.filter { $0.tag == BackArrowButtonTag }.compactMap { $0 }
        guard let backButton = buttons?.first else { return }
        backButton.isEnabled = enabled
    }
    
    fileprivate func forwardItemButton(enabled: Bool) {
        let buttons = items?.filter { $0.tag == ForwardArrowButtonTag }.compactMap { $0 }
        guard let nextButton = buttons?.first else { return }
        nextButton.isEnabled = enabled
    }
    
}
