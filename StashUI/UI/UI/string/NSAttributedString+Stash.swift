//
//  NSAttributedString+Stash.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 3/31/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation

public extension NSAttributedString {
    convenience init(string: String, attributes: Attributes) {
        self.init(string: string, attributes: attributes.attributes)
    }
}

public extension NSAttributedString {

    convenience public init(format: String, attributes: [NSAttributedStringKey: Any]? = nil, _ args: NSAttributedString...) {
        let attrib = NSMutableAttributedString()
        let components = format.components(separatedBy: "%@")
        let argsComponents: [NSAttributedString] = args.map { $0 }

        components.enumerated().forEach {
            attrib.append(NSAttributedString(string: $1, attributes: attributes ?? [:]))
            if $0 < argsComponents.count {
                attrib.append(argsComponents[$0])
            }
        }

        self.init(attributedString: attrib)
    }
}
