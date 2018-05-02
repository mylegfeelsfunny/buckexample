//
//  BannerView.swift
//  BannerStack
//
//  Created by Scott Jones on 11/16/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public class BannerView: UIView {
    
    struct Constants {
        static let topOffset: CGFloat = 32
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewTop: NSLayoutConstraint!
    @IBOutlet weak private var tableViewHeight: NSLayoutConstraint!

    func didLoad() {
        backgroundColor             = .clear
        
        tableView?.clipsToBounds    = true
        tableView?.backgroundColor  = .clear
        tableView?.separatorStyle   = .none
        tableView?.separatorColor   = .clear
        tableView?.isPagingEnabled  = false
        tableView?.isScrollEnabled  = false
        tableView?.scrollsToTop     = false
        tableView?.backgroundView?.backgroundColor = .clear
        updateHeight(Constants.topOffset)
    }
    
    func updateHeight(_ height: CGFloat) {
        tableViewHeight?.constant = height
        layoutIfNeeded()
    }
}
