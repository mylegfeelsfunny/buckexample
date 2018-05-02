//
//  RadialGradientView.swift
//  stash-invest-ios
//
//  Created by Scott Jones on 1/27/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import CoreGraphics

public class KeypadLinesView: UIView {

    public var rows: CGFloat            = 4 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var columns: CGFloat         = 3 {
        didSet {
            setNeedsDisplay()
        }
    }

    public var tColor                  = UIColor(white: 1.0, alpha: 0.7) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    fileprivate var lines: [CAGradientLayer] = []
    
    override public func draw(_ rect: CGRect) {
        for l in lines {
            l.removeFromSuperlayer()
        }
        lines.removeAll()
       
        let width               = self.frame.width / columns
        let height              = self.frame.height / rows
        
        let buildLine:(_ f: CGRect, _ p: CGPoint) -> Void = { [weak self] f, p in
            let line            = CAGradientLayer()
            line.startPoint     = CGPoint.zero
            line.endPoint       = p
            line.locations      = [NSNumber(value:0.03), NSNumber(value:0.25), NSNumber(value:0.75), NSNumber(value:0.97)]
            line.frame          = f
            guard let strongSelf = self else { return }
            line.colors         = [strongSelf.tColor.withAlphaComponent(0.0).cgColor, strongSelf.tColor.cgColor, strongSelf.tColor.cgColor, strongSelf.tColor.withAlphaComponent(0.0).cgColor]
            strongSelf.layer.addSublayer(line)
            strongSelf.lines.append(line)
        }
        
        for i in 1..<Int(columns) {
            let x               = (CGFloat(i) * width)
            buildLine(CGRect(x: x, y: 0, width:1, height: frame.height), CGPoint(x:0, y:1))
        }
        for i in 1..<Int(rows) {
            let y               = (CGFloat(i) * height)
            buildLine(CGRect(x: 0, y: y, width: frame.width, height:1), CGPoint(x:1, y:0))
        }
    }
    
}
