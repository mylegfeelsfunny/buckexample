//
//  LoadingCell.swift
//  StashUI
//
//  Created by Anton Gladkov on 9/22/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class LoadingCell: UITableViewCell {

    public static let reuseIdentifier = String(describing: LoadingCell.self)
    public static let nib = UINib(nibName: String(describing: LoadingCell.self), bundle: Bundle(for: LoadingCell.self))

    @IBOutlet weak var activityIndicatorView: ActivityIndicatorView!

    public func startAnimating() {
        if !activityIndicatorView.isAnimating {
            activityIndicatorView.startAnimating()
        }
    }

    override public func prepareForReuse() {
        super.prepareForReuse()
        activityIndicatorView.stopAnimating()
    }
}
