//
//  LabelSwitchTableViewCell.swift
//  StashInvest
//
//  Created by Dawid Skiba on 8/28/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public protocol LabelSwitchTVCDelegate: class {
    func switchValueChanged(value: Bool, cell: LabelSwitchTableViewCell)
}

public struct LabelSwitchTVCViewModel: ReuseIdentifierable {
    public var reuseIdentifier: String {
        return LabelSwitchTableViewCell.reuseIdentifier
    }
    
    let title: String
    let labelStyle: LabelStyle
    let tintColor: UIColor
    let edgeInsets: UIEdgeInsets
    let isOn: Bool
    
    public static let defaultEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: -20, right: -16)
    
    public init(title: String, isOn: Bool, labelStyle: LabelStyle, tintColor: UIColor? = nil, edgeInsets: UIEdgeInsets = LabelSwitchTVCViewModel.defaultEdgeInsets) {
        self.title = title
        self.isOn = isOn
        self.labelStyle = labelStyle
        self.tintColor = tintColor ?? UIColor.stashPurple
        self.edgeInsets = edgeInsets
    }
}

public class LabelSwitchTableViewCell: UITableViewCell, CellColorSelectable {
    public var delegate: LabelSwitchTVCDelegate?
    public let switchView = UISwitch()
    public let titleLabel = UILabel()
    fileprivate var edgeInsets: UIEdgeInsets = LabelSwitchTVCViewModel.defaultEdgeInsets {
        didSet {
            if oldValue == edgeInsets { return }
            updateEdgeInsets()
        }
    }
    
    override public var tintColor: UIColor! {
        didSet {
            if oldValue == tintColor { return }
            switchView.onTintColor = tintColor
        }
    }
    
    // CLASS
    public static var reuseIdentifier = String(describing: LabelSwitchTableViewCell.self)
    public class var switchViewSize: CGSize {
        return CGSize(width: 51.0, height: 31.0)
    }
    
    // INIT
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: LabelSwitchTableViewCell.reuseIdentifier)
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
    public func setup(with model: LabelSwitchTVCViewModel) {
        titleLabel.text = model.title
        titleLabel.clipsToBounds = false
        titleLabel.stashalize(model.labelStyle)
        self.edgeInsets = model.edgeInsets
        
        switchView.isOn = model.isOn
        tintColor = model.tintColor
        switchView.onTintColor = model.tintColor
    }
}

private extension LabelSwitchTableViewCell {
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
        
        addSubview(switchView)
        switchView.backgroundColor = .clear
        switchView.snp.makeConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            make.width.equalTo(LabelSwitchTableViewCell.switchViewSize.width)
            make.height.equalTo(LabelSwitchTableViewCell.switchViewSize.height)
            make.centerY.equalTo(strongSelf.snp.centerY)
            make.left.equalTo(strongSelf.titleLabel.snp.right).offset(16.0)
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
        }
        switchView.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    func updateEdgeInsets() {
        titleLabel.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            
            make.left.equalTo(strongSelf.snp.left).offset(strongSelf.edgeInsets.left)
            make.top.equalTo(strongSelf.snp.top).offset(strongSelf.edgeInsets.top)
            make.bottom.equalTo(strongSelf.snp.bottom).offset(strongSelf.edgeInsets.bottom)
        }
        
        switchView.snp.updateConstraints { [weak self] (make) in
            guard let strongSelf = self else { return }
            
            make.right.equalTo(strongSelf.snp.right).offset(strongSelf.edgeInsets.right)
        }
    }
    
    @objc func switchValueChanged() {
        delegate?.switchValueChanged(value: switchView.isOn, cell: self)
    }
}
