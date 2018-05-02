//
//  PhoneNumberWireframe.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 5/23/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public typealias PhoneNumber = String

public final class PhoneNumberWireframe {
    
    private let phoneNumber: PhoneNumber
    private weak var viewController: UIViewController?
    public var callTitle: String            = "Call"
    public var cancelTitle: String          = "Cancel"
    
    public init(phoneNumber: PhoneNumber, on vc: UIViewController) {
        self.phoneNumber                    = phoneNumber
        self.viewController                 = vc
    }
    
    public func call(application: ApplicationHandlerInterface) {
        guard let url                       = URL(string: "tel://\(phoneNumber)") else { return }
        let alertController                 = UIAlertController(title: phoneNumber, message:nil, preferredStyle: .alert)
        let cancelAction                    = UIAlertAction(title: cancelTitle, style: .default) { _ in }
        let yesAction                       = UIAlertAction(title: callTitle, style: .default) { _  in 
            application.open(url)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(yesAction)
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
