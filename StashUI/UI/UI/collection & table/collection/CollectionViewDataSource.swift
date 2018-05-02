//
//  CollectionViewDataSource.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/5/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class CollectionViewDataSource: NSObject, UICollectionViewDataSource {

    let collection: Collection

    public init(collection: Collection) {
        self.collection = collection
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.sections[section].items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collection.item(at: indexPath) else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.registration.reuseIdentifier, for: indexPath)
        item.configure?(cell)
        return cell
    }

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collection.sections.count
    }

    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let header = collection.section(at: indexPath.section)?.header, kind == UICollectionElementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header.registration.reuseIdentifier, for: indexPath)
            header.configure?(view)
            return view
        }
        fatalError("collectionView(_:viewForSupplementaryElementOfKind:at:) called without header or footer")
    }
}
