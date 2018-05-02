//
//  Sms.swift
//  StashInvest
//
//  Created by Scott Jones on 8/23/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation

public struct Sms {
    
    let messageString:String
    let toRecipentsArray:[String]
    
    public init(message: String, toRecipients: [String]) {
        self.messageString              = message
        self.toRecipentsArray           = toRecipients
    }
    
}
