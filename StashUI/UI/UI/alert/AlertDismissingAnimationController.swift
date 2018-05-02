//
//  AlertDismissingAnimationController.swift
//  stash-invest-ios
//
//  Created by Mikael Konutgan on 1/18/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class AlertDismissingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        let duration = transitionDuration(using: transitionContext)
        
        let animations = {
            fromViewController.view.alpha = 0.0
            fromViewController.view.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        }
        
        let completion = { (finished: Bool) in
            fromViewController.view.removeFromSuperview()
            transitionContext.completeTransition(finished)
        }
        
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
}
