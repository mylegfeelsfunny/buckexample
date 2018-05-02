//
//  WebPresenter.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/20/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

protocol WebPresenterInterface: class {
    
    func didLoad()
    func didSelectUrl(_ url: URL) -> Bool
    func dismissTapped()
}

class WebPresenter {
    private let allowedSchemes = ["http", "https"]

    var wireframe: WebWireframeInterface?
    weak var view: WebViewInterface?
}

extension WebPresenter: WebPresenterInterface {
    
    func didLoad() {
    }

    func didSelectUrl(_ url: URL) -> Bool {
        if let mail = Mail(url: url) {
            wireframe?.openMailComposer(withMail: mail)
            return true
        }

        if url.isWeb {
            wireframe?.openSafari(withUrl: url)
            return true
        }

        return wireframe?.attemptToOpenUrl(url) ?? false
    }
    
    func dismissTapped() {
        wireframe?.dismiss()
    }
}

extension URL {

    var isWeb: Bool {
        guard let scheme = scheme else {
            return false
        }

        return ["https", "http"].contains(scheme.lowercased())
    }
}
