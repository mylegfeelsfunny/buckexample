//
//  ImagePromptViewModel.swift
//  StashUI
//
//  Created by Dawid Skiba on 2/18/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import UIKit

public struct ImagePromptViewModel {
    public typealias LabelInfo = (text: String, style: LabelStyle)
    public typealias NeighborViewPads = (imageTitle: CGFloat, titleSubtitle: CGFloat)
    public typealias HorizontalPads = (left: CGFloat, right: CGFloat)
    
    // defaults
    public var backgroundColor: UIColor = .clear
    public var imageContentMode: UIViewContentMode = .scaleAspectFit
    public var imageTintColor: UIColor?
    public var labelHortizontalPads = HorizontalPads(24, -24)
    public var neighborViewPads = NeighborViewPads(24.0, 6.0)
    public var scaleImageToSuperview: Bool = true
    
    // custom
    public var imageName: String?
    public var imageSize: CGSize?
    public var titleInfo: LabelInfo
    public var subtitleInfo: LabelInfo?
    
    public init(titleInfo: LabelInfo, subtitleInfo: LabelInfo? = nil, imageName: String? = nil, imageSize: CGSize? = nil) {
        self.titleInfo = titleInfo
        self.subtitleInfo = subtitleInfo
        self.imageName = imageName
        self.imageSize = imageSize
    }
    
    var isUseless: Bool {
        return imageName == nil && imageSize == nil && imageSize == nil && subtitleInfo == nil
    }
}

extension ImagePromptViewModel {
    public static var `default`: ImagePromptViewModel {
        return ImagePromptViewModel(titleInfo: ("", LabelStyle.tvcMainRegular))
    }
}
