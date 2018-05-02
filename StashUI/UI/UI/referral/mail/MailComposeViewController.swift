//
//  MailComposeViewController.swift
//  StashInvest
//
//  Created by Kenny Sanchez on 4/25/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import MessageUI

public typealias DidSendMail = (Bool) -> Void

public class MailComposeViewController: MFMailComposeViewController {
   
    var complete: DidSendMail?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.tintColor = .white
    }
}

extension MailComposeViewController {
    
    func configure(with mail: Mail) {
        setSubject(mail.subject)
        setToRecipients(mail.toRecipients)
        setMessageBody(mail.body, isHTML: false)
    }
    
}

extension MailComposeViewController: MFMailComposeViewControllerDelegate {
    
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled, .saved, .failed:
            complete?(false)
        case .sent:
            complete?(true)
        }
    }
}
