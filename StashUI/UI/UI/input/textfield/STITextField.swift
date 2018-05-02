//
//  STITextField.swift
//  TextFieldChallenge
//
//  Created by Scott Jones on 10/5/16.
//  Copyright © 2016 Collective Returns, INC. All rights reserved.
//

//
//  STITextField.swift
//  TextFieldChallenge
//
//  Created by Scott Jones on 10/5/16.
//  Copyright © 2016 Collective Returns, INC. All rights reserved.
//

import UIKit

public class  STITextField : UITextField {
    
    public var jsonKey: String?
    internal let placeholderLayer                               = CATextLayer()
    internal var errorLayer                                     = CATextLayer()
    internal let bottomBorder                                   = CALayer()

    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    deinit {
        removeTarget(self, action: #selector(didStartEditing(sender:)), for:.editingDidBegin)
        removeTarget(self, action: #selector(didEndEditing(sender:)), for:.editingDidEnd)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    internal func initSetup() {
        errorLayer.string                                       = ""
        
        layer.addSublayer(bottomBorder)
        deselect()
        self.update()
        clipsToBounds                                           = false
        addTarget(self, action: #selector(didStartEditing(sender:)), for:.editingDidBegin)
        addTarget(self, action: #selector(didEndEditing(sender:)), for:.editingDidEnd)
    }
    
    internal var errorFrame:CGRect {
        get {
            return CGRect(x: 0, y: bounds.height + 3, width: bounds.width, height: errorLayer.trueHeight + 12)
        }
    }
    
    internal var placeholderStartFrame:CGRect {
        get {
            let diff                                            = bounds.height - placeholderLayer.trueHeight
            let maximizer: CGFloat                              = (UIScreen.main.bounds.height < 567) ? 0.2 : 0.5
            return CGRect(x:0, y:diff * maximizer, width:bounds.width, height:placeholderLayer.trueHeight)
        }
    }

    override public var text: String? {
        willSet {
            if let t = newValue, t.count > 0 {
                CATransaction.setDisableActions(true)
                
                let endFrame:CGRect                             = placeholderEndFrame
                let startFrame:CGRect                           = placeholderStartFrame
                
                self.placeholderLayer.frame                     = endFrame
                self.placeholderLayer.fontSize                  = placeholderEndFont.pointSize
                // animation
                let fontSize                                    = CABasicAnimation(keyPath: "fontSize")
                fontSize.timingFunction                         = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                fontSize.fromValue                              = placeholderFont.pointSize
                fontSize.toValue                                = placeholderEndFont.pointSize
                
                let position                                    = CABasicAnimation(keyPath: "position")
                position.timingFunction                         = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                position.fromValue                              = NSValue(cgPoint:startFrame.origin)
                position.toValue                                = NSValue(cgPoint:endFrame.origin)
                
                let bounds                                      = CABasicAnimation(keyPath: "bounds")
                bounds.timingFunction                           = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                bounds.fromValue                                = NSValue(cgRect:startFrame)
                bounds.toValue                                  = NSValue(cgRect:endFrame)
                
                let group                                       = CAAnimationGroup()
                group.isRemovedOnCompletion                     = true;
                group.fillMode                                  = kCAFillModeForwards;
                group.animations                                = [
                    fontSize
                    ,position
                    ,bounds
                ]
                group.duration                                  = 0.0
                
                CATransaction.begin()
                CATransaction.setAnimationDuration(group.duration)
                CATransaction.setCompletionBlock {
                    CATransaction.flush()
                }
                
                placeholderLayer.add(group, forKey: "frame")
                CATransaction.commit()
                
                CATransaction.setDisableActions(false)
                
            }
            
        }
        didSet {
            if let text = text, !text.isEmpty {
                return
            }

            didEndEditing(sender: self)
        }
    }
    
    internal var placeholderEndFrame:CGRect {
        get {
            let t:CGFloat                       = placeholderLayer.trueHeight
            return CGRect(x:CGFloat(1).deviceScaled, y:-(t * 0.62), width:bounds.width - CGFloat(1).deviceScaled, height:t)
        }
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        bottomBorder.frame                      = CGRect(x:0, y:bounds.height + 1, width:bounds.width, height:1)
    }
    
    internal func update() {
        backgroundColor                         = .clear
        
        CATransaction.setDisableActions(true)
        
        errorLayer.font                         = errorFont
        errorLayer.fontSize                     = errorFont.pointSize
        errorLayer.anchorPoint                  = CGPoint(x:0.0, y:0.0)
        errorLayer.isHidden                     = true
        errorLayer.foregroundColor              = errorTextColor.cgColor
        errorLayer.backgroundColor              = errorBackgroundColor.cgColor
        errorLayer.contentsScale                = UIScreen.main.scale
        errorLayer.alignmentMode                = kCAAlignmentLeft
        errorLayer.cornerRadius                 = 2
        layer.addSublayer(errorLayer)
        
        placeholderLayer.font                   = placeholderFont
        placeholderLayer.fontSize               = placeholderFont.pointSize
        placeholderLayer.anchorPoint            = CGPoint(x:0, y:0.0)
        placeholderLayer.alignmentMode          = textAlignment.alignmentMode
        placeholderLayer.contentsScale          = UIScreen.main.scale
        placeholderLayer.isWrapped              = false
        placeholderLayer.truncationMode         = kCATruncationNone
        layer.addSublayer(placeholderLayer)
        
        errorLayer.frame                        = errorFrame
        placeholderLayer.frame                  = placeholderStartFrame
        
        deselect()
        
        CATransaction.setDisableActions(false)
    }
    
    public var placeholderMessage: String? {
        didSet {
            placeholderLayer.string             = placeholderMessage
            layoutIfNeeded()
            update()
            if text != nil && text != "" {
                moveUp(false)
            }
        }
    }
    
    public var errorMessage: String? {
        didSet {
            errorLayer.string                   = errorMessage
            if let em = errorMessage, em.count > 0 {
                errorLayer.isHidden             = false
            } else {
                errorLayer.isHidden             = true
            }
            errorLayer.frame                    = errorFrame
        }
    }
    
    public var errorFont:UIFont = .boldLatoFont(ofSize: 14) {
        didSet {
            update()
        }
    }
    
    public var placeholderFont:UIFont = .regularLatoFont(ofSize:18){
        didSet {
            update()
        }
    }
    
    public var placeholderEndFont:UIFont = .regularLatoFont(ofSize:12) {
        didSet {
            update()
        }
    }

    public var activePlaceholderTextColor:UIColor = .stashTeel {
        didSet {
            update()
        }
    }
    
    public var inactivePlaceholderTextColor:UIColor = .stashBlue {
        didSet {
            update()
        }
    }
    
    public var activeBorderColor:UIColor = .stashTeel {
        didSet {
            update()
        }
    }
    
    public var inactiveBorderColor:UIColor = .stashBlue {
        didSet {
            update()
        }
    }
    
    override public var textColor:UIColor?  {
        didSet {
            update()
        }
    }
    
    public var errorTextColor:UIColor = UIColor.stashRed {
        didSet {
            update()
        }
    }
    
    public var errorBackgroundColor:UIColor = UIColor.clear {
        didSet {
            update()
        }
    }
    
    public func styleWasUpdated() {
        deselect()
        layoutIfNeeded()
        update()
        
        (text ?? "").isEmpty ? moveDown(false) : moveUp(false)
    }
    
    @objc public func didStartEditing(sender:UITextField) {
        bottomBorder.backgroundColor                    = activeBorderColor.cgColor
        placeholderLayer.foregroundColor                = activePlaceholderTextColor.cgColor
        
        if placeholderLayer.frame == placeholderEndFrame { return }
        guard let st = self.text  else {
            moveUp()
            return
        }
        if st.count < 1 {
            moveUp()
        }
    }
    
    @objc public func didEndEditing(sender:UITextField) {
        deselect()
        if placeholderLayer.frame == placeholderStartFrame { return }
        guard let st = self.text else {
            moveDown()
            return
        }
        if st.count < 1 {
            moveDown()
        }
    }
    
    public func deselect() {
        placeholderLayer.foregroundColor                = inactivePlaceholderTextColor.cgColor
        bottomBorder.backgroundColor                    = inactiveBorderColor.cgColor
        errorLayer.isHidden                             = true
    }

    internal func moveUp(_ animated:Bool = true) {
        let endFrame:CGRect                             = placeholderEndFrame
        let startFrame:CGRect                           = placeholderStartFrame
        
        CATransaction.setDisableActions(true)
        self.placeholderLayer.frame                     = endFrame
        self.placeholderLayer.fontSize                  = self.placeholderEndFont.pointSize
        CATransaction.setDisableActions(false)
        
        // animation
        let fontSize                                    = CABasicAnimation(keyPath: "fontSize")
        fontSize.timingFunction                         = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        fontSize.fromValue                              = placeholderFont.pointSize
        fontSize.toValue                                = placeholderEndFont.pointSize
        
        let position                                    = CABasicAnimation(keyPath: "position")
        position.timingFunction                         = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        position.fromValue                              = NSValue(cgPoint:startFrame.origin)
        position.toValue                                = NSValue(cgPoint:endFrame.origin)
        
        let bounds                                      = CABasicAnimation(keyPath: "bounds")
        bounds.timingFunction                           = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bounds.fromValue                                = NSValue(cgRect:startFrame)
        bounds.toValue                                  = NSValue(cgRect:endFrame)
        
        let group                                       = CAAnimationGroup()
        group.isRemovedOnCompletion                     = true;
        group.fillMode                                  = kCAFillModeForwards;
        group.animations                                = [
            fontSize
            ,position
            ,bounds
        ]
        group.duration                                  = animated ? 0.3 : 0.0
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(group.duration)
        CATransaction.setCompletionBlock {
            CATransaction.flush()
        }
        
        placeholderLayer.add(group, forKey: "frame")
        CATransaction.commit()
    }
    
    internal func moveDown(_ animated: Bool = true) {
        CATransaction.setDisableActions(false)
        
        let endFrame:CGRect                             = placeholderEndFrame
        let startFrame:CGRect                           = placeholderStartFrame
        
        CATransaction.setDisableActions(true)
        placeholderLayer.frame                          = placeholderStartFrame
        placeholderLayer.fontSize                       = placeholderFont.pointSize
        CATransaction.setDisableActions(false)
        
        let fontSize                                    = CABasicAnimation(keyPath: "fontSize")
        fontSize.timingFunction                         = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        fontSize.fromValue                              = placeholderEndFont.pointSize
        fontSize.toValue                                = placeholderFont.pointSize
        
        let position                                    = CABasicAnimation(keyPath: "position")
        position.timingFunction                         = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        position.fromValue                              = NSValue(cgPoint:endFrame.origin)
        position.toValue                                = NSValue(cgPoint:startFrame.origin)
        
        let bounds                                      = CABasicAnimation(keyPath: "bounds")
        bounds.timingFunction                           = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        bounds.fromValue                                = NSValue(cgRect:endFrame)
        bounds.toValue                                  = NSValue(cgRect:startFrame)
        
        let group                                       = CAAnimationGroup()
        group.isRemovedOnCompletion                     = true;
        group.fillMode                                  = kCAFillModeForwards;
        group.animations                                = [
            fontSize
            ,position
        ]
        group.duration                                  = animated ? 0.3 : 0.0
        
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(group.duration)
        CATransaction.setCompletionBlock {
            CATransaction.flush()
        }
        
        placeholderLayer.add(group, forKey: "frame")
        CATransaction.commit()
    }
    
    public func formatStashDefaultDarkContent() {
        errorLayer = STITextField.stashErrorLayer
        errorBackgroundColor                            = .clear
        errorTextColor                                  = .white
        
        font                                            = .regularLatoFont(ofSize:21)
        placeholderFont                                 = .regularLatoFont(ofSize:20)
        placeholderEndFont                              = .regularLatoFont(ofSize:14)
        errorFont                                       = .regularLatoFont(ofSize:12)
        textAlignment                                   = .left
        
        activePlaceholderTextColor                      = .stashTeel
        inactivePlaceholderTextColor                    = UIColor.stashBlue.withAlphaComponent(0.7)
        activeBorderColor                               = .stashTeel
        inactiveBorderColor                             = UIColor.stashBlue.withAlphaComponent(0.7)
        textColor                                       = .stashBlue
        
        deselect()
        layoutIfNeeded()
        update()
    }
    
    public func formatStashDefaultLightContent() {
        errorLayer = STITextField.stashErrorLayer
        errorBackgroundColor                            = .clear
        errorTextColor                                  = .white
        
        font                                            = .regularLatoFont(ofSize:21)
        placeholderFont                                 = .regularLatoFont(ofSize:20)
        placeholderEndFont                              = .regularLatoFont(ofSize:14)
        errorFont                                       = .regularLatoFont(ofSize:12)
        textAlignment                                   = .left
        
        activePlaceholderTextColor                      = UIColor.white.withAlphaComponent(0.7)
        inactivePlaceholderTextColor                    = UIColor.white.withAlphaComponent(0.8)
        activeBorderColor                               = UIColor.white.withAlphaComponent(1.0)
        inactiveBorderColor                             = UIColor.white.withAlphaComponent(0.8)
        textColor                                       = UIColor.white.withAlphaComponent(1.0)
        
        deselect()
        layoutIfNeeded()
        update()
    }
    
    public func formatStashGrayContent() {
        errorLayer = STITextField.stashErrorLayer
        errorBackgroundColor                            = .clear
        errorTextColor                                  = .white
        
        font                                            = .regularLatoFont(ofSize:21)
        placeholderFont                                 = .regularLatoFont(ofSize:20)
        placeholderEndFont                              = .regularLatoFont(ofSize:14)
        errorFont                                       = .regularLatoFont(ofSize:12)
        textAlignment                                   = .left
        
        activePlaceholderTextColor                      = .stashTeel
        inactivePlaceholderTextColor                    = .stashGray(130.0)
        activeBorderColor                               = .stashTeel
        inactiveBorderColor                             = .stashGray(184.0)
        textColor                                       = .stashGray(39.0)
        
        deselect()
        layoutIfNeeded()
        update()
    }

    internal class var stashErrorLayer: LCTextLayer {
        let layer = LCTextLayer()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width:0, height:1)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 2
        return layer
    }
}

extension NSTextAlignment {
    fileprivate var alignmentMode:String {
        switch self {
        case .right:
            return kCAAlignmentRight
        case .center:
            return kCAAlignmentCenter
        case .justified:
            return kCAAlignmentCenter
        default:
            return kCAAlignmentLeft
        }
    }
}

extension CATextLayer {
    
    var trueHeight:CGFloat {
        get {
            guard let text = self.string as? String else { return 0.0 }
            guard let font = self.font as? UIFont else { return 0.0 }
            return text.heightWithConstrainedWidth(bounds.width, font:font)
        }
    }
    
    func height(for font: UIFont)->CGFloat {
        guard let text = self.string as? String else { return 0.0 }
        return text.heightWithConstrainedWidth(bounds.width, font:font)
    }
    
}

public class LCTextLayer : CATextLayer {
    
    var dropColor:CGColor               = UIColor.stashPaleRed.cgColor
    
    public override func draw(in ctx: CGContext) {
        let height                      = self.bounds.size.height
        let fontSize                    = self.fontSize
        
        let ratio:CGFloat               = 6.0
        let divider:CGFloat             = height / ratio
        let rest:CGFloat                = divider * (ratio - 1)
        
        ctx.beginPath()
        ctx.move(to: CGPoint(x: divider * 2, y: divider + 1))
        ctx.addLine(to: CGPoint(x: divider * 4, y: 0))
        ctx.addLine(to: CGPoint(x: divider * 6, y: divider + 1))
        ctx.closePath()
        ctx.setFillColor(dropColor)
        ctx.fillPath()
        
        let rect                        = CGRect(origin: CGPoint(x: 0, y: divider), size: CGSize(width:self.bounds.maxX, height: rest))
        let path                        = UIBezierPath(roundedRect: rect, cornerRadius: 2.0)
        ctx.addPath(path.cgPath)
        ctx.setFillColor(dropColor)
        ctx.fillPath()
        
        let yDiff                       = (height-fontSize + divider) / 2 - fontSize / 10
        ctx.saveGState()
        ctx.translateBy(x: CGFloat(8.0).deviceScaled, y: yDiff)
        super.draw(in: ctx)
        ctx.restoreGState()
    }
    
}



