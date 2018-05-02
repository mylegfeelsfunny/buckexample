//
//  BannerTableViewCell.swift
//  BannerStack
//
//  Created by Scott Jones on 11/16/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

class BannerTableViewCell: UITableViewCell {
    
    static let Identifier:String        = "BannerTableViewCell"
    static let DidSwipeUpNotification:String = "BannerTableViewCellSwipeNotification"
    static var Height:CGFloat {
        return UIScreen.main.bounds.height * 0.102
    }
    
    @IBOutlet var titleLabel:UILabel?
    @IBOutlet var opaqueView: UIView?
    @IBOutlet var titleHeightConstraint: NSLayoutConstraint?
    @IBOutlet var inBetweenConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        opaqueView?.backgroundColor     = .black
        
        titleLabel?.numberOfLines       = 0
        titleLabel?.textColor           = .white
        titleLabel?.numberOfLines       = 0
        
//        titleLabel?.isUserInteractionEnabled = false
//        opaqueView?.isUserInteractionEnabled = false
//        contentView.isUserInteractionEnabled = false
//        isUserInteractionEnabled = false
        
        contentView.backgroundColor     = .clear
        backgroundColor                 = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {}
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    func configureCell(response:SuccessResponse) {
        contentView.backgroundColor     = .clear
        titleLabel?.font                = response.font
        titleLabel?.text                = response.message
        titleHeightConstraint?.constant = response.height()
        opaqueView?.backgroundColor     = response.backgroundColor
    }
    
}
