//
//  Array+STI.swift
//  StashUI
//
//  Created by Scott Jones on 11/29/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation

extension Array {
    
    mutating func remove(safeAt index: Index) {
        guard index >= 0 && index < count else {
            print("Index out of bounds while deleting item at index \(index) in \(self). This action is ignored.")
            return
        }
        remove(at: index)
    }
    
    mutating func insert(_ element: Element, safeAt index: Index) {
        guard index >= 0 && index <= count else {
            print("Index out of bounds while inserting item at index \(index) in \(self). This action is ignored")
            return
        }
        insert(element, at: index)
    }
    
    subscript (safe index: Index) -> Element? {
        get {
            return indices.contains(index) ? self[index] : nil
        }
        set {
            remove(safeAt: index)
            if let element = newValue {
                insert(element, safeAt: index)
            }
        }
    }
    
}
