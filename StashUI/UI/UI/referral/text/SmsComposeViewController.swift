//
//  SmsComposeViewController.swift
//  StashInvest
//
//  Created by Scott Jones on 8/23/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import MessageUI

public class SmsComposeViewController: MFMessageComposeViewController {
    
    var complete: DidSendSms?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.tintColor     = .white
    }
}

extension SmsComposeViewController {
    
    func configure(with sms: Sms) {
        messageComposeDelegate      = self
        recipients                  = sms.toRecipentsArray
        body                        = sms.messageString
    }
    
}

extension SmsComposeViewController: MFMessageComposeViewControllerDelegate {
    
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled, .failed:
            complete?(false)
        case .sent:
            complete?(true)
        }
    }
    
}
