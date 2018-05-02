//
//  ApplicationHandler.swift
//  StashUI
//
//  Created by Morgan Collino on 2/23/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

public protocol ApplicationHandlerInterface {
    
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL)

    var statusBarFrameHeight: CGFloat { get }
    var keyWindow: UIWindow? { get }
}
