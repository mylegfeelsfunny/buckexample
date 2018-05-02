//
//  LabelTableViewCell.swift
//  StashUI
//
//  Created by Dawid Skiba on 9/13/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public struct LabelTVCViewModel: ReuseIdentifierable {
    public var reuseIdentifier: String {
        return LabelTableViewCell.reuseIdentifier
    }
    
    let title: String
    let labelStyle: LabelStyle
    let edgeInsets: UIEdgeInsets
    
    public static let defaultEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: -20, right: -16)
    
    public init(title: String, labelStyle: LabelStyle, edgeInsets: UIEdgeInsets = LabelTVCViewModel.defaultEdgeInsets) {
        self.title = title
        self.labelStyle = labelStyle
        self.edgeInsets = edgeInsets
    }
}

public class LabelTableViewCell: UITableViewCell, CellColorSelectable {
    
    public let titleLabel = UILabel()
    fileprivate var edgeInsets: UIEdgeInsets = LabelTVCViewModel.defaultEdgeInsets {
        didSet {
            if oldValue == edgeInsets { return }
            updateEdgeInsets()
        }
    }
    
    // CLASS
    public static var reuseIdentifier = String(describing: LabelTableViewCell.self)

    // INIT
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: LabelTableViewCell.reuseIdentifier)
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
    public func setup(with model: LabelTVCViewModel) {
        titleLabel.text = model.title
        titleLabel.stashalize(model.labelStyle)
        self.edgeInsets = model.edgeInsets
    }
}

private extension LabelTableViewCell {
    func setup() {
        clipsToBounds = true
        setupBackgroundSelectionColor()
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
    }
    
    func updateEdgeInsets() {
        titleLabel.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
    }
}
