//
//  KeypadCollectionViewCell.swift
//  StashInvest
//
//  Created by Scott Jones on 12/11/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public class KeypadCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var numberLabel: UILabel?
    @IBOutlet weak var imageView: UIImageView?
   
    override public func awakeFromNib() {
        super.awakeFromNib()
        
        numberLabel?.adjustsFontSizeToFitWidth  = true
        numberLabel?.backgroundColor            = .clear
        numberLabel?.isUserInteractionEnabled   = false
        imageView?.isUserInteractionEnabled     = false
        
        contentView.backgroundColor             = .clear
        backgroundColor                         = .clear
        backgroundView?.backgroundColor         = .clear
    }
    
    override public var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            super.isHighlighted = newValue
            if numberLabel?.text == "" { return }
            if newValue {
                numberLabel?.backgroundColor    = UIColor(white: 1.0, alpha: 0.3)
            } else if newValue == false {
                numberLabel?.backgroundColor    = .clear
            }
        }
    }

}

public extension KeypadCollectionViewCell {
    
    func configure(for keypadButtonModel: KeypadButtonModel) {
        numberLabel?.isHidden = true
        imageView?.isHidden = true
        numberLabel?.stashalize(keypadButtonModel.style.labelStyle)

        switch keypadButtonModel.displayValue {
        case .templatedIcon(let icon):
            imageView?.image = icon.templateImage
            imageView?.isHidden = false
            imageView?.tintColor = keypadButtonModel.style.labelStyle.textColor
        case .icon(let icon):
            imageView?.image = icon.image
            imageView?.isHidden = false
        case .text(let text):
            numberLabel?.text = text
            numberLabel?.isHidden = false
            numberLabel?.textColor = keypadButtonModel.style.labelStyle.textColor
        }
        
        accessibilityLabel = keypadButtonModel.accessibilityLabel
        accessibilityIdentifier = keypadButtonModel.accessibilityIdentifier
    }
}

