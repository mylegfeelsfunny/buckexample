//
//  Mail.swift
//  StashInvest
//
//  Created by Kenny Sanchez on 4/25/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation

public struct Mail {
    public let subject: String
    public let toRecipients: [String]
    public let body: String
    
    public init(subject: String = "", toRecipients: [String], body: String = "") {
        self.subject = subject
        self.toRecipients = toRecipients
        self.body = body
    }
}

extension Mail {

    init?(url: URL) {
        if url.scheme != "mailto" {
            return nil
        }

        let components = URLComponents(string: url.absoluteString)
        self.subject = components?.queryItems?.first(where: { $0.name == "subject"})?.value ?? ""
        self.body = components?.queryItems?.first(where: { $0.name == "body"})?.value ?? ""
        self.toRecipients = components?.path.components(separatedBy: ",") ?? []
    }
}
