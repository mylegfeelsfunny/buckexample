//
//  Queue.swift
//  BannerStack
//
//  Created by Scott Jones on 11/17/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import Foundation

protocol Queue {
    associatedtype Element
    mutating func dequeue() -> Element?
    mutating func enqueue(_ newElement: Element)
}

public struct FIFOQueue<Element> {

    fileprivate var left: [Element] = []
    fileprivate var right: [Element] = []
    
    @discardableResult
    public mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
    
    public mutating func enqueue(_ newElement: Element) {
        right.append(newElement)
    }
}

extension FIFOQueue: Swift.Collection {
    
    public var startIndex: Int { return 0 }
    public var endIndex: Int { return left.count + right.count }
    
    public func index(after i: Int) -> Int {
        precondition(i < endIndex, "Index out of bounds")
        return i + 1
    }
    
    public subscript(position: Int) -> Element {
        precondition((0..<endIndex).contains(position), "Index out of bounds : \(position)")
        var a = allObjects
        return a[position]
    }
    
    public var allObjects: [Element] {
        return left.reversed() + right
    }
    
    public mutating func removeIndex(index position: Int) {
        var a = allObjects
        a.remove(at: position)
        left = a.reversed()
        right.removeAll()
    }
    
}

extension FIFOQueue :ExpressibleByArrayLiteral {
    
    public init(arrayLiteral elements:Element...) {
        self.init(left:elements.reversed(), right:[])
    }
    
    public init(array elements:[Element]) {
        self.init(left:elements.reversed(), right:[])
    }
    
}



































