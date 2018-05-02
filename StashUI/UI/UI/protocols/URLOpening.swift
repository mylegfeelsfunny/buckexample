//
//  URLOpening.swift
//  StashCore
//
//  Created by Anton Gladkov on 2/6/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation

public protocol URLOpening {
    typealias Opened = Bool

    @discardableResult
    func openURL(_ url: URL?) -> Opened
}
