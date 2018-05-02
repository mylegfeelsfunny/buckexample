//
//  CollectionViewCellModel.swift
//  StashUI
//
//  Created by Dawid Skiba on 9/22/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation

public struct CollectionViewCellModel: ReuseIdentifierable {
    public let reuseIdentifier: String
    
    public init(reuseIdentifier: String) {
        self.reuseIdentifier = reuseIdentifier
    }
}
