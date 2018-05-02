//
//  KeypadCollectionView.swift
//  stash-invest-ios
//
//  Created by Scott Jones on 1/27/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class KeypadCollectionView: UICollectionView {

    let linesView                           = KeypadLinesView(frame: CGRect.zero)
    public var isLinesViewHidden            = true {
        didSet {
            linesView.isHidden = isLinesViewHidden
        }
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        isScrollEnabled                     = false
        isPagingEnabled                     = false
        
        linesView.backgroundColor           = .clear
        backgroundView                      = UIView()
        backgroundView?.addSubview(linesView)
        backgroundView?.backgroundColor     = .clear
        backgroundColor                     = .clear
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
       
        backgroundView?.frame               = self.bounds
        linesView.frame                     = self.bounds
    }
    
}
    
