//
//  SuccessResponse.swift
//  StashInvest
//
//  Created by Scott Jones on 6/19/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

public typealias ErrorResponse     = SuccessResponse
public class SuccessResponse: NSObject {
    
    public let message: String
    public let error: Bool
    let deepLink: String?
    var removeSelfTimer: Timer?
    
    public init(message:String, deepLink:String? = nil) {
        self.message        = message
        self.deepLink       = deepLink
        self.error          = false
    }
    
    public init(withErrorMessage message:String) {
        self.message        = message
        self.deepLink       = nil
        self.error          = true
    }
    
}

extension SuccessResponse {
    
    var font:UIFont {
        return .subtitle3
    }
    
    var backgroundColor:UIColor {
        switch error {
        case true:
            return .stashPaleRed
        default:
            return .stashGreen
        }
    }
    
    var widthForSuccessText:CGFloat {
        let screenWidth     = UIScreen.main.bounds.width
        return screenWidth * 0.9
    }
    
    var widthForFailedText:CGFloat {
        let screenWidth     = UIScreen.main.bounds.width
        return screenWidth * 0.9
    }
    
    var extraSpace:CGFloat {
        let screenheight    = UIScreen.main.bounds.height
        return screenheight * 0.028
    }
    
}
protocol Heightable {
    func height()->CGFloat
}
extension SuccessResponse : Heightable {
    func height()->CGFloat {
        switch error {
        case true:
            return message.heightWithConstrainedWidth(widthForFailedText, font: font) + extraSpace
        default:
            return message.heightWithConstrainedWidth(widthForSuccessText, font: font) + extraSpace
        }
    }
}
extension Sequence where Iterator.Element:Heightable {
    
    func totalHeight()->CGFloat {
        let height = reduce(0.0) { $0 + $1.height() }
        return height == 0.0 ? CGFloat.leastNormalMagnitude : height
    }
    
}
