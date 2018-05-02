//
//  UITableViewCell+Reusable.swift
//  StashUI
//
//  Created by Anton Gladkov on 2/28/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell: Reusable {

}

extension UITableViewHeaderFooterView: Reusable {

}

extension UITableView {

    func register<T: UITableViewCell>(_: T.Type) {
        register(TableRegistration(for: T.self))
    }

    func register<T: UITableViewHeaderFooterView>(_: T.Type) {
        register(TableRegistration(for: T.self))
    }
}

