//
//  CellColorSelectable.swift
//  StashUI
//
//  Created by Dawid Skiba on 10/30/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public protocol CellColorSelectable {
    var backgroundSelectionColor: UIColor { get }
    func setupBackgroundSelectionColor()
}

// General
public extension CellColorSelectable {
    public var backgroundSelectionColor: UIColor {
        return UIColor.cellSelectionColor
    }
}

// TableViewCell
public extension CellColorSelectable where Self: UITableViewCell {
    public func setupBackgroundSelectionColor() {
        let luckyView = UIView()
        luckyView.backgroundColor = backgroundSelectionColor
        selectedBackgroundView = luckyView
    }
}
