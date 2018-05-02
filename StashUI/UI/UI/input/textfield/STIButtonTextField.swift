//
//  STIButtonTextField.swift
//  StashInvest
//
//  Created by Dawid Skiba 🥑 on 8/25/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public typealias STIButtonStateAction = ((STIButtonTextField, UIButton) -> Void)
public typealias STIButtonTextFieldStateAction = (text: String, action: STIButtonStateAction?)

private let kButtonDefaultSize = CGSize(width: 80, height: 30)

public class STIButtonTextField: STITextField {
    public let button = UIButton(type: .custom)
    public var normalStateAction: STIButtonTextFieldStateAction {
        didSet {
            button.setTitle(normalStateAction.text, for: .normal)
        }
    }
    public var selectedStateAction: STIButtonTextFieldStateAction? {
        didSet {
            button.setTitle(selectedStateAction?.text, for: .selected)
        }
    }
    public var isRoundedStashBorder: Bool = true {
        didSet {
            if oldValue == isRoundedStashBorder { return }
            updateButton()
        }
    }
    public var unselectButtonWhenResignResponser = true
    
    // class shite
    static var defaultNormatStateAction: STIButtonTextFieldStateAction {
        return (text: "STASH", action: nil)
    }
    
    // MARK: Init
    public init() {
        self.normalStateAction = STIButtonTextField.defaultNormatStateAction
        super.init(frame: CGRect.zero)
    }
    
    public init(normalStateAction: STIButtonTextFieldStateAction, frame: CGRect = CGRect.zero) {
        self.normalStateAction = normalStateAction
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        self.normalStateAction = STIButtonTextField.defaultNormatStateAction
        super.init(coder: aDecoder)
    }
    
    
    // MARK: Override
    override public var activeBorderColor: UIColor {
        didSet {
            updateButton()
            update()
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        button.layer.cornerRadius = isRoundedStashBorder ? button.bounds.height/2.0 : 0.0
    }
    
    override internal func initSetup() {
        super.initSetup()
        
        clearButtonMode = .never
        button.titleLabel?.font = .body3
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: kButtonDefaultSize.width, height: kButtonDefaultSize.height)
        rightViewMode = .never
        rightView = button
        rightView?.frame = rightViewRect(forBounds: button.bounds)
        addTarget(self, action: #selector(updateRightViewMode), for: .editingChanged)
        button.backgroundColor = UIColor.clear
        updateButton()
    }
    
    override public func becomeFirstResponder() -> Bool {
        let becameResponder = super.becomeFirstResponder()
        if becameResponder {
            updateRightViewMode()
        }
        return becameResponder
    }
    
    override public func resignFirstResponder() -> Bool {
        let resigned = super.resignFirstResponder()
        if resigned {
            rightViewMode = .never
            if unselectButtonWhenResignResponser {
                button.isSelected = false
                if let closure = selectedStateAction?.action {
                    closure(self, button)
                }
            }
        }
        
        return resigned
    }
    
    // MARK: Other
    @objc internal func updateRightViewMode() {
        rightViewMode = (text ?? "").isEmpty ? .never : .always
    }
    
    internal func updateButton() {
        button.setTitleColor(activePlaceholderTextColor, for: .normal)
        button.layer.cornerRadius = isRoundedStashBorder ? button.bounds.height/2.0 : 0.0
        button.layer.borderColor = isRoundedStashBorder ? activePlaceholderTextColor.cgColor : UIColor.clear.cgColor
        button.layer.borderWidth = isRoundedStashBorder ? 1.0 : 0.0
    }
    
    @objc internal func buttonPressed() {
        let action: STIButtonStateAction?
        if button.isSelected {
            action = selectedStateAction?.action
        } else {
            action = normalStateAction.action
        }

        // 🥑 / call that closure boii
        if let closure = action {
            closure(self, button)
        }
        
        // yes this goes last, action should be based state before it is changed
        button.isSelected = !button.isSelected
    }
}
