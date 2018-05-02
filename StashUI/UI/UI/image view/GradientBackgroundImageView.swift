//
//  GradientBackgroundImageView.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 6/13/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public final class GradientBackgroundImageView: UIImageView {
    
    public override func willMove(toSuperview newSuperview: UIView?) {
        image = .gradient
    }
}
