//
//  WebViewController.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/20/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewInterface: class {}

public class WebViewController: UIViewController, ActivityIndicatorViewable {
    
    public let viewModel: WebViewModel
    public var webView: WKWebView!
    var presenter: WebPresenterInterface?
    private var userAgentProvider: UserAgentProviding?

    public init(viewModel: WebViewModel, userAgentProvider: UserAgentProviding? = nil) {
        self.viewModel = viewModel
        self.userAgentProvider = userAgentProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: configuration)
        webView.navigationDelegate = self
        webView.accessibilityIdentifier = WebAccessibilityIdentifiers.webView
        webView.customUserAgent = userAgentProvider?.userAgent
        view = webView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.didLoad()
        
        if let _ = navigationController, navigationController?.viewControllers.first! == self {
            showDismissButton()
        } else {
            showPopbackButton()
        }
        
        DispatchQueue.main.async(execute: startAnimating)
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch viewModel {
        case .htmlString(let string):
            webView.loadHTMLString(string, baseURL: nil)
        case .url(let url):
            webView.load(URLRequest(url: url))
        case .urlWithTitle(let url, let title):
            webView.load(URLRequest(url: url))
            self.title = title
        }
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopAnimating()
    }
}

extension WebViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        stopAnimating()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        stopAnimating()
    }
    
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        stopAnimating()
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        stopAnimating()
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard navigationAction.navigationType == .linkActivated, let url = navigationAction.request.url, let presenter = presenter else {
            return decisionHandler(.allow)
        }

        decisionHandler(presenter.didSelectUrl(url) ? .cancel : .allow)
    }
}

extension WebViewController: WebViewInterface {
}

private extension WebViewController {
    
    func showDismissButton() {
        let image   = UIImage(named: "dismiss", in: Bundle(for: WebWireframe.self), compatibleWith: nil)
        let style   = UIBarButtonItemStyle.plain
        let target  = self
        let action  = #selector(WebViewController.dismissButtonTapped(_:))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: style, target: target, action: action)
    }
    
    func showPopbackButton() {
        backButtonWhiteArrow(target: self, action: #selector(WebViewController.dismissButtonTapped(_:)))
    }
    
    @objc func dismissButtonTapped(_ sender: AnyObject) {
        presenter?.dismissTapped()
    }
}
