//
//  Collection.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/5/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public struct Item {

    public let registration: Registration

    public var configure: ((UICollectionViewCell) -> Void)?
    public var didSelect: ((UICollectionView, IndexPath) -> Void)?
    public var didCenter: (() -> Void)?
    public var willDisplay: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?
    public var didDisplay: ((UICollectionView, UICollectionViewCell, IndexPath) -> Void)?

    public var size: ((UICollectionView, UICollectionViewLayout, IndexPath) -> CGSize)?

    public init<T: UICollectionViewCell>(_: T.Type) {
        self.registration = Registration(for: T.self)
    }
}

public struct Section {

    public let header: SectionHeader?
    public let items: [Item]

    public var inset: ((UICollectionView, UICollectionViewLayout, Int) -> UIEdgeInsets)?
    public var minimumLineSpacing: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?
    public var minimumInteritemSpacing: ((UICollectionView, UICollectionViewLayout, Int) -> CGFloat)?

    public init(header: SectionHeader? = nil, items: [Item]) {
        self.header = header
        self.items = items
    }
}

public struct SectionHeader {

    public let registration: Registration

    public var configure: ((UICollectionReusableView) -> Void)?

    public var size: ((UICollectionView, UICollectionViewLayout, Int) -> CGSize)?

    public init<T: UICollectionReusableView>(_: T.Type) {
        self.registration = Registration(for: T.self, kind: UICollectionElementKindSectionHeader)
    }
}

public struct Collection {
    public typealias Selection = (indexPath: IndexPath, animated: Bool, scrollPosition: UICollectionViewScrollPosition)

    public let sections: [Section]
    public var defaultSelection: Selection?
    public var dataHashValue: Int?
    
    public init(sections: [Section] = []) {
        self.sections = sections
    }

    public init(section: Section) {
        self.sections = [section]
    }

    public func item(at indexPath: IndexPath) -> Item? {
        return sections[safe: indexPath.section]?.items[safe: indexPath.item]
    }

    public func section(at index: Int) -> Section? {
        guard let section = sections[safe: index] else { return nil }
        return section
    }

}
