//
//  MenuCollectionCell.swift
//  StashInvest
//
//  Created by Scott Jones on 10/9/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public class MenuCollectionCell: UICollectionViewCell {
    @IBOutlet public weak var textLabel: UILabel!
    fileprivate var textColor: UIColor = UIColor.white
    
    static var reuseIdentifier: String = "MenuCollectionCell"
    static var font: UIFont = .title2
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor             = .clear
        backgroundColor                         = .clear
        textLabel.adjustsFontSizeToFitWidth   = true
        textLabel.textColor                   = textColor.withAlphaComponent(0.50)
        textLabel.font                        = MenuCollectionCell.font
    }
    
    public override var isSelected: Bool {
        get { return super.isSelected }
        set {
            if newValue {
                super.isSelected                = true
                textLabel.textColor           = textColor
            } else if newValue == false {
                super.isSelected                = false
                textLabel.textColor           = textColor.withAlphaComponent(0.50)
            }
        }
    }
}

extension MenuCollectionCell {
    public func configure(for menuLabel: MenuLabel) {
        textLabel.text                          = menuLabel.name
        self.accessibilityLabel                 = menuLabel.label
        self.accessibilityIdentifier            = menuLabel.identifier
        textLabel.font                          = menuLabel.font
        textColor                               = menuLabel.textColor
        textLabel.textColor                     = textColor
        
        if isSelected {
            textLabel.textColor                 = textColor
        } else {
            textLabel.textColor                 = textColor.withAlphaComponent(0.50)
        }
    }
}
