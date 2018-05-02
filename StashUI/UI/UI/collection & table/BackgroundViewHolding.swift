//
//  BackgroundViewHolding.swift
//  StashUI
//
//  Created by Dawid Skiba on 11/11/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public protocol BackgroundViewHolding {
    var backgroundView: UIView? { get set }
}

extension UITableView: BackgroundViewHolding {}
extension UICollectionView: BackgroundViewHolding {}
