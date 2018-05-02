//
//  DropdownTransitioningDelegate.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 1/6/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class DropdownTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    let sourceView: UIView
    let additionalPresentationAnimations: () -> Void
    let additionalDismissalAnimations: () -> Void
    let application: ApplicationHandlerInterface
    
    public init(sourceView: UIView, application: ApplicationHandlerInterface, additionalPresentationAnimations: @escaping () -> Void, additionalDismissalAnimations: @escaping () -> Void) {
        self.sourceView = sourceView
        self.application = application
        self.additionalPresentationAnimations = additionalPresentationAnimations
        self.additionalDismissalAnimations = additionalDismissalAnimations
        super.init()
    }
    
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = DropdownPresentationController(presentedViewController: presented, presentingViewController: presenting, application: application)
        presentationController.dropdownPresentationControllerDelegate = self
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DropdownPresentingAnimationController()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DropdownDismissingAnimationController()
    }
}

extension DropdownTransitioningDelegate: DropdownPresentationControllerDelegate {
    
    public func sourceView(for dropdownPresentationController: DropdownPresentationController) -> UIView {
        return sourceView
    }
    
    public func additionalPresentationAnimations(for dropdownPresentationController: DropdownPresentationController) -> (() -> Void) {
        return additionalPresentationAnimations
    }
    
    public func additionalDismissalAnimations(for dropdownPresentationController: DropdownPresentationController) -> (() -> Void) {
        return additionalDismissalAnimations
    }
}
