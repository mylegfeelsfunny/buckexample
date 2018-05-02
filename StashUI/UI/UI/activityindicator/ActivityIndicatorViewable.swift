//
//  ActivityIndicatorViewable.swift
//  StashUI
//
//  Created by Anton Gladkov on 3/7/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

public protocol ActivityIndicatorViewable {
    func startAnimating()
    func startAnimating(withStyle style: ActivityIndicatorStyle, blockingInteraction: Bool, overEverything: Bool)
    func stopAnimating()
}
