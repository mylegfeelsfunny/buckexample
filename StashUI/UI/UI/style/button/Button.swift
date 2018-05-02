//
//  Button.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 1/10/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class Button: UIButton {
    
    public var contractsWhenHighlighted: Bool = false
    public var placeImageOnLeft: Bool = false {
        didSet {
            updateLayout()
        }
    }

    public var color: UIColor = .stashYellow {
        didSet {
            if oldValue == color { return }
            update()
        }
    }
    
    public var textColor: UIColor = .white {
        didSet {
            if textColor == color { return }
            update()
        }
    }
    
    public var cornerRadius: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    public var edgeType: EdgeType = .semicircle {
        didSet {
            update()
        }
    }

    public var borderColor: UIColor? = .clear {
        didSet {
            update()
        }
    }
    
    public var borderWidth: CGFloat = 0 {
        didSet {
            update()
        }
    }
    
    public var underlined: Bool = false {
        didSet {
            update()
        }
    }
    
    public var style: ButtonStyle = .primary {
        didSet {
            alter(for: style)
        }
    }
    
    required public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    
        guard let image = backgroundImage(for: .normal) else {
            updateBackground()
            return
        }
        if image.size != frame.size {
            updateBackground()
        }
    }
    
    public override var isHighlighted: Bool {
        didSet {
            if !contractsWhenHighlighted {
                return
            }

            let transform = isHighlighted ? CGAffineTransform(scaleX: 0.9, y: 0.9) : .identity
            UIView.animate(withDuration: 0.1) {
                self.transform = transform
            }
        }
    }

    public override func setImage(_ image: UIImage?, for state: UIControlState) {
        super.setImage(image, for: state)
        update()
    }
    
    public override func setTitle(_ title: String?, for state: UIControlState) {
        let alphaAmount: CGFloat = 0.4
        let highlightedTextColor = textColor.withAlphaComponent(alphaAmount)
        let disabledTextColor = textColor.withAlphaComponent(alphaAmount)
        
        if let font = titleLabel?.font, let text = title {
            var attrText: NSAttributedString = text.attributedStyle(font: font, textColor: textColor)
            var attrTextHighlighted: NSAttributedString = text.attributedStyle(font: font, textColor: highlightedTextColor)
            var attrTextDisabled: NSAttributedString = text.attributedStyle(font: font, textColor: disabledTextColor)
            if isUnderlined {
                attrText = text.underlined(with: textColor , font: font)
                attrTextHighlighted = text.underlined(with: highlightedTextColor, font: font)
                attrTextDisabled = text.underlined(with: disabledTextColor, font: font)
            }
            super.setAttributedTitle(attrTextHighlighted, for: .highlighted)
            super.setAttributedTitle(attrTextDisabled, for: .disabled)
            super.setAttributedTitle(attrText, for: .normal)
        }
    }
    
    private func setup() {
        backgroundColor = .clear
        titleLabel?.font = .subtitle1
    }

    private func update() {
        updateBackground()
        updateLayout()
    }
    
    private func updateBackground() {
        guard frame.size.height > 0 else { return }
        let colorImage = UIImage.from(color: color)
        let cornerRadius = edgeType.cornerRadius(self)
        
        // Normal
        if let image = colorImage.with(cornerRadius: cornerRadius, size: bounds.size, borderColor: textColor, borderWidth: borderWidth) {
            super.setBackgroundImage(image, for: .normal)
        } else {
            super.setBackgroundImage(colorImage, for: .normal)
        }
        
        let alphaAmount: CGFloat = color == .clear ? 0 : 0.3
        
        // Highlighted
        let darkColorImage = UIImage.from(color: color.blend(with: .black, amount: alphaAmount))
        if let image = darkColorImage.with(cornerRadius: cornerRadius, size: bounds.size, borderColor: textColor, borderWidth: borderWidth) {
            super.setBackgroundImage(image, for: .highlighted)
        } else {
            super.setBackgroundImage(darkColorImage, for: .highlighted)
        }
        
        // Disabled
        let disabledColorImage = UIImage.from(color: color.blend(with: .white, amount: alphaAmount))
        if let image = disabledColorImage.with(cornerRadius: cornerRadius, size: bounds.size, borderColor: textColor, borderWidth: borderWidth) {
            super.setBackgroundImage(image, for: .disabled)
        } else {
            super.setBackgroundImage(darkColorImage, for: .disabled)
        }
    }
    
    private func updateLayout() {
        if let image = imageView?.image {
            titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width, 0, 0)
            if placeImageOnLeft {
                imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30)
            } else {
                imageEdgeInsets = UIEdgeInsetsMake(0, frame.width - frame.height / 2 - image.size.width, 0, 0)
            }
        }
    }
    
    private var isUnderlined: Bool {
        if case .underlined = style {
            return true
        }
        return underlined
    }
    
    private func alter(for type: ButtonStyle) {
        let style = type.model
        titleLabel?.font = style.font
        titleLabel?.numberOfLines = style.numberOfLines
        titleLabel?.textAlignment = style.textAlignment
        borderColor = style.borderColor
        borderWidth = style.borderWidth
        edgeType = style.edgeType
        color = style.color
        textColor = style.textColor
        showsTouchWhenHighlighted = false
        adjustsImageWhenHighlighted = true
        
        switch type {
        case .share, .defaultShare:
            placeImageOnLeft = true
            imageView?.tintColor = style.textColor
            setImage(Image.shareBox.templateImage, for: .normal)
            setImage(Image.shareBox.templateImage, for: .highlighted)
        default:
            break
        }
    }
    
}

extension String {
    func underlined(with textColor: UIColor, font: UIFont) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [.font : font,
                                                             .foregroundColor : textColor,
                                                             .underlineStyle : NSUnderlineStyle.styleSingle.rawValue,
                                                             .underlineColor : textColor])
    }
}
