//
//  LabelSublabelChevronTableViewCell.swift
//  StashInvest
//
//  Created by Dawid Skiba on 9/6/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import SnapKit

public struct LabelSublabelChevronTVCViewModel: ReuseIdentifierable {
    public var reuseIdentifier: String {
        return LabelSublabelChevronTableViewCell.reuseIdentifier
    }
    
    let topLabelText: String
    let topLabelStyle: LabelStyle
    let bottomLabelText: String?
    let bottomLabelStyle: LabelStyle
    let tintColor: UIColor
    let edgeInsets: UIEdgeInsets
    
    public static let defaultEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: -12, right: -16)
    
    public init(topText: String, topLabelStyle: LabelStyle, bottomText: String?, bottomLabelStyle: LabelStyle, tintColor: UIColor? = nil, edgeInsets: UIEdgeInsets = LabelSublabelChevronTVCViewModel.defaultEdgeInsets) {
        topLabelText = topText
        self.topLabelStyle = topLabelStyle
        bottomLabelText = bottomText
        self.bottomLabelStyle = bottomLabelStyle
        
        self.tintColor = tintColor ?? UIColor.stashPurple
        self.edgeInsets = edgeInsets
    }
}

public class LabelSublabelChevronTableViewCell: UITableViewCell, CellColorSelectable {
    fileprivate let chevron = ChevronView(type: .forward)
    public let topLabel = UILabel()
    public let bottomLabel = UILabel()
    fileprivate var edgeInsets: UIEdgeInsets = LabelSublabelChevronTVCViewModel.defaultEdgeInsets {
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
    public static var reuseIdentifier = String(describing: LabelSublabelChevronTableViewCell.self)
    public class var chevronSize: CGSize {
        return StyleGuide.chevronSize
    }
    
    // MARK: Init
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: LabelSublabelChevronTableViewCell.reuseIdentifier)
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
    public func setup(with model: LabelSublabelChevronTVCViewModel) {
        topLabel.text = model.topLabelText
        topLabel.stashalize(model.topLabelStyle)
        
        bottomLabel.text = model.bottomLabelText
        bottomLabel.stashalize(model.bottomLabelStyle)
        
        tintColor = model.tintColor
        self.edgeInsets = model.edgeInsets
    }
}

private extension LabelSublabelChevronTableViewCell {
    func setup() {
        clipsToBounds = true
        setupBackgroundSelectionColor()
        
        // question
        addSubview(topLabel)
        topLabel.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
        }
        
        // answer
        addSubview(bottomLabel)
        bottomLabel.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.topLabel.snp.left)
            make.right.equalTo(strongSelf.topLabel.snp.right)
            make.top.equalTo(strongSelf.topLabel.snp.bottom).offset(2.0)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
        
        // chevron
        addSubview(chevron)
        chevron.backgroundColor = .clear
        chevron.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.width.equalTo(LabelSublabelChevronTableViewCell.chevronSize.width)
            make.height.equalTo(LabelSublabelChevronTableViewCell.chevronSize.height)
            make.centerY.equalTo(strongSelf.snp.centerY)
            make.left.equalTo(strongSelf.topLabel.snp.right).offset(16.0)
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
        }
    }
    
    func updateEdgeInsets() {
        topLabel.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
        }
        
        bottomLabel.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
        
        chevron.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
        }
    }
}
