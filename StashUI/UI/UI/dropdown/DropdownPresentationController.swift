//
//  DropdownPresentationController.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 1/6/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public protocol DropdownPresentable {
    var contentHeight: CGFloat { get }
}

public protocol DropdownPresentationControllerDelegate: class {
    
    func sourceView(for dropdownPresentationController: DropdownPresentationController) -> UIView
    
    func additionalPresentationAnimations(for dropdownPresentationController: DropdownPresentationController) -> (() -> Void)
    func additionalDismissalAnimations(for dropdownPresentationController: DropdownPresentationController) -> (() -> Void)
}

public class DropdownPresentationController: UIPresentationController {
    
    public weak var dropdownPresentationControllerDelegate: DropdownPresentationControllerDelegate?
    
    fileprivate let backgroundView = UIView()
    fileprivate let navBarView = UIView()
    fileprivate let application: ApplicationHandlerInterface
    
    public required init(presentedViewController: UIViewController, presentingViewController: UIViewController?, application: ApplicationHandlerInterface) {
        self.application = application
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    public override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        guard let containerView = containerView, let presentedView = presentedView else {
            return
        }
        
        guard let sourceView = dropdownPresentationControllerDelegate?.sourceView(for: self) else {
            return
        }
        
        backgroundView.frame = containerView.bounds.offsetBy(dx: 0.0, dy: sourceView.frame.maxY)
        containerView.addSubview(backgroundView)
        backgroundView.addSubview(presentedView)
        
        containerView.backgroundColor = .clear
        
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.0
        
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(_:))))
        
        // nav bar
        navBarView.frame = CGRect(x: 0, y: application.statusBarFrameHeight, width: sourceView.bounds.width, height: sourceView.bounds.height)
        navBarView.backgroundColor = UIColor.clear
        containerView.addSubview(navBarView)
        navBarView.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector(handleTap(_:))))
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.backgroundView.alpha = 0.5
            self.dropdownPresentationControllerDelegate?.additionalPresentationAnimations(for: self)()
        })
    }
    
    public override func presentationTransitionDidEnd(_ completed: Bool) {
        super.presentationTransitionDidEnd(completed)
    }
    
    public override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.backgroundView.alpha = 0.0
            self.dropdownPresentationControllerDelegate?.additionalDismissalAnimations(for: self)()
        })
    }
    
    public override func dismissalTransitionDidEnd(_ completed: Bool) {
        super.dismissalTransitionDidEnd(completed)
        
        if completed {
            backgroundView.removeFromSuperview()
        }
    }
    
    public override var frameOfPresentedViewInContainerView: CGRect {
        guard let presented = presentedViewController as? DropdownPresentable else {
            return .zero
        }
        
        guard let sourceView = dropdownPresentationControllerDelegate?.sourceView(for: self) else {
            return .zero
        }
        
        return CGRect(x: 0.0, y: sourceView.frame.maxY, width: presentingViewController.view.bounds.width, height: presented.contentHeight)
    }
}

extension DropdownPresentationController {
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
