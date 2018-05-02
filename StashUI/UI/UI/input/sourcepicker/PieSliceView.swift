//
//  PieSliceView.swift
//  BankPicker
//
//  Created by Scott Jones on 11/21/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

class PieSliceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor             = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor             = .clear
    }
    
    override func draw(_ rect: CGRect) {
        backgroundColor             = .clear
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.width * 0.5, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.closePath()
        
        context.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        context.fillPath()
    }
    
}
