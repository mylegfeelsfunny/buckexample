//
//  MyStashCollectionViewCell.swift
//  StashInvest
//
//  Created by Scott Jones on 10/10/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public class ContentCollectionViewCell: UICollectionViewCell {

    public static let identifier: String            = "ContentCollectionViewCell"
    public weak var lastVC: UIViewController?

    override public func prepareForReuse() {
        super.prepareForReuse()
        willDisappear()
    }

    func willDisappear() {
        if let lvc = lastVC {
            lvc.beginAppearanceTransition(false, animated: false)
            for v in contentView.subviews { v.removeFromSuperview() }
            lvc.endAppearanceTransition()
        }
    }
}

public extension ContentCollectionViewCell {
    
    func configure(for viewController: UIViewController) {
        lastVC = viewController
        lastVC?.beginAppearanceTransition(true, animated: false)
        contentView.addSubview(viewController.view)
        viewController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        lastVC?.endAppearanceTransition()
    }
}
