//
//  TableRegistration.swift
//  StashUI
//
//  Created by Anton Gladkov on 2/28/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

public struct TableRegistration {

    enum Strategy {
        case nib(UINib)
        case viewClass(AnyClass)
    }

    enum Kind {
        case cell
        case headerFooter
    }

    let strategy: Strategy
    let reuseIdentifier: String
    let kind: Kind

    init(strategy: Strategy, reuseIdentifier: String, kind: Kind) {
        self.strategy = strategy
        self.reuseIdentifier = reuseIdentifier
        self.kind = kind
    }
}

extension TableRegistration {

    init<T: UITableViewHeaderFooterView>(for _: T.Type) {
        if let nib = T.nib {
            self.init(strategy: .nib(nib), reuseIdentifier: T.reuseIdentifier, kind: .headerFooter)
        } else {
            self.init(strategy: .viewClass(T.self), reuseIdentifier: T.reuseIdentifier, kind: .headerFooter)
        }
    }

    init<T: UITableViewCell>(for _: T.Type) {
        if let nib = T.nib {
            self.init(strategy: .nib(nib), reuseIdentifier: T.reuseIdentifier, kind: .cell)
        } else {
            self.init(strategy: .viewClass(T.self), reuseIdentifier: T.reuseIdentifier, kind: .cell)
        }
    }
}

extension UITableView {

    func register(_ registration: TableRegistration) {
        let reuseIdentifier = registration.reuseIdentifier

        switch registration.kind {
        case .headerFooter:
            switch registration.strategy {
            case .nib(let nib):
                register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
            case .viewClass(let viewClass):
                register(viewClass, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
            }
        case .cell:
            switch registration.strategy {
            case .nib(let nib):
                register(nib, forCellReuseIdentifier: reuseIdentifier)
            case .viewClass(let cellClass):
                register(cellClass, forCellReuseIdentifier: reuseIdentifier)
            }
        }
    }

    func register(_ registrations: [TableRegistration]) {
        registrations.forEach(register)
    }
}
