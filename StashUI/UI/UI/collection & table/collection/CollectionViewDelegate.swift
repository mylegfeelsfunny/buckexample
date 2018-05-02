//
//  CollectionViewDelegate.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/5/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    public let collection: Collection
    public var didScroll: ((UIScrollView) -> Void)?
    public var willEndDragging: ((UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void)?
    public var didEndDragging: ((UIScrollView, Bool) -> Void)?
    public var didEndScrolling: ((UIScrollView, Bool) -> Void)?

    private var willPaginate: Bool = false
    private var currentOffset: CGFloat = 0.0

    public init(collection: Collection) {
        self.collection = collection
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collection.item(at: indexPath)?.didSelect?(collectionView, indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collection.item(at: indexPath)?.willDisplay?(collectionView, cell, indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collection.item(at: indexPath)?.didDisplay?(collectionView, cell, indexPath)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        didScroll?(scrollView)
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        willEndDragging?(scrollView, velocity, targetContentOffset)
        willPaginate = currentOffset != targetContentOffset.pointee.x
        currentOffset = targetContentOffset.pointee.x
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                         willDecelerate decelerate: Bool) {
        didEndDragging?(scrollView, decelerate)
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        didEndScrolling?(scrollView, willPaginate)
    }
}

extension CollectionViewDelegate: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collection.item(at: indexPath)?.size?(collectionView, collectionViewLayout, indexPath) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collection.section(at: section)?.inset?(collectionView, collectionViewLayout, section) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collection.section(at: section)?.minimumLineSpacing?(collectionView, collectionViewLayout, section) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumLineSpacing ?? 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return collection.section(at: section)?.minimumInteritemSpacing?(collectionView, collectionViewLayout, section) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return collection.section(at: section)?.header?.size?(collectionView, collectionViewLayout, section) ?? (collectionViewLayout as? UICollectionViewFlowLayout)?.headerReferenceSize ?? .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return (collectionViewLayout as? UICollectionViewFlowLayout)?.footerReferenceSize ?? .zero
    }
}
