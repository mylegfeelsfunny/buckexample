//
//  GradientView.swift
//  StashInvest
//
//  Created by Scott Jones on 12/28/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public class GradientBackgroundView: UIView {
    
    let gl: CAGradientLayer
    public var firstColor: CGColor
    public var secondColor: CGColor
    
    public init(frame: CGRect, firstColor: UIColor, secondColor: UIColor) {
        self.firstColor             = firstColor.cgColor
        self.secondColor            = secondColor.cgColor
        self.gl                     = CAGradientLayer()
        super.init(frame: frame)
        self.backgroundColor        = .white
        self.clipsToBounds          = true
        fill()
    }
    
    public init(firstColor: UIColor, secondColor: UIColor) {
        self.firstColor             = firstColor.cgColor
        self.secondColor            = secondColor.cgColor
        self.gl                     = CAGradientLayer()
        super.init(frame: CGRect(x: 0, y: 0, width:0, height:0))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor        = .white
        self.clipsToBounds          = true
        fill()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.gl.frame               = layer.bounds
    }
    
    func fill() {
        self.gl.colors              = [firstColor, secondColor]
        self.gl.startPoint          = CGPoint(x: 0, y: 0)
        self.gl.endPoint            = CGPoint(x: 0, y: 1)
        self.gl.frame               = bounds
        self.gl.masksToBounds       = true
        self.layer.addSublayer(self.gl)
        self.layoutIfNeeded()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GradientBackgroundView {
    
    public static var hot: UIView {
        return GradientBackgroundView(frame: UIScreen.main.bounds, firstColor: .stashOrange, secondColor: .stashYellow)
    }
    
    public static var cool: UIView {
        return GradientBackgroundView(frame: UIScreen.main.bounds, firstColor: .stashPurple, secondColor: .stashTeel)
    }
    
}

public class GradientImageBackgroundView: UIImageView {

    var imageName: String = "gradient-background" {
        didSet {
            self.image              = UIImage(named: imageName)
        }
    }
    
    public init(frame: CGRect, imageName: String = "gradient-background") {
        super.init(frame: frame)
        self.imageName              = imageName
        self.image                  = UIImage(named: imageName)
    }
     
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GradientImageBackgroundView {
    
    public static var cool: UIView {
        return GradientImageBackgroundView(frame: UIScreen.main.bounds, imageName: "gradient-background")
    }
    
}
