//
//  BarGraphHorizontal.swift
//  StashInvest
//
//  Created by Anton Gladkov on 9/11/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class BarGraphHorizontal: UIView {
    private var fillFraction: Double = 0.0
    public var color: UIColor = .white
    public override var bounds: CGRect {
        didSet {
            if oldValue == bounds { return }
            secretFillFraction(fillFraction)
            layer.cornerRadius = bounds.height / 2.0
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func updateFillFraction(_ fraction: Double, animated: Bool = false) {
        if fillFraction == fraction { return }
        fillFraction = fraction

        secretFillFraction(fraction, animated: animated)
    }
}


private extension BarGraphHorizontal {
    func setup() {
        clipsToBounds = true
    }
    
    func secretFillFraction(_ fraction: Double, animated: Bool = false) {
        layer.sublayers?.forEach {
            $0.removeFromSuperlayer()
        }
        
        let endPathWidth = max(CGFloat(fraction) * bounds.width, bounds.height)
        let cornerRadius = bounds.height / 2.0
        
        let magicPadNumber: CGFloat = 10.0
        let startPathRounded = UIBezierPath(roundedRect: CGRect(x: -magicPadNumber, y: 0, width: bounds.height + magicPadNumber, height: bounds.height), cornerRadius: cornerRadius)
        let endPathRounded = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: endPathWidth, height: bounds.height), cornerRadius: cornerRadius)

        let foregroundLayer = CAShapeLayer()
        foregroundLayer.path = endPathRounded.cgPath
        foregroundLayer.fillColor = color.cgColor
        layer.addSublayer(foregroundLayer)
        
        if !animated { return }
        
        CATransaction.begin()
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = startPathRounded.cgPath
        pathAnimation.toValue = endPathRounded.cgPath
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        pathAnimation.duration = 0.75
        foregroundLayer.add(pathAnimation, forKey: "path")

        CATransaction.commit()
    }
}
