//
//  UICollectionView+Collection.swift
//  Home
//
//  Created by Mikael Konutgan on 5/3/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import ObjectiveC

private var collectionViewDataSourceKey = "CollectionViewDataSource"
private var collectionViewDelegateKey = "CollectionViewDataSource"

extension UICollectionView {
    
    public func register(collection: Collection) {
        collection.sections.forEach { section in
            section.items.forEach { item in
                register(item.registration)
            }
            
            if let header = section.header {
                register(header.registration)
            }
        }
    }
    
    public func configure(with collection: Collection,
                          checkDataHashValue: Bool = false,
                          didScroll: ((UIScrollView) -> Void)? = nil,
                          willEndDragging: ((UIScrollView, CGPoint, UnsafeMutablePointer<CGPoint>) -> Void)? = nil,
                          didEndScrolling: ((UIScrollView, Bool) -> Void)? = nil) {
        if checkDataHashValue,
            let currentDataHashValue = collectionViewDataSource?.collection.dataHashValue,
            let newDataHashValue = collection.dataHashValue,
            currentDataHashValue == newDataHashValue {
            return
        }

        register(collection: collection)
        
        collectionViewDataSource = CollectionViewDataSource(collection: collection)
        collectionViewDelegate = CollectionViewDelegate(collection: collection)
        collectionViewDelegate.didScroll = didScroll
        collectionViewDelegate.willEndDragging = willEndDragging
        collectionViewDelegate.didEndScrolling = didEndScrolling
        delegate = collectionViewDelegate
        dataSource = collectionViewDataSource
        
        reloadData()
        collection.defaultSelection.map(selectItem(at:animated:scrollPosition:))
    }
    
    private var collectionViewDataSource: CollectionViewDataSource? {
        get {
            return objc_getAssociatedObject(self, &collectionViewDataSourceKey) as? CollectionViewDataSource
        }
        
        set {
            objc_setAssociatedObject(self, &collectionViewDataSourceKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private var collectionViewDelegate: CollectionViewDelegate {
        get {
            return objc_getAssociatedObject(self, &collectionViewDelegateKey) as! CollectionViewDelegate
        }
        
        set {
            objc_setAssociatedObject(self, &collectionViewDelegateKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
