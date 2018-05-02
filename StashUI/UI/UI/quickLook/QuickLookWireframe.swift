//
//  QuickLookWireframe.swift
//  StashUI
//
//  Created by Kenny Sanchez on 12/12/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

protocol QuickLookWireframePresenterInterface {
    func dismiss()
}

public final class QuickLookWireframe {
    
    private var viewController: QuickLookViewController?
    private var exit: (() -> Void)?
    
    public init(url: URL, title: String) {
        let quickLookViewController   = QuickLookViewController(url: url, title: title)
        
        let view                = quickLookViewController
        let presenter           = QuickLookPresenter()
        
        view.presenter          = presenter
        presenter.view          = view
        presenter.wireframe     = self
        
        viewController          = quickLookViewController
    }
    
    public func push(onto navigationController: UINavigationController, animated: Bool = true) {
        guard let qlViewController = viewController else {
            return
        }
        
        navigationController.pushViewController(qlViewController, animated: animated)
        exit = { navigationController.popViewController(animated: true) }
    }
    
    public func present(from presentingViewController: UIViewController, animated: Bool = true) {
        guard let qlViewController = viewController else {
            return
        }
        
        let navigationController = UINavigationController(rootViewController: qlViewController)
        qlViewController.showSolidNavigationBar()
        presentingViewController.present(navigationController, animated: animated, completion: nil)
        exit = { qlViewController.dismiss(animated: true, completion: nil) }
    }
    
}

extension QuickLookWireframe: QuickLookWireframePresenterInterface {
    
    func dismiss() {
        exit?()
        viewController = nil
    }
}


