//
//  HapticFeedbackGenerator.swift
//  StashInvest
//
//  Created by Morgan Collino on 3/1/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

public enum HapticFeedbackGeneratorType {
    case light
    case medium
    case heavy
}

public protocol FeedbackGenerator {
    
    static func generator(style: HapticFeedbackGeneratorType) -> FeedbackGenerator
    func prepare()
    func impactOccurred()
    
}

@available(iOS 10.0, *)
extension UIImpactFeedbackGenerator: FeedbackGenerator {
    
    static public func generator(style: HapticFeedbackGeneratorType) -> FeedbackGenerator {
        let hapticStyle: UIImpactFeedbackStyle = {
            switch style {
            case .light:
                return .light
            case .medium:
                return .medium
            case .heavy:
                return .heavy
            }
        }()
        
        return UIImpactFeedbackGenerator(style: hapticStyle)
    }
    
}

public struct HapticFeedbackGenerator {
    
    private let generator: FeedbackGenerator?
    
    public init(style: HapticFeedbackGeneratorType) {
        if #available(iOS 10.0, *) {
            self.generator = UIImpactFeedbackGenerator.generator(style: style)
        } else {
            self.generator = nil
        }
    }
    
    public func impactOccurred() {
        generator?.prepare()
        generator?.impactOccurred()
    }
    
}
