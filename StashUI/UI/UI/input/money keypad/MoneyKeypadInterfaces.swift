//
//  MoneyKeypadInterfaces.swift
//  StashInvest
//
//  Created by Daniel Ramteke on 7/26/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation


public protocol MoneyKeypadOutput: class {
    func updatedAmount(_ amount: (doubleValue: Double, displayValue: String))
    func dismissPressed()
}

public extension MoneyKeypadOutput {
    func dismissPressed() { /* NADA */ }
}

