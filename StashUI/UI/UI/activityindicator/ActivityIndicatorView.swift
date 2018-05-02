//
//  ActivityIndicatorView.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/3/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public enum ActivityIndicatorBackgroundStyle {
    case clear
    case dark
}

private extension ActivityIndicatorBackgroundStyle {

    var color: UIColor {
        switch self {
        case .clear:
            return .clear
        case .dark:
            return UIColor.black.withAlphaComponent(0.75)
        }
    }
}

public class ActivityIndicatorView: UIView {
    private let imageView = UIImageView()

    public var isAnimating: Bool = false {
        didSet {
            isHidden = !isAnimating
        }
    }

    public var backgroundStyle: ActivityIndicatorBackgroundStyle = .dark {
        didSet {
            backgroundColor = backgroundStyle.color
        }
    }

    public func startAnimating() {
        isAnimating = true
        if !imageView.isAnimating {
            imageView.startAnimating()
        }
    }
    
    public func stopAnimating() {
        isAnimating = false
        imageView.stopAnimating()
    }
    
    public init() {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 102.0, height: 34.0))
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundStyle = .dark
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2.0
    }
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        isAnimating = false
        
        imageView.contentMode = .center
        
        imageView.animationImages = (1...21).map {
            let imageName = String(format: "frame-%02d", $0)
            let bundle = Bundle(for: ActivityIndicatorView.self)
            return UIImage(named: imageName, in: bundle, compatibleWith: nil)!
        }
        
        imageView.frame = self.bounds
        addSubview(imageView)
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: 102.0, height: 34.0)
    }
}
