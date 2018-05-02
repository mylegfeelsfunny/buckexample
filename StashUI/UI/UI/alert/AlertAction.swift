//
//  AlertAction.swift
//  stash-invest-ios
//
//  Created by Mikael Konutgan on 1/5/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation

public enum AlertActionStyle: Int {
    case `default`, cancel
}

public typealias AlertActionHandler = (AlertAction) -> Void

public class AlertAction: NSObject {
    let title: String
    let style: AlertActionStyle
    let handler: AlertActionHandler
    
    public init(title: String, style: AlertActionStyle, handler: @escaping AlertActionHandler = { _ in }) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}
