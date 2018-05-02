//
//  KeyPadCollectionViewFlow.swift
//  StashInvest
//
//  Created by Scott Jones on 12/11/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public class KeyPadCollectionViewFlow: UICollectionViewLayout {
    
    var cache                   = [UICollectionViewLayoutAttributes]()
    var numberOfItems: CGFloat   = 12
    var rows: CGFloat {
        return numberOfItems / columns
    }
    var columns: CGFloat         = 3.0
    
    override public func prepare() {
        cache.removeAll(keepingCapacity: false)
        let width               = (collectionView!.bounds.width - (columns - 1)) / columns
        let height              = (collectionView!.bounds.height - (rows - 1)) / rows
        var frame               = CGRect(x: 0, y: 0, width: width, height: width)
        
        let items = Int(numberOfItems)
        for item in 0..<items {
            let indexPath       = IndexPath(item: item, section:0)
            let attributes      = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.zIndex   = item
            
            let subX            = CGFloat(item).truncatingRemainder(dividingBy: columns)
            let subY            = floor(CGFloat(item) / columns)
            let x               = (subX * width) + (subX)
            let y               = (subY * height) + (subY)

            frame               = CGRect(x: x, y: y, width: width, height: height)
            attributes.frame = frame
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
        let bounds              = collectionView!.bounds.width
        return CGSize(width: bounds, height: bounds)
    }
    
}
