//
//  LabelStyle+STI.swift
//  StashUI
//
//  Created by Dawid Skiba on 2/8/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import Foundation

extension LabelStyle {
    /*
     COPY THIS ONE AND ADD A STYLE TO THIS EXTENSION, make the name serious and boring... 🥑

     static var <#nonFunnyStashStyleName#>: LabelStyle {
        return LabelStyle(.subtitle3, .stashGray())
     }
     */

    public static var investCardTitle: LabelStyle {
        return LabelStyle(.subtitle2, .stashSoftBlack, 1, .left)
    }

    public static var investCardSubtitle: LabelStyle {
        return LabelStyle(.body3, .stashGray(130), 4, .left)
    }

    public static var tvcMainBold: LabelStyle {
        return LabelStyle(.subtitle1, .black, 1, .left)
    }

    public static var tvcMainRegular: LabelStyle {
        return LabelStyle(.body3, .stashGray(130), 1, .left)
    }

    public static var editProfileRegular: LabelStyle {
        return LabelStyle(.regularSFFont(ofSize: 15.0), .stashGray(130), 2, .left)
    }

    public static var registrationFlowPromptTitle: LabelStyle {
        return LabelStyle(.title1, .stashGray(39), 0, .left)
    }

    public static var registrationFlowPromptSubTitle: LabelStyle {
        return LabelStyle(.body3, .stashGray(130), 0, .left)
    }

    public static var registrationFlowAnswerTitle: LabelStyle {
        return LabelStyle(.subtitle1, .stashGray(39), 0, .center)
    }

    public static var registrationFlowAnswer: LabelStyle {
        return LabelStyle(.subtitle3, .stashGray(39), 0, .center)
    }

    public static var termsOfUseAndPrivacyPolicy: LabelStyle {
        return LabelStyle(.subtitle3, .stashGray(130), 0, .center)
    }
}
