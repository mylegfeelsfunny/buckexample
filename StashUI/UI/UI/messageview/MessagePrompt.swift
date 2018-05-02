//
//  MessageView.swift
//  AFNetworking
//
//  Created by Dawid Skiba on 3/20/18.
//

import UIKit

public class MessagePrompt: UIView {
    private let headlineLabel = UILabel()
    private let bodyLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func configure(withViewModel model: MessagePromptViewModel) {
        headlineLabel.stashalize(model.headlineStyle)
        bodyLabel.stashalize(model.bodyStyle)
        
        headlineLabel.text = model.headline
        bodyLabel.text = model.body
    }
}

private extension MessagePrompt {
    func setup() {
        clipsToBounds = true
        backgroundColor = .clear
        
        addSubview(headlineLabel)
        headlineLabel.backgroundColor = .clear
        headlineLabel.setContentHuggingPriority(.required, for: .vertical)
        headlineLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        headlineLabel.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
        }
        
        addSubview(bodyLabel)
        bodyLabel.backgroundColor = .clear
        bodyLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        bodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        bodyLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(headlineLabel)
            make.top.equalTo(headlineLabel.snp.bottom).offset(2)
            make.bottom.equalTo(self)
        }
    }
}
