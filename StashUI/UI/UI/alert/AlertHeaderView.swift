//
//  AlertHeaderView.swift
//  stash-invest-ios
//
//  Created by Mikael Konutgan on 1/9/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

class AlertHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var titleViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
