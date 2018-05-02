//
//  WebWireframe.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/20/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import SafariServices

public enum WebViewModel {
    case htmlString(String)
    case url(URL)
    case urlWithTitle(URL, String)
}

protocol WebWireframeInterface {
    func openMailComposer(withMail mail: Mail)
    func openSafari(withUrl url: URL)
    func attemptToOpenUrl(_ url: URL) -> URLOpening.Opened
    func dismiss()
}

public final class WebWireframe {

    public var viewController: UIViewController!
    private var exit: (() -> Void)?
    private var backupURLOpener: URLOpening?

    public init(viewModel: WebViewModel, backupURLOpener: URLOpening? = nil, userAgentProvider: UserAgentProviding? = nil) {
        self.backupURLOpener = backupURLOpener

        let webViewController   = WebViewController(viewModel: viewModel, userAgentProvider: userAgentProvider)

        let view                = webViewController
        let presenter           = WebPresenter()

        view.presenter          = presenter
        presenter.view          = view
        presenter.wireframe     = self

        viewController          = webViewController
    }

    public func push(onto navigationController: UINavigationController, animated: Bool = true) {
        guard let webViewController = viewController else {
            return
        }

        navigationController.pushViewController(webViewController, animated: animated)
        exit = { navigationController.popViewController(animated: true) }
    }

    public func present(from presentingViewController: UIViewController, animated: Bool = true) {
        guard let webViewController = viewController else {
            return
        }

        let navigationController = UINavigationController(rootViewController: webViewController)
        webViewController.showSolidNavigationBar()
        presentingViewController.present(navigationController, animated: animated, completion: nil)
        exit = { webViewController.dismiss(animated: true, completion: nil) }
    }
}

extension WebWireframe: WebWireframeInterface {

    func openMailComposer(withMail mail: Mail) {
        MailWireframe(mail: mail).present(from: viewController)
    }

    func openSafari(withUrl url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.hidesBottomBarWhenPushed = true

        viewController?.present(safariViewController, animated: true)
    }

    func attemptToOpenUrl(_ url: URL) -> URLOpening.Opened {
        return backupURLOpener?.openURL(url) ?? false
    }

    func dismiss() {
        exit?()
        viewController = nil
    }
}
