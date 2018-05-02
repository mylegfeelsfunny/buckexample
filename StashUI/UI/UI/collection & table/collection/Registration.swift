//
//  Registration.swift
//  Home
//
//  Created by Mikael Konutgan on 5/3/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public struct Registration {

    enum Strategy {
        case nib(UINib)
        case viewClass(AnyClass)
    }

    let strategy: Strategy
    let reuseIdentifier: String
    let kind: String?

    init(strategy: Strategy, reuseIdentifier: String, kind: String? = nil) {
        self.strategy = strategy
        self.reuseIdentifier = reuseIdentifier
        self.kind = kind
    }
}

extension Registration {
    
    init<T: UICollectionReusableView>(for _: T.Type, kind: String? = nil) {
        if let nib = T.nib {
            self.init(strategy: .nib(nib), reuseIdentifier: T.reuseIdentifier, kind: kind)
        } else {
            self.init(strategy: .viewClass(T.self), reuseIdentifier: T.reuseIdentifier, kind: kind)
        }
    }
    
    init<T: UICollectionViewCell>(for _: T.Type) {
        if let nib = T.nib {
            self.init(strategy: .nib(nib), reuseIdentifier: T.reuseIdentifier)
        } else {
            self.init(strategy: .viewClass(T.self), reuseIdentifier: T.reuseIdentifier)
        }
    }
}

extension UICollectionView {

    func register(_ registration: Registration) {
        let reuseIdentifier = registration.reuseIdentifier

        if let kind = registration.kind {
            switch registration.strategy {
            case .nib(let nib):
                register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
            case .viewClass(let viewClass):
                register(viewClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: reuseIdentifier)
            }
        } else {
            switch registration.strategy {
            case .nib(let nib):
                register(nib, forCellWithReuseIdentifier: reuseIdentifier)
            case .viewClass(let cellClass):
                register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
            }
        }
    }

    func register(_ registrations: [Registration]) {
        registrations.forEach { register($0) }
    }
}
