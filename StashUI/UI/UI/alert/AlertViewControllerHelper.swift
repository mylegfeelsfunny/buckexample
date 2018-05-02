//
//  AlertViewControllerHelper.swift
//  StashInvest
//
//  Created by Dawid Skiba on 7/13/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import Foundation
import UIKit

// ALERT VIEW
public extension UIViewController {
    
    static var kErrorTitle: String { return "Error" }
    static var kOkText: String { return "OK" }

    // MARK: One Button
    func showCustomAlert(title: String?, message: String?, actions: [UIAlertAction], completion:(() -> Void)? = nil) {
        if actions.isEmpty { return }
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertVC.addAction($0) }
        present(alertVC, animated: true, completion: completion)
    }
    
    func showSingleButtonAlert(title: String?, message: String?, buttonText: String = UIViewController.kOkText, completion:(() -> Void)? = nil) {
        let alertAction = UIAlertAction(title: buttonText, style: .default, handler: nil)
        showCustomAlert(title: title, message: message, actions: [alertAction], completion: completion)
    }
    
    func showSingleButtonAlert(title: String?, message: String?, action: UIAlertAction, completion:(() -> Void)? = nil) {
        showCustomAlert(title: title, message: message, actions: [action], completion: completion)
    }
    
    func onlyForDebugAlertBlock() {
        showSingleButtonAlert(title: "Stash Invest", message: "Feature not available at this time.")
    }
    
    // MARK: Error
    func showErrorAlert(message: String, action: UIAlertAction?) {
        showSingleButtonAlert(title: UIViewController.kErrorTitle, message: message, action:action ?? UIAlertAction.ok)
    }
    
    // MARK: Settings
    func showOpenSettingsAlert(title: String?, message: String?, action: UIAlertAction, application: ApplicationHandlerInterface, completion:(() -> Void)? = nil) {
        guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString), application.canOpenURL(settingsURL) else {
            showSingleButtonAlert(title: title, message: message, action: action, completion: completion)
            return
        }
        
        let settingAction = UIAlertAction(title: "Open App Setting", style: .default) { alert in
            application.open(settingsURL)
        }
        
        showTwoButtonAlert(title: title, message: message, firstAction: settingAction, secondAction: action, completion: completion)
    }
    
    // MARK: Two Button
    func showTwoButtonAlert(title: String?, message: String?, firstAction: UIAlertAction, secondAction: UIAlertAction, completion:(() -> Void)? = nil) {
        showCustomAlert(title: title, message: message, actions: [firstAction, secondAction], completion: completion)
    }
    
    // MARK: Three Button
    func showThreeButtonAlert(title: String?, message: String?, firstAction: UIAlertAction, secondAction: UIAlertAction, thirdAction: UIAlertAction, completion:(() -> Void)? = nil) {
        showCustomAlert(title: title, message: message, actions: [firstAction, secondAction, thirdAction], completion: completion)
    }
    
    // MARK: Alert Actions
    func dsAlertActionPopBack(animated: Bool = true) -> UIAlertAction {
        return UIAlertAction(title: UIViewController.kOkText, style: .default) { (action) in
            guard let navController = self.navigationController else {
                return
            }
            navController.popViewController(animated: animated)
        }
    }
}

// ACTION SHEET
public extension UIViewController {
    // MARK: One Button
    func showSingleButtonActionSheet(title: String?, message: String?, buttonText: String = UIViewController.kOkText, completion:(() -> Void)? = nil) {
        let actionVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: buttonText, style: .default, handler: nil)
        actionVC.addAction(alertAction)
        self.present(actionVC, animated: true, completion: completion)
    }
    
    func showSingleButtonActionSheet(title: String?, message: String?, action: UIAlertAction, completion:(() -> Void)? = nil) {
        let actionVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionVC.addAction(action)
        self.present(actionVC, animated: true, completion: completion)
    }
    
    // MARK: Action with Cancel
    func showActionSheetWithCancel(title: String?, message: String?, action: UIAlertAction, completion:(() -> Void)? = nil) {
        let actionVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actionVC.addAction(action)
        actionVC.addAction(UIAlertAction.cancel)
        
        self.present(actionVC, animated: true, completion: completion)
    }
    
    // MARK: Multi Button
    func showActionSheet(actions: [UIAlertAction], title: String? = nil, message: String? = nil, completion:(() -> Void)? = nil) {
        let actionVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in actions {
            actionVC.addAction(action)
        }
        self.present(actionVC, animated: true, completion: completion)
    }
}

public extension UIAlertAction {
    // MARK: Alert Action
    static var ok: UIAlertAction {
        return UIAlertAction(title: "OK", style: .default, handler: nil)
    }
    
    static var cancel: UIAlertAction {
        return UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    }
}
