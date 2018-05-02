//
//  UICollectionViewCell+Reusable.swift
//  Home
//
//  Created by Mikael Konutgan on 5/3/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

extension UICollectionReusableView: Reusable {
    
}

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        register(Registration(for: T.self))
    }
}
