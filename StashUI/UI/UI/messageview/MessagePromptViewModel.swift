
//
//  MessagePromptViewModel.swift
//  AFNetworking
//
//  Created by Dawid Skiba on 3/20/18.
//

import Foundation

public typealias MessageComponent = (headline: String, body: String)

public struct MessagePromptViewModel {
    public let headline: String
    public let headlineStyle: LabelStyle

    public let body: String
    public let bodyStyle: LabelStyle
    
    public init(headline: String, headlineStyle: LabelStyle, body: String, bodyStyle: LabelStyle) {
        self.headline = headline
        self.headlineStyle = headlineStyle
        self.body = body
        self.bodyStyle = bodyStyle
    }
    
    public init(messageComponent: MessageComponent, headlineStyle: LabelStyle, bodyStyle: LabelStyle) {
        self.headline = messageComponent.headline
        self.headlineStyle = headlineStyle
        self.body = messageComponent.body
        self.bodyStyle = bodyStyle
    }
}
