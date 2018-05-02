//
//  MenuLayout.swift
//  StashInvest
//
//  Created by Scott Jones on 10/9/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

private let MenuHeight: CGFloat      = 50

public enum MenuSpacing {
    case fit
    case autoSize
}

public class MenuLayout: UICollectionViewLayout {
    
    var cache = [UICollectionViewLayoutAttributes]()
    var font: UIFont!
    var spacing: MenuSpacing     = .autoSize
    
    var menuLabels: [MenuLabel] = []
    
    private var padding: CGFloat = CGFloat(16).deviceScaled

    var numberOfItems: Int {
        return menuLabels.count
    }
    
    override public func prepare() {
        cache.removeAll(keepingCapacity: false)
        
        adjustForPadding()

        var x: CGFloat          = spacing == .fit ? padding : 0

        for item in 0..<numberOfItems {
            let indexPath       = IndexPath(item: item, section:0)
            let attributes      = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.zIndex   = item
            let menuLabel       = menuLabels[indexPath.item]
            let width           = widthForString(string: menuLabel.name)
            attributes.frame    = CGRect(x: x, y: 0, width: width, height: MenuHeight)
            
            x += width
            cache.append(attributes)
        }
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return indexPath.row < cache.count ? cache[indexPath.row] : nil
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
    
    func widthForString(string: String) -> CGFloat {
        return string.widthWithConstrainedHeight(MenuHeight, font: font) + (padding * 2)
    }
   
    func offset(forindexPath indexPath: IndexPath) -> CGPoint {
        let percent             = CGFloat(indexPath.row) / CGFloat(numberOfItems - 1)
        var contentOffset       = collectionView?.contentOffset ?? CGPoint(x: 0, y: 0)
        let buffer              = abs(UIScreen.main.bounds.width - collectionViewContentSize.width)
        contentOffset.x         = (buffer * percent)
        return contentOffset
    }
    
    func adjustForPadding() {
        let maxWidth            = UIScreen.main.bounds.width
        let width: CGFloat      = menuLabels.reduce(0) { $0 + $1.name.widthWithConstrainedHeight(MenuHeight, font: font) }

        if width < maxWidth && spacing == .fit { // we wanted .fit and we can do it
            let diff            = UIScreen.main.bounds.width - width
            padding             = diff / CGFloat((numberOfItems * 2) + 2)
        } else if width < maxWidth { // we didn't want fit, but everything fits.  We'll position labels such that only 50% of the last label is visible
            if let lastLabel = menuLabels.last {
                let lastLabelWidth = lastLabel.name.widthWithConstrainedHeight(MenuHeight, font: font)
                let allOtherLabelsWidth = menuLabels[0..<menuLabels.count - 1].reduce(0) { $0 + $1.name.widthWithConstrainedHeight(MenuHeight, font: font) }
                let freeSpaceToSplit = maxWidth - lastLabelWidth * 0.5 - allOtherLabelsWidth

                padding = freeSpaceToSplit / CGFloat(numberOfItems * 2)
            }
        } else { // all labels don't fit.  We iterate through all labels until we find the last one that fits, then we show half of that
            var currentWidth: CGFloat = 0
            
            for i in 0..<menuLabels.count {
                let labelWidth = menuLabels[i].name.widthWithConstrainedHeight(MenuHeight, font: font)
                if currentWidth + labelWidth < maxWidth {
                    currentWidth += labelWidth
                    continue
                }

                let spaceRemainingBeforeLabel = maxWidth - currentWidth
                let percentageOfVisibleLastLabelWithNoPadding = spaceRemainingBeforeLabel / labelWidth
                if percentageOfVisibleLastLabelWithNoPadding > 0.5 {
                    let freeSpaceToSplit = maxWidth - currentWidth - 0.5 * labelWidth
                    padding = freeSpaceToSplit / (CGFloat(i * 2) - 1)
                }

                // otherwise - just let normal autoresizing deal with it
            }
        }
    }

    override public var collectionViewContentSize: CGSize {
        var x: CGFloat           = 0
        
        for item in 0..<numberOfItems {
            let menuLabel = menuLabels[item]
            x += widthForString(string: menuLabel.name)
        }
        
        return CGSize(width: x, height: MenuHeight)
    }
}

