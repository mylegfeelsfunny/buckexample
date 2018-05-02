//
//  ClearTableViewHeader.swift
//  StashUI
//
//  Created by Dawid Skiba on 9/19/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class ClearTableViewHeader: UITableViewHeaderFooterView {
    public static var reuseIdentifier = String(describing: ClearTableViewHeader.self)
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: ClearTableViewHeader.reuseIdentifier)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        contentView.backgroundColor = .clear
        backgroundView?.backgroundColor = .clear
    }
}
