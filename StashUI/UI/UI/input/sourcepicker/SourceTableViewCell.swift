//
//  SourceTableViewCell.swift
//  BankPicker
//
//  Created by Scott Jones on 11/21/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {

    static let Identifier                   = "SourceTableViewCell"
    static var Height:CGFloat {
        return UIScreen.main.bounds.height * 0.073
    }
    
    @IBOutlet var titleLabel:UILabel?
    @IBOutlet var separator:UIView?

    var backgroundLabelColor:UIColor        = .clear
    var backgroundLabelSelectedColor:UIColor = .stashTeel
    var fontColor:UIColor                   = .stashBlue
    var fontSelectedColor:UIColor           = .white
    
    override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel?.backgroundColor         = backgroundLabelColor
        titleLabel?.font                    = .subtitle3
        titleLabel?.textColor               = fontColor
        separator?.backgroundColor          = .stashBlue
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            titleLabel?.backgroundColor     = backgroundLabelSelectedColor
            titleLabel?.textColor           = fontSelectedColor
        } else {
            titleLabel?.backgroundColor     = backgroundLabelColor
            titleLabel?.textColor           = fontColor
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            titleLabel?.backgroundColor     = backgroundLabelSelectedColor
            titleLabel?.textColor           = fontSelectedColor
        } else {
            titleLabel?.backgroundColor     = backgroundLabelColor
            titleLabel?.textColor           = fontColor
        }
    }
    
    func configure(object:String) {
        titleLabel?.text                    = object
    }

    
}
