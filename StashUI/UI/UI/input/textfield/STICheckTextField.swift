//
//  STICheckTextField.swift
//  StashInvest
//
//  Created by Dawid Skiba on 8/25/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

typealias STICheckmarkColor = (validColor: UIColor, invalidColor: UIColor)

public class STICheckTextField: STITextField {
    internal let checkLabel = UILabel(frame: CGRect.zero)
    public var checkmarkColors = STICheckmarkColor(validColor: .stashGreen, invalidColor: UIColor.stashGray(130.0).withAlphaComponent(0.3)) {
        didSet {
            if oldValue == checkmarkColors { return }
            updateCheckmark()
        }
    }
    public var isValid: Bool = false {
        didSet {
            if oldValue == isValid { return }
            updateCheckmark()
        }
    }
    public var isCheckHidden: Bool = true {
        didSet {
            if oldValue == isCheckHidden { return }
            updateCheckmark()
        }
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.width - bounds.height, y: 0, width: bounds.height, height: bounds.height)
    }
    
    override internal func initSetup() {
        super.initSetup()
        
        rightViewMode = .always
        checkLabel.font = .fontAwesomeFont(ofSize: 20)
        checkLabel.adjustsFontSizeToFitWidth = true
        checkLabel.textAlignment = .center
        checkLabel.text = .check
        isCheckHidden = true
        updateCheckmark()
    }
    
    internal func updateCheckmark() {
        checkLabel.textColor = isValid ? checkmarkColors.validColor : checkmarkColors.invalidColor
        rightView = isCheckHidden ? nil : checkLabel
    }
}
