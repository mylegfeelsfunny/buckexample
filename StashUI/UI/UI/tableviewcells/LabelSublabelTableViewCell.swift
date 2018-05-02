//
//  LabelSublabelTableViewCell.swift
//  StashUI
//
//  Created by Dawid Skiba on 1/3/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import UIKit
import SnapKit

public struct LabelSublabelTVCViewModel: ReuseIdentifierable {
    public var reuseIdentifier: String {
        return LabelSublabelTableViewCell.reuseIdentifier
    }
    
    let topLabelText: String
    let topLabelStyle: LabelStyle
    let bottomLabelText: String?
    let bottomLabelStyle: LabelStyle
    let edgeInsets: UIEdgeInsets
    
    public static let defaultEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: -12, right: -16)
    
    public init(topText: String, topLabelStyle: LabelStyle, bottomText: String?, bottomLabelStyle: LabelStyle, edgeInsets: UIEdgeInsets = LabelSublabelTVCViewModel.defaultEdgeInsets) {
        topLabelText = topText
        self.topLabelStyle = topLabelStyle
        bottomLabelText = bottomText
        self.bottomLabelStyle = bottomLabelStyle
    
        self.edgeInsets = edgeInsets
    }
}

public class LabelSublabelTableViewCell: UITableViewCell, CellColorSelectable {
    public let topLabel = UILabel()
    public let bottomLabel = UILabel()
    fileprivate var edgeInsets: UIEdgeInsets = LabelSublabelTVCViewModel.defaultEdgeInsets {
        didSet {
            if oldValue == edgeInsets { return }
            updateEdgeInsets()
        }
    }
    
    // CLASS
    public static var reuseIdentifier = String(describing: LabelSublabelTableViewCell.self)
    
    // MARK: Init
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: LabelSublabelTableViewCell.reuseIdentifier)
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
    public func setup(with model: LabelSublabelTVCViewModel) {
        topLabel.text = model.topLabelText
        topLabel.stashalize(model.topLabelStyle)
        
        bottomLabel.text = model.bottomLabelText
        bottomLabel.stashalize(model.bottomLabelStyle)
        
        self.edgeInsets = model.edgeInsets
    }
}

private extension LabelSublabelTableViewCell {
    func setup() {
        clipsToBounds = true
        setupBackgroundSelectionColor()
        
        // question
        addSubview(topLabel)
        topLabel.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
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
    }
    
    func updateEdgeInsets() {
        topLabel.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
        }
        
        bottomLabel.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
    }
}
