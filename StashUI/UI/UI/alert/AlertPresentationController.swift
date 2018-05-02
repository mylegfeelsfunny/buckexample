//
//  AlertPresentationController.swift
//  stash-invest-ios
//
//  Created by Mikael Konutgan on 1/6/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public protocol AlertPresentable {
//    var contentHeight: CGFloat { get }
    func contentHeight(maxWidth: CGFloat) -> CGFloat
}

public class AlertPresentationController: UIPresentationController {
    
    let backgroundView = UIVisualEffectView()
    
    public var dismissesWhenTapped = false
    
    override public func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView, let presentedView = presentedView else {
            return
        }
        
        backgroundView.frame = containerView.bounds
        containerView.addSubview(backgroundView)
        backgroundView.contentView.addSubview(presentedView)
        
        if dismissesWhenTapped {
            backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        }
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.backgroundView.effect = UIBlurEffect(style: .extraLight)
        })
    }
    
    override public func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
    }
    
    override public func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.backgroundView.effect = nil
        })
    }
    
    override public func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            backgroundView.removeFromSuperview()
        }
    }
    
    override public var frameOfPresentedViewInContainerView: CGRect {
        guard let presented = presentedViewController as? AlertPresentable else {
            return .zero
        }
        
        let dx: CGFloat = UIScreen.main.scale == 2.0 ? 24.0 : 48.0
        let dy = (presentingViewController.view.bounds.height - presented.contentHeight(maxWidth: presentingViewController.view.bounds.width - dx * 2.0)) / 2.0
        return presentingViewController.view.bounds.insetBy(dx: dx, dy: dy)
    }
}

extension AlertPresentationController {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
