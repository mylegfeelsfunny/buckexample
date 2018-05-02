//
//  AlertViewModel.swift
//  stash-invest-ios
//
//  Created by Mikael Konutgan on 1/9/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

struct AlertViewModel {
    
    let title: String?, message: String?, actions: [AlertAction]
    
    fileprivate let bounds = UIScreen.main.bounds.insetBy(dx: UIScreen.main.scale == 2.0 ? 24.0 : 48.0, dy: 0.0)
    fileprivate let margin: CGFloat = 16.0
}

extension AlertViewModel {
    var titleFont: UIFont {
        return .title2
    }
    
    var messageFont: UIFont {
        return .subtitle3
    }
    
    var attributedTitle: NSAttributedString? {
        guard let title = title else {
            return nil
        }
        
        return NSAttributedString(string: title, attributes: [
            NSAttributedStringKey.font: titleFont
        ])
    }
    
    var attributedMessage: NSAttributedString? {
        guard let message = message else {
            return nil
        }
        
        return NSAttributedString(string: message, attributes: [
            NSAttributedStringKey.font: messageFont,
            NSAttributedStringKey.paragraphStyle: {
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 2.0
                return style
            }()
        ])
    }
    
    var needsSpace: Bool {
        return actions.count == 1 && actions.first?.style == .default
    }
}

extension AlertViewModel {
    
    func headerSize() -> CGSize {
        let width = bounds.size.width
        let height = headerTitleViewHeight() + headerMessageViewHeight()
        
        return CGSize(width: width, height: height)
    }
    
    func actionSize() -> CGSize {
        return CGSize(width: bounds.size.width, height: 60.0)
    }
    
    func headerTitleViewHeight() -> CGFloat {
        guard let attributedTitle = attributedTitle else {
            return 0.0
        }
        
        let size = bounds.insetBy(dx: 16.0, dy: 0.0).size
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let titleHeight = attributedTitle.boundingRect(with: size, options: options, context: nil).size.height
        
        return max(ceil((titleHeight + 2.0 + margin * 2.0) / 5.0) * 5.0, 60.0)
    }
    
    func headerMessageViewHeight() -> CGFloat {
        guard let attributedMessage = attributedMessage else {
            return 16.0
        }
        
        let size = bounds.insetBy(dx: 16.0, dy: 0.0).size
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let messageHeight = attributedMessage.boundingRect(with: size, options: options, context: nil).size.height
        
        return max(ceil((messageHeight + 2.0 + margin * 2.0) / 5.0) * 5.0, 60.0)
    }
}
