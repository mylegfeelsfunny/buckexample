//
//  PromptSelectionChevronTableViewCell.swift
//  StashUI
//
//  Created by Dawid Skiba on 9/13/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit
import SnapKit

private let kNeighborViewsSpacing: CGFloat = 16

public struct PromptSelectionChevronTVCViewModel: ReuseIdentifierable {
    public var reuseIdentifier: String {
        return PromptSelectionChevronTableViewCell.reuseIdentifier
    }
    
    let prompt: String
    let promptLabelStyle: LabelStyle
    let selection: String
    let selectionLabelStyle: LabelStyle
    let edgeInsets: UIEdgeInsets
    let chevronColor: UIColor?
    
    public static let defaultEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: -20, right: -16)
    
    public init(prompt: String, promptLabelStyle: LabelStyle, selection: String, selectionLabelStyle: LabelStyle, chevronColor: UIColor? = nil, edgeInsets: UIEdgeInsets = PromptSelectionChevronTVCViewModel.defaultEdgeInsets) {
        self.prompt = prompt
        self.promptLabelStyle = promptLabelStyle
        self.selection = selection
        self.selectionLabelStyle = selectionLabelStyle
        self.edgeInsets = edgeInsets
        self.chevronColor = chevronColor
    }
}

public class PromptSelectionChevronTableViewCell: UITableViewCell, CellColorSelectable {
    public let promptLabel = UILabel()
    public let selectionLabel = UILabel()
    fileprivate let chevron = ChevronView(type: .forward)
    fileprivate var selectionTrailingConstraint: Constraint?
    fileprivate var edgeInsets: UIEdgeInsets = PromptSelectionChevronTVCViewModel.defaultEdgeInsets {
        didSet {
            if oldValue == edgeInsets { return }
            updateEdgeInsets()
        }
    }
    
    public class var chevronSize: CGSize {
        return StyleGuide.chevronSize
    }
    
    override public var tintColor: UIColor! {
        didSet {
            if oldValue == tintColor { return }
            chevron.strokeColor = tintColor
        }
    }
    
    // CLASS
    public static var reuseIdentifier = String(describing: PromptSelectionChevronTableViewCell.self)
    
    // INIT
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: PromptSelectionChevronTableViewCell.reuseIdentifier)
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
    public func setup(with model: PromptSelectionChevronTVCViewModel) {
        promptLabel.text = model.prompt
        promptLabel.stashalize(model.promptLabelStyle)
        
        selectionLabel.text = model.selection
        selectionLabel.stashalize(model.selectionLabelStyle)
        edgeInsets = model.edgeInsets
        
        // logic for chevron
        let chevronWasHidden = chevron.isHidden
        if let chevronColor = model.chevronColor {
            chevron.isHidden = false
            tintColor = chevronColor
            if chevronWasHidden { updateChevronVisibilityConstraints() }  // must go last
        } else {
            chevron.isHidden = true
            if chevronWasHidden == false { updateChevronVisibilityConstraints() }
        }
    }
}

private extension PromptSelectionChevronTableViewCell {
    func setup() {
        clipsToBounds = true
        setupBackgroundSelectionColor()
        
        addSubview(promptLabel)
        promptLabel.setContentHuggingPriority(.required, for: .horizontal)
        promptLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        promptLabel.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
        
        addSubview(selectionLabel)
        selectionLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        selectionLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        selectionLabel.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.promptLabel.snp.right).offset(kNeighborViewsSpacing)
            strongSelf.selectionTrailingConstraint = make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right).constraint
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
        
        addSubview(chevron)
        chevron.backgroundColor = .clear
        chevron.isHidden = true   // yass true, since original padding for it is to be hidden
        chevron.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.width.equalTo(PromptSelectionChevronTableViewCell.chevronSize.width)
            make.height.equalTo(PromptSelectionChevronTableViewCell.chevronSize.height)
            make.centerY.equalTo(strongSelf.snp.centerY)
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
        }
    }
    
    func updateEdgeInsets() {
        promptLabel.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
        
        selectionLabel.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
        
        updateChevronVisibilityConstraints()
        chevron.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
        }
    }
    
    func updateChevronVisibilityConstraints() {
        if let constraint = selectionTrailingConstraint {
            let offset = chevron.isHidden ? edgeInsets.right : (edgeInsets.right - PromptSelectionChevronTableViewCell.chevronSize.width - kNeighborViewsSpacing)
            constraint.update(offset: offset)
        }
    }
}
