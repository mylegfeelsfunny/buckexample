//
//  MailWireframe.swift
//  StashInvest
//
//  Created by Kenny Sanchez on 4/25/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation
import MessageUI

public class MailWireframe {
    
    let mailComposeViewController: MailComposeViewController
    
    public init(mail: Mail) {
        mailComposeViewController                       = MailComposeViewController()
        mailComposeViewController.mailComposeDelegate   = mailComposeViewController
        mailComposeViewController.configure(with: mail)
    }
    
    public func present(from presentingViewController: UIViewController, complete: DidSendMail? = nil) {
        if canSendMail() {
            mailComposeViewController.complete = { didSend in
                self.mailComposeViewController.dismiss(animated: true) {
                    complete?(didSend)
                }
            }
            presentingViewController.present(mailComposeViewController, animated: true, completion: nil)
        }
    }
    
    public func canSendMail() -> Bool {
        return MailComposeViewController.canSendMail()
    }

}
