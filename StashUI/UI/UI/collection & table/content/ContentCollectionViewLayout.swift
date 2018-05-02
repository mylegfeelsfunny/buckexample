//
//  MyStashLayout.swift
//  StashInvest
//
//  Created by Scott Jones on 10/10/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public class ContentCollectionViewLayout: UICollectionViewLayout {

    var cache = [UICollectionViewLayoutAttributes]()
    
    var numberOfItems: Int {
        return collectionView?.numberOfItems(inSection: 0) ?? 0
    }
    
    var height: CGFloat {
        return collectionView?.frame.height ?? 0
    }
    
    override public func prepare() {
        cache.removeAll(keepingCapacity: false)
        let width               = UIScreen.main.bounds.width

        var frame               = CGRect(x: 0, y: 0, width: 0, height: 0)
        var x: CGFloat           = 0
        for item in 0..<numberOfItems {
            let indexPath       = IndexPath(item: item, section:0)
            let attributes      = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.zIndex   = item
            frame               = CGRect(x: x, y:0, width: width, height: height)
            attributes.frame    = frame
            x += width
            cache.append(attributes)
        }
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }

    override public var collectionViewContentSize: CGSize {
        let width               = UIScreen.main.bounds.width * CGFloat(numberOfItems)
        return CGSize(width: width, height: height)
    }

}
