//
//  AlertControllerTransitioningDelegate.swift
//  stash-invest-ios
//
//  Created by Mikael Konutgan on 1/6/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

class AlertControllerTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return AlertPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertPresentingAnimationController()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AlertDismissingAnimationController()
    }
}
