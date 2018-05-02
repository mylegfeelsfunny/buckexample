//
//  SmsWireframe.swift
//  StashInvest
//
//  Created by Scott Jones on 8/23/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation
import MessageUI

public typealias DidSendSms = (Bool) -> Void

public class SmsWireframe {
    
    let smsComposeViewController: SmsComposeViewController
    
    public init(sms: Sms) {
        smsComposeViewController                        = SmsComposeViewController()
        smsComposeViewController.messageComposeDelegate = smsComposeViewController
        smsComposeViewController.configure(with: sms)
    }
    
    public func present(from presentingViewController: UIViewController, complete: DidSendSms? = nil) {
        if canSendMail() {
            smsComposeViewController.complete = { didSend in
                self.smsComposeViewController.dismiss(animated: true) {
                    complete?(didSend)
                }
            }
            presentingViewController.present(smsComposeViewController, animated: true, completion: nil)
        }
    }
    
    public func canSendMail() -> Bool {
        return SmsComposeViewController.canSendText()
    }
    
}
