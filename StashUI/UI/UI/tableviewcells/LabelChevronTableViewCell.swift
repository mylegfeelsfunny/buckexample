//
//  LabelChevronTableViewCell.swift
//  StashInvest
//
//  Created by Dawid Skiba on 8/28/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import SnapKit

public struct LabelChevronTVCViewModel: ReuseIdentifierable {
    public var reuseIdentifier: String {
        return LabelChevronTableViewCell.reuseIdentifier
    }

    let title: String
    let labelStyle: LabelStyle
    let tintColor: UIColor
    let edgeInsets: UIEdgeInsets

    public static let defaultEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: -20, right: -16)
    
    public init(title: String, labelStyle: LabelStyle, tintColor: UIColor? = nil, edgeInsets: UIEdgeInsets = LabelChevronTVCViewModel.defaultEdgeInsets) {
        self.title = title
        self.labelStyle = labelStyle
        self.tintColor = tintColor ?? UIColor.stashPurple
        self.edgeInsets = edgeInsets
    }
}

public class LabelChevronTableViewCell: UITableViewCell, CellColorSelectable {
    fileprivate let chevron = ChevronView(type: .forward)
    public let titleLabel = UILabel()
    fileprivate var edgeInsets: UIEdgeInsets = LabelChevronTVCViewModel.defaultEdgeInsets {
        didSet {
            if oldValue == edgeInsets { return }
            updateEdgeInsets()
        }
    }
    
    override public var tintColor: UIColor! {
        didSet {
            if oldValue == tintColor { return }
            chevron.strokeColor = tintColor
        }
    }
    
    // CLASS
    public static var reuseIdentifier = String(describing: LabelChevronTableViewCell.self)    
    public class var chevronSize: CGSize {
        return StyleGuide.chevronSize
    }

    // INIT
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: LabelChevronTableViewCell.reuseIdentifier)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: Public
    public func setup(with model: LabelChevronTVCViewModel) {
        titleLabel.text = model.title
        titleLabel.stashalize(model.labelStyle)
        self.edgeInsets = model.edgeInsets
        
        tintColor = model.tintColor
    }
}

private extension LabelChevronTableViewCell {
    func setup() {
        clipsToBounds = true
        setupBackgroundSelectionColor()
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
        
        addSubview(chevron)
        chevron.backgroundColor = .clear
        chevron.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.width.equalTo(LabelChevronTableViewCell.chevronSize.width)
            make.height.equalTo(LabelChevronTableViewCell.chevronSize.height)
            make.centerY.equalTo(strongSelf.snp.centerY)
            make.left.equalTo(strongSelf.titleLabel.snp.right).offset(16.0)
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
        }
    }
    
    func updateEdgeInsets() {
        titleLabel.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
        
        chevron.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
        }
    }
}
