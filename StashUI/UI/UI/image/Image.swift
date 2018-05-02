//
//  Image.swift
//  StashUI
//
//  Created by Morgan Collino on 2/22/18.
//  Copyright © 2018 Stash Capital, INC. All rights reserved.
//

import UIKit

public enum Image: String {
    // - - - - - - ALPAHBETIZED!
    case addPhoto = "add-photo-icon"
    case advisorIcon = "advisor-icon"
    case autoStash = "autostash-small-icon"
    case backArrowBlue = "arrow-back-blue"
    case backArrowWhite = "arrow-back-white"
    case bank = "bank-small-icon"
    case bookmark = "bookmark-icon-purple"
    case bookmarkWhite = "bookmark-icon"
    case bookmarkSelectedPurple = "bookmark-icon-purple-selected"
    case bookmarkSelectedWhite = "bookmark-icon-selected"
    case greenCheck = "green-check"
    case cashAllocation = "cash-allocation"
    case calendarAutostashFrequency = "calendar-autostash-frequency"
    case checkedCirclePurple = "checked_circle_purple"
    case checkSelectionWhite = "check-selection-white"
    case checkboxGray = "ira-checkbox"
    case checkboxHighlightedGreeen = "ira-checkbox-highlighted"
    case coach = "icon-coach"
    case dismissButtonWhite = "dismiss-x-button-white"
    case dismissButtonGray = "dismiss-x-button-gray"
    case forwardArrowBlue = "arrow-forward-blue"
    case forwardArrowWhite = "arrow-forward-white"
    case glossaryQuestionMarkWhite = "glossary-question-icon-white"
    case graph = "graph-small-icon"
    case supportBubble = "help-bubble"
    case keyboardKeypad = "keyboard-keypad"
    case keypadDeleteBlack = "keypad-delete-black"
    case keypadDeleteWhite = "keypad-delete-white"
    case penIcon = "pen-icon"
    case plusIcon = "plus-icon"
    case quickStart = "quickstart-small-icon"
    case redExclamation = "red_exclamation"
    case repeatArrowsWhite = "repeat-arrows-white"
    case retireChair = "retire-small-icon"
    case supportNeedHelp = "support-need-help-icon"
    case wavyDollar = "wavy-dollar"
    case welcomeWave = "welcome-wave"
    case faceId = "face-id-white"
    case touchId = "touch-id-white"
    case homeTab = "home-tab"
    case portfolioTab = "portfolio-tab"
    case investTab = "invest-tab"
    case learnTab = "learn-tab"
    case accountTab = "account-tab"
    case plus = "icon-plus"
    case twitter = "icon-twitter"
    case facebook = "icon-facebook"
    case share = "icon-share"
    case shareBox = "share-box"
    case message = "icon-message"
    case glossaryLarge = "glossary-large"
    case umbrella
    case directDepositIcon = "direct-deposit-icon"
    case alert
    case network = "network-icon"
    case achievementCustodianReg = "achievement_share_custodial"
    case autostashCalendar = "autoStashCalendar"
    case autoStashSpinner = "autoStashSpinner"
    case bankVisual = "bank-visual"
    case bookmarksEmpty = "bookmarks_empty"
    case brokenRobot = "broken-robot"
    case circularMoney = "icon-circular-money"
    case clearCheck = "icon-check-clear"
    case custodianEgg = "custodian-egg"
    case custodianNestEgg = "custodian-nest-egg"
    case feedInvestSummary = "feed-invest-summary"
    case feedRetireSummary = "feed-retire-summary"
    case feedCustodianSummary = "feed-custodian-summary"
    case homeStashRetire = "home-stash-retire-bg"
    case moneyLedger = "money-ledger"
    case moneyStacks = "icon-money-stacks"
    case moneyWallet = "money-wallet"
    case nextStepsLightning = "nextsteps-lightning"
    case noNetwork = "no-network"
    case preIdentityVerification = "icon-pre-identityverification"
    case postIdentityVerification = "icon-post-identityverification"
    case trophy = "trophy"
    case welcomeBalloon = "welcome-balloon"
    case referral = "referral-image"
    case noAcceptedReferral = "no-accepted-referral"
    case coachCategoryHeader = "coach-category-header"
    case coachIncomplete = "coach-incomplete"
    case coachIncompletePdf = "coach-incomplete-pdf"
    case coachComplete = "coach-complete"
    case coachCompleteWhite = "coach-complete-white"
    case coachLocked = "coach-lock"
    case greenCoachStar = "green-coach-star"
    case custodianAccountOpen = "custodian-account-open"
    case smartSaveTrophy = "smart-save-trophy"
    case ssnCard = "ssn-card"
    case debitCard = "debit-card"
    case spendWiseWallet
    case pendingHourGlass = "pending-hour-glass"
    case maintenanceMode = "maintenance-mode"
    case ladderLogo = "ladder-logo"
    case spendWiseConstructionMan
    case smartSaveJar
}

extension Image {
    public var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
    
    public var templateImage: UIImage? {
        return image?.withRenderingMode(.alwaysTemplate)
    }
}
