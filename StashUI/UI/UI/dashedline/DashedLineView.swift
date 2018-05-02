//
//  DashedLineView.swift
//  stash-invest-ios
//
//  Created by Dawid Skiba on 7/24/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public let kDefaultDashWidth: CGFloat = 6.0
public let kDefaultDashColor: UIColor = .white

public class DashedLineView: UIView {
    public var dashIdealWidth: CGFloat = kDefaultDashWidth {
        didSet {
            if oldValue == dashIdealWidth { return }
            setNeedsDisplay()
        }
    }
    public var dashColor: UIColor = kDefaultDashColor {
        didSet {
            if oldValue == dashColor { return }
            setNeedsDisplay()
        }
    }

    
    // MARK: Init
    public init(withDashColor color: UIColor = kDefaultDashColor, idealDashWidth: CGFloat = kDefaultDashWidth, frame: CGRect = CGRect.zero) {
        dashColor = color
        dashIdealWidth = idealDashWidth
        
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Overrides
    override public func layoutSubviews() {
        super.layoutSubviews()
        // for when it resizes
        setNeedsDisplay()
    }
    
    override public func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.minX, y: bounds.midY))
        path.addLine(to: CGPoint(x: bounds.maxX, y: bounds.midY))
        
        let dashWidth = (dashIdealWidth >= bounds.width) ? bounds.width : dashIdealWidth
        path.setLineDash([dashWidth], count: 1, phase: 0)
        
        path.lineWidth = self.bounds.height
        self.dashColor.setStroke()
        path.stroke()
    }
}


// PRIVATES
private extension DashedLineView {
    func setup() {  // shared set up
        clipsToBounds = true
    }
}


extension DashedLineView {
    public func genericSetupWhite() {
        dashIdealWidth = 6.0
        dashColor = UIColor.white
        backgroundColor = .clear
    }
    
    public func genericSetupGray() {
        dashIdealWidth = 6.0
        dashColor = UIColor.stashGray(174.0)
        backgroundColor = .clear
    }
}
