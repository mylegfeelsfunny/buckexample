//
//  GradientView.swift
//  StashLabs
//
//  Created by Dawid Skiba on 7/28/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class CustomGradientView: UIView {
    fileprivate let gradientLayer: CAGradientLayer = CAGradientLayer()
    
    public var colors: [UIColor] {
        get { return gradientLayer.colors as! [UIColor] }
        set { gradientLayer.colors = colors }
    }
    
    // MARK: Initialization
    public required init(coder aDecoder: NSCoder)  {
        super.init(coder: aDecoder)!
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public convenience init(colors: Array<CGColor>, locations:Array<CGFloat>, frame: CGRect = CGRect.zero) {
        self.init(frame: frame)
        addGradient(withColors: colors, locations: locations)
    }
    
    // MARK: Overrides
    public override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    // MARK: Public Class
    /**
     @brief returns three valued array <CGFloat> of 0.0, parameter value, and 1.0
     @param CGFLoat of middle value of the array returned
     */
    public class func locationArrayWithMiddleValue(_ midValue: CGFloat) -> Array<CGFloat> {
        return [0.0, midValue, 1.0]
    }
    
    public class var clearColor: UIColor {
        return UIColor.white.withAlphaComponent(0.0)
    }
    
    // MARK: Public
    public func addGradient(withColors colors: Array<CGColor>, locations:Array<CGFloat>) {
        if colors.count != locations.count { return }
        self.setup()
        
        self.gradientLayer.colors = colors
        self.gradientLayer.locations = locations as [NSNumber]?
    }
    
    public func removeGradient() {
        self.gradientLayer.removeFromSuperlayer();
    }
    
    public func updateGradient(locations: Array<CGFloat>) {
        self.gradientLayer.locations = locations as [NSNumber]?
    }
    
    public func updateGradient(colors: Array<CGColor>) {
        self.gradientLayer.colors = colors
    }
}

// PRIVATES
extension CustomGradientView {
    func setup() {
        // other stuff if your heart desires
        clipsToBounds = true
        
        if let contains = layer.sublayers?.contains(self.gradientLayer), contains == false {
            gradientLayer.frame = self.bounds
            gradientLayer.speed = 10.0   // so when these puppies change size, the animation of gradient view will be quick (still noticable a bit but...)
            layer.insertSublayer(gradientLayer, at: 0)
        }
    }
}
