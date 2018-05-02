//
//  Reusable.swift
//  StashUI
//
//  Created by Anton Gladkov on 2/28/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {

    public static var reuseIdentifier: String {
        return String(describing: self)
    }

    public static var nib: UINib? {
        let bundle = Bundle(for: self)
        let nibName = String(describing: self)

        if (bundle.path(forResource: nibName, ofType: "nib") != nil) {
            return UINib(nibName: nibName, bundle: bundle)
        } else {
            return nil
        }
    }
}
