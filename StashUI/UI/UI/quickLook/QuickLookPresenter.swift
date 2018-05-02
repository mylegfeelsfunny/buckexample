//
//  QuickLookPresenter.swift
//  StashUI
//
//  Created by Kenny Sanchez on 12/12/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

protocol QuickLookPresenterInterface: class {
    
    func didLoad()
    func dismissTapped()
}

class QuickLookPresenter {
    
    var wireframe: QuickLookWireframePresenterInterface?
    weak var view: QuickLookViewInterface?
}

extension QuickLookPresenter: QuickLookPresenterInterface {
    
    func didLoad() {
    }
    
    func dismissTapped() {
        wireframe?.dismiss()
    }
}

