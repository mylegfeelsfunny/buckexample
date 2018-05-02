//
//  CircularView.swift
//  StashInvest
//
//  Created by Dawid Skiba on 8/30/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class CircularView: UIImageView {
    // MARK: Overide
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        // the image view should be a square, but if not, then min of width/height
        self.layer.cornerRadius = min(self.bounds.height, self.bounds.width)/2.0
    }
    
    // MARK: Private
    private func setup() {
        self.clipsToBounds = true
    }
}
