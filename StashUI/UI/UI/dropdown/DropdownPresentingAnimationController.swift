//
//  DropdownPresentingAnimationController.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 1/18/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

class DropdownPresentingAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            return
        }
        
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        transitionContext.containerView.addSubview(toViewController.view)
        
        mask(transitionContext.containerView, to: toViewController.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        toViewController.view.transform = CGAffineTransform(translationX: 0.0, y: -toViewController.view.bounds.height)
        
        let animations = {
            toViewController.view.transform = .identity
        }
        
        let completion = { (finished: Bool) in
            transitionContext.completeTransition(finished)
        }
        
        UIView.animate(withDuration: duration, animations: animations, completion: completion)
    }
}

private extension DropdownPresentingAnimationController {
    
    func mask(_ containerView: UIView, to view: UIView) {
        let mask = UIView()
        mask.backgroundColor = .black
        mask.isUserInteractionEnabled = false
        containerView.mask = mask
        
        let x = CGFloat(0.0)
        let y = view.frame.origin.y
        let width = containerView.bounds.width
        let height = containerView.bounds.height - y
        containerView.mask?.frame = CGRect(x: x, y: y, width: width, height: height)
    }
}
