//
//  HexStringTransformer.swift
//  stash-invest-ios
//
//  Created by Mikael Konutgan on 8/23/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

private extension Scanner {
    
    func scanHexColorComponent() -> UInt8? {
        var uint64: UInt64 = 0
        
        if scanHexInt64(&uint64) {
            return UInt8(uint64)
        }
        
        return nil
    }
}

class HexStringTransformer {
    
    func transform(hexString: String) -> (red: UInt8, green: UInt8, blue: UInt8)? {
        let string = hexString.lowercased().replacingOccurrences(of: "#", with: "")
        
        var colorComponents: [String] = []
        
        for offset in stride(from: 0, to: 6, by: 2) {
            let lowerBound = string.index(string.startIndex, offsetBy: offset)
            let upperBound = string.index(lowerBound, offsetBy: 2)
            let substring = string[lowerBound..<upperBound]
            colorComponents.append(String(substring))
        }
        
        let components = colorComponents.compactMap { Scanner(string: $0).scanHexColorComponent() }
        
        if components.count != 3 {
            return nil
        }
        
        return (red: components[0], green: components[1], blue: components[2])
    }
}

public extension UIColor {
    
    public convenience init?(hexString: String) {
        guard let (red, green, blue) = HexStringTransformer().transform(hexString: hexString) else {
            return nil
        }
        
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0)
    }
}
