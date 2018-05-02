//
//  STISecureTextField.swift
//  StashInvest
//
//  Created by Scott Jones on 6/7/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class STISecureTextField: STICheckTextField {
    
    static let topInset: CGFloat                        = UIScreen.main.bounds.height * 0.036
    static let bottomInset: CGFloat                     = UIScreen.main.bounds.height * 0.008
    static let leftInset: CGFloat                       = UIScreen.main.bounds.width * 0.098
    static let securePadding: CGFloat                   = UIScreen.main.bounds.width * 0.05
    var secureButton: UIButton!
    var paddLockLabel: UILabel!
    var paddLockLayer                                   = CAShapeLayer()
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: STISecureTextField.leftInset + STISecureTextField.securePadding, y:STISecureTextField.topInset, width: bounds.width - (STISecureTextField.leftInset + STISecureTextField.securePadding + rightViewRect(forBounds: bounds).width), height: bounds.height - (STISecureTextField.topInset + STISecureTextField.bottomInset) )
    }
    
    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: STISecureTextField.leftInset, height: bounds.height)
    }
    
    deinit {
        secureButton.removeTarget(self, action: #selector(toggleSecureSetting), for:.touchUpInside)
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        if useSecurityToggler {
            return CGRect(x: bounds.width - bounds.height, y: 0, width: bounds.height, height: bounds.height)
        } else {
            return CGRect.zero
        }
    }
    
    override internal func initSetup() {
        super.initSetup()
        
        layer.borderColor                               = UIColor.stashGray(184).cgColor
        layer.borderWidth                               = 1
        layer.cornerRadius                              = 4
        
        paddLockLabel                                   = UILabel(frame: CGRect.zero)
        paddLockLabel.text                              = .paddlock
        paddLockLabel.font                              = .fontAwesomeFont(ofSize: 14)
        paddLockLabel.adjustsFontSizeToFitWidth         = true
        paddLockLabel.textAlignment                     = .center
        paddLockLabel.textColor                         = UIColor.stashGray(130.0)
        leftView                                        = paddLockLabel
        leftViewMode                                    = .always
        
        checkLabel.text                                 = .secureEye
        checkLabel.textColor                            = UIColor.stashGray(130.0)
        
        secureButton                                    = UIButton(type: .custom)
        checkLabel.addSubview(secureButton)
        rightView                                       = checkLabel
        rightViewMode                                   = .always
        secureButton.addTarget(self, action: #selector(toggleSecureSetting), for:.touchUpInside)
        
        paddLockLayer.fillColor                         = UIColor.stashGray(248.0).cgColor
        layer.insertSublayer(paddLockLayer, at: 0)
        
        formatStashSecureContent()
    }
    
    public var useSecurityToggler: Bool = false {
        didSet {
            isSecureTextEntry                           = useSecurityToggler
            if useSecurityToggler == true {
                rightViewMode                           = .always
                isCheckHidden                           = false
            } else {
                rightViewMode                           = .never
            }
            updateSecurityLabel()
        }
    }
    
    override public var isValid: Bool {
        didSet {
            checkLabel.textColor                        = UIColor.stashGray(130.0)
        }
    }
    
    @objc func toggleSecureSetting() {
        isSecureTextEntry                               = !isSecureTextEntry
        updateSecurityLabel()
    }
    
    func updateSecurityLabel() {
        if isSecureTextEntry == true {
            checkLabel.text                             = .secureEye
        } else {
            checkLabel.text                             = .insecureEye
        }
        layoutIfNeeded()
    }
    
    override internal var errorFrame:CGRect {
        get {
            return CGRect(x: STISecureTextField.leftInset + STISecureTextField.securePadding, y:bounds.height + 3, width:bounds.width - (STISecureTextField.leftInset + STISecureTextField.securePadding), height:errorLayer.trueHeight + 12)
        }
    }
    
    override internal var placeholderStartFrame:CGRect {
        get {
            let y                                       = (bounds.height - placeholderLayer.trueHeight) * 0.5
            return CGRect(x: STISecureTextField.leftInset + STISecureTextField.securePadding, y: y, width: bounds.width, height: placeholderLayer.trueHeight)
        }
    }
    
    override internal var placeholderEndFrame:CGRect {
        get {
            let t:CGFloat                               = placeholderLayer.trueHeight
            return CGRect(x: STISecureTextField.leftInset + STISecureTextField.securePadding + CGFloat(1).deviceScaled, y: bounds.height / 8.0, width:bounds.width - CGFloat(1).deviceScaled, height:t)
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        bottomBorder.frame                              = CGRect.zero
        
        secureButton.frame                              = checkLabel.bounds
        checkLabel.isUserInteractionEnabled             = true
        secureButton.isUserInteractionEnabled           = true
        
        let maskframe                                   = CGRect(x:0, y: 0, width: STISecureTextField.leftInset, height: frame.height)
        let maskPath                                    = UIBezierPath(roundedRect: maskframe, byRoundingCorners: [.topLeft, .bottomLeft], cornerRadii: CGSize(width: 4.0, height: 4.0))
        paddLockLayer.path                              = maskPath.cgPath
    }
    
    public func formatStashSecureContent() {
        errorLayer                                      = LCTextLayer()
        errorBackgroundColor                            = .clear
        errorTextColor                                  = .white
        errorLayer.shadowColor                          = UIColor.black.cgColor
        errorLayer.shadowOffset                         = CGSize(width:0, height:1)
        errorLayer.shadowOpacity                        = 0.2
        errorLayer.shadowRadius                         = 2
        
        font                                            = .regularSFFont(ofSize:18)
        placeholderFont                                 = .regularSFFont(ofSize:20)
        placeholderEndFont                              = .regularSFFont(ofSize:14)
        errorFont                                       = .regularSFFont(ofSize:12)
        textAlignment                                   = .left
        
        activePlaceholderTextColor                      = .stashVibrantBlue
        inactivePlaceholderTextColor                    = .stashGray(130.0)
        activeBorderColor                               = .clear
        inactiveBorderColor                             = .clear
        textColor                                       = .stashGray(39.0)
        
        deselect()
        layoutIfNeeded()
        update()
    }
    
}
