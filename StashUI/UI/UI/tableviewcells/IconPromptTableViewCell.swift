//
//  ImagePromptViewTableViewCell.swift
//  AFNetworking
//
//  Created by Dawid Skiba on 3/13/18.
//

import UIKit

public struct IconPromptTVCViewModel: ReuseIdentifierable {
    public var reuseIdentifier: String {
        return IconPromptTableViewCell.reuseIdentifier
    }
    
    let imagePromptViewModel: ImagePromptViewModel
    
    public init(imagePromptViewModel: ImagePromptViewModel) {
        self.imagePromptViewModel = imagePromptViewModel
    }
}

public class IconPromptTableViewCell: UITableViewCell {

    // CLASS
    public static var reuseIdentifier = String(describing: IconPromptTableViewCell.self)
    
    // INIT
    override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: IconPromptTableViewCell.reuseIdentifier)
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
    public func setup(with model: IconPromptTVCViewModel) {
        removeImagePromptView()
        let insets = UIEdgeInsets(top: StyleGuide.padVertical, left: 0, bottom: -StyleGuide.padVertical, right: 0)
        addImagePromptView(model: model.imagePromptViewModel)
    }
}

private extension IconPromptTableViewCell {
    func setup() {
        clipsToBounds = true
        backgroundColor = .clear
    }
}
