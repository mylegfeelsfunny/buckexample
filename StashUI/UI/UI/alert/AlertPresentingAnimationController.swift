//
//  AlertPresentingAnimationController.swift
//  stash-invest-ios
//
//  Created by Mikael Konutgan on 1/18/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class AlertPresentingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        transitionContext.containerView.addSubview(toViewController.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        toViewController.view.alpha = 0.0
        toViewController.view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        
        let animations = {
            toViewController.view.alpha = 1.0
            toViewController.view.transform = .identity
        }
        
        let completion = { (finished: Bool) in
            transitionContext.completeTransition(finished)
        }
        
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
}
