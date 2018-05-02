//
//  TitleTableViewHeaderFooterView.swift
//  StashUI
//
//  Created by Dawid Skiba on 10/20/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public struct TitleTableViewHeaderFooterViewModel: ReuseIdentifierable {
    public var reuseIdentifier: String {
        return TitleTableViewHeaderFooterView.reuseIdentifier
    }
    
    let title: String?
    let attributedString: NSAttributedString?
    let labelStyle: LabelStyle
    let backgroundColor: UIColor

    public var edgeInset: UIEdgeInsets = TitleTableViewHeaderFooterViewModel.defaultEdgeInsets
    
    public static let defaultEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: -16, right: -16)
    
    public init(title: String, labelStyle: LabelStyle, backgroundColor: UIColor = .clear) {
        self.title = title
        self.attributedString = nil
        self.labelStyle = labelStyle
        self.backgroundColor = backgroundColor
    }
    
    public init(attributedString: NSAttributedString, labelStyle: LabelStyle, backgroundColor: UIColor) {
        self.title = nil
        self.attributedString = attributedString
        self.labelStyle = labelStyle
        self.backgroundColor = backgroundColor
    }
}

public class TitleTableViewHeaderFooterView: UITableViewHeaderFooterView {
    fileprivate let titleLabel = UILabel()

    fileprivate var edgeInsets: UIEdgeInsets = TitleTableViewHeaderFooterViewModel.defaultEdgeInsets {
        didSet {
            if oldValue == edgeInsets { return }
            updateEdgeInsets()
        }
    }
    
    public static var reuseIdentifier = String(describing: TitleTableViewHeaderFooterView.self)
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: TitleTableViewHeaderFooterView.reuseIdentifier)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setup(model: TitleTableViewHeaderFooterViewModel) {
        titleLabel.stashalize(model.labelStyle)

        if let attributedString = model.attributedString {
            titleLabel.attributedText = attributedString
        } else if let title = model.title {
            titleLabel.text = title
        }
        
        contentView.backgroundColor = model.backgroundColor
    }
}

private extension TitleTableViewHeaderFooterView {
    func setup() {
        clipsToBounds = true

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(self.edgeInsets.left)
            make.right.equalTo(self.snp.right).offset(self.edgeInsets.right)
            make.centerY.equalTo(self.snp.centerY)
            make.top.greaterThanOrEqualTo(self.snp.top).offset(self.edgeInsets.top)
            make.bottom.greaterThanOrEqualTo(self.snp.bottom).offset(self.edgeInsets.bottom)
        }
    }
    
    func updateEdgeInsets() {
        titleLabel.snp.updateConstraints { (make) in
            make.right.equalTo(self.snp.right).offset(self.edgeInsets.right)
            make.left.equalTo(self.snp.left).offset(self.edgeInsets.left)
            make.centerY.equalTo(self.snp.centerY)
            make.top.greaterThanOrEqualTo(self.snp.top).offset(self.edgeInsets.top)
            make.bottom.greaterThanOrEqualTo(self.snp.bottom).offset(self.edgeInsets.bottom)
        }
    }
}
