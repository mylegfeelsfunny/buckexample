//
//  TitleSubtitleTableViewHeaderFooterView.swift
//  StashUI
//
//  Created by Anton Gladkov on 10/23/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public class TitleSubtitleTableViewHeaderFooterView: UITableViewHeaderFooterView {
    @IBOutlet public weak var titleLabel: UILabel!
    @IBOutlet public weak var subtitleLabel: UILabel!

    public static let reuseIdentifier = String(describing: TitleSubtitleTableViewHeaderFooterView.self)
    public static let nib = UINib(nibName: String(describing: TitleSubtitleTableViewHeaderFooterView.self), bundle: Bundle(for: TitleSubtitleTableViewHeaderFooterView.self))

    public override func awakeFromNib() {
        super.awakeFromNib()

        titleLabel.font = .title1
        titleLabel.textColor = .stashBlue

        subtitleLabel.font = .body4
        subtitleLabel.textColor = .stashBlue
    }
}
