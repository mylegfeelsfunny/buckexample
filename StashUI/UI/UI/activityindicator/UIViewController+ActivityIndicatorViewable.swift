//
//  UIViewController+ActivityIndicatorViewable.swift
//  StashUI
//
//  Created by Anton Gladkov on 3/7/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

private var activityIndicatorContainerViewKey = "UIViewController.activityIndicatorContainerView"

public extension ActivityIndicatorViewable where Self: UIViewController {

    func getActivityIndicatorContainerView() -> UIView? {
        return objc_getAssociatedObject(self, &activityIndicatorContainerViewKey) as? UIView
    }

    func setActivityIndicatorContainerView(_ containerView: UIView) {
        objc_setAssociatedObject(self, &activityIndicatorContainerViewKey, containerView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }

    var isAnimating: Bool {
        return getActivityIndicatorContainerView() != nil
    }

    public func startAnimating() {
        self.startAnimating(withStyle: .default, blockingInteraction: false, overEverything: false)
    }

    public func startAnimating(withStyle style: ActivityIndicatorStyle, blockingInteraction: Bool, overEverything: Bool) {
        guard let superView = overEverything ? view.window : view else {
            return
        }

        if isAnimating {
            stopAnimating()
        }

        let containerView: UIView = {
            let view = UIView(frame: superView.bounds)
            view.isUserInteractionEnabled = !blockingInteraction
            view.backgroundColor = style.overlay.color
            view.alpha = 0

            return view
        }()

        let activityIndicatorView: ActivityIndicatorView = {
            let view = ActivityIndicatorView()
            view.backgroundStyle = style.background
            view.center = CGPoint(x: containerView.bounds.midX, y: containerView.bounds.midY)

            return view
        }()

        containerView.addSubview(activityIndicatorView)
        superView.addSubview(containerView)

        activityIndicatorView.startAnimating()
        setActivityIndicatorContainerView(containerView)

        UIView.animate(withDuration: 0.2, animations: {
            containerView.alpha = 1
        })
    }

    public func stopAnimating() {
        getActivityIndicatorContainerView()?.removeFromSuperview()
    }
}

private extension ActivityIndicatorStyle.OverlayStyle {

    var color: UIColor {
        switch self {
        case .clear:
            return .clear
        case .dimmed:
            return UIColor.black.withAlphaComponent(0.25)
        }
    }
}
