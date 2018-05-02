//
//  NavbarDecoratable.swift
//  StashInvest
//
//  Created by Scott Jones on 3/24/17.
//  Copyright © 2017 Collective Returns, INC. All rights reserved.
//

import UIKit

public protocol NavbarDecoratable: class {
    
    func clearNavbar()
    func setNavbar(title: String, color: UIColor)
    
}

extension UIViewController: NavbarDecoratable {
    
    public func showCancelLeftBarButtonItem() {
    }
    
    public func showSolidNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(r: 84, g: 73, b: 198)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    public func showGradientNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = nil
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(.gradient, for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    public func showClearNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    public func showEmptybackBarButtonItemTitle() {
        let backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    public func clearNavbar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage         = UIImage()
        navigationController?.navigationBar.barTintColor        = .clear
        navigationController?.navigationBar.isTranslucent       = true
    }

    public func navbar(color: UIColor) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        self.navigationController?.navigationBar.shadowImage    = UIImage()
        self.navigationController?.navigationBar.barTintColor   = color
        self.navigationController?.navigationBar.isTranslucent  = false
    }
    
    public func setNavbar(title: String, color: UIColor) {
        let font: UIFont                    = .regularLatoFont(ofSize: 18.0)
        let height                          = CGFloat(44.0)
        let width                           = title.widthWithConstrainedHeight(height, font: font)
        let titleLabel                      = UILabel(frame: CGRect(x: view.frame.size.width * 0.5 - (width * 0.5),
                                                                    y:0,
                                                                    width: width,
                                                                    height: height))
        titleLabel.font                     = font
        titleLabel.numberOfLines            = 0
        titleLabel.textAlignment            = .center
        titleLabel.textColor                = color
        titleLabel.text                     = title
        titleLabel.adjustsFontSizeToFitWidth = true
        self.navigationItem.titleView       = titleLabel
    }
    
    public func setPurpleNavbar(withTitle title: String) {
        setNavbar(title: title, color: .white)
        navbar(color: .navigationBar)
    }
    
    public func setWhiteNavbar(withTitle title: String) {
        setNavbar(title: title, color: .stashBlue)
        navbar(color: .white)
    }
    
    public func hideBackButton() {
        navigationItem.hidesBackButton      = true
        navigationItem.leftBarButtonItem    = nil
    }
    
    public func showBackButton() {
        navigationItem.hidesBackButton      = false
    }
    
    public var rightButtonIsEnabled: Bool {
        get {
            let button = navButton(items: self.navigationItem.rightBarButtonItems)
            return button?.isEnabled ?? false
        }
        set {
            disableFirstInItem(isEnabled: newValue, items: self.navigationItem.rightBarButtonItems)
        }
    }
    
    public var leftButtonIsEnabled: Bool {
        get {
            let button = navButton(items: self.navigationItem.leftBarButtonItems)
            return button?.isEnabled ?? false
        }
        set {
            disableFirstInItem(isEnabled: newValue, items: self.navigationItem.leftBarButtonItems)
        }
    }
    
    func leftButton(isEnabled: Bool) {
        disableFirstInItem(isEnabled: isEnabled, items: self.navigationItem.leftBarButtonItems)
    }
    
    func disableFirstInItem(isEnabled: Bool, items: [UIBarButtonItem]?) {
        let button                          = navButton(items: items)
        button?.isEnabled                   = isEnabled
    }
    
    func navButton(items: [UIBarButtonItem]?) -> UIButton? {
        guard let sitems = items?.dropFirst(), let barItem = sitems.first else { return nil }
        guard let button = barItem.customView as? UIButton else { return nil }
        return button
    }
    
    public func rightButton(title: String, color: UIColor, target: Any, action: Selector) {
        let button                          = navbutton(title: title, color: color)
        button.addTarget(target, action: action, for: .touchUpInside)
        right(buttons: [button])
    }
    
    public func leftButton(title: String, color: UIColor, target: Any, action: Selector) {
        showBackButton()
        let button                          = navbutton(title: title, color: color)
        button.addTarget(target, action: action, for: .touchUpInside)
        left(buttons: [button])
    }
    
    public func backButton(imageName: String, target: Any, action: Selector, margin: CGFloat = 0.0) {
        showBackButton()

        if let button = makeButton(withImageName: imageName, target: target, action: action) {
            left(buttons: [button], margin: margin)
        }
        
        // brings back the swipe back message
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    public func rightButton(imageName: String, selectedImageName: String? = nil, target: Any, action: Selector, margin: CGFloat = 0.0) {
        if let button = makeButton(withImageName: imageName, selectedImageName: selectedImageName, alignment: .right, target: target, action: action) {
            right(buttons: [button], margin: margin)
        }
    }
    
    public func leftButton(imageName: String, selectedImageName: String? = nil, target: Any, action: Selector, margin: CGFloat = 0.0) {
        if let button = makeButton(withImageName: imageName, selectedImageName: selectedImageName, alignment: .right, target: target, action: action) {
            left(buttons: [button], margin: margin)
        }
    }

    public func backButtonWhiteArrow(target: Any, action: Selector) {
        backButton(imageName: Icons.backArrowWhite.rawValue, target: target, action: action)
    }
    
    public func navbutton(title: String, color: UIColor) -> UIButton {
        let button                          = UIButton(type: .custom)
        button.titleLabel?.font             = .regularLatoFont(ofSize: 16.0)
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.setTitleColor(color.highlighted, for: .highlighted)
        button.setTitleColor(color.selected, for: .selected)
        button.setTitleColor(color.disabled, for: .disabled)
        let buttonSize                      = CGFloat(40).deviceScaled
        let width                           = title.widthWithConstrainedHeight(buttonSize, font: .regularLatoFont(ofSize: 16.0))
        button.frame                        = CGRect(x: 0, y: 0, width: Swift.max(width + CGFloat(16).deviceScaled, buttonSize), height: buttonSize)
        return button
    }
    
    public func left(buttons: [UIButton], margin: CGFloat = -4) {
        self.navigationItem.leftBarButtonItems = prep(buttons: buttons, margin: margin)
    }
    
    public func right(buttons: [UIButton], margin: CGFloat = -4) {
        self.navigationItem.rightBarButtonItems = prep(buttons: buttons, margin: margin)
    }
    
    func prep(buttons: [UIButton], margin: CGFloat) -> [UIBarButtonItem] {
        let marginItem                      = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        marginItem.width                    = margin
        let items = buttons.reduce([marginItem]) { its, nextButton in
            let bbi                         = UIBarButtonItem(customView: nextButton)
            return its + [bbi]
        }
        return items
    }

    public func rightBarButtonItem(withImageName imageName: String, selectedImageName: String? = nil, target: Any, action: Selector) -> UIBarButtonItem? {
        if let button = makeButton(withImageName: imageName, selectedImageName: selectedImageName, alignment: .right, target: target, action: action) {
            return UIBarButtonItem(customView: button)
        }

        return nil
    }

    private func makeButton(withImageName imageName: String, selectedImageName: String? = nil, alignment: UIControlContentHorizontalAlignment = .left, target: Any, action: Selector) -> UIButton? {
        guard let image = UIImage(named: imageName) else {
            return nil
        }

        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: Swift.max(40, image.size.width), height: Swift.max(40, image.size.height))
        button.setImage(image, for: .normal)
        if let selectedImageName = selectedImageName, let selectedImage = UIImage(named: selectedImageName) {
            button.setImage(selectedImage, for: .selected)
        }
        button.contentHorizontalAlignment = alignment
        button.addTarget(target, action: action, for: .touchUpInside)

        return button
    }
}

extension UINavigationController {
    
    public func clear() {
        navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationBar.shadowImage           = UIImage()
        navigationBar.barTintColor          = .clear
        navigationBar.isTranslucent         = true
    }
    
    public func set(color: UIColor) {
        navigationBar.setBackgroundImage(nil, for: .any, barMetrics: .default)
        navigationBar.shadowImage           = nil
        navigationBar.barTintColor          = color
        navigationBar.isTranslucent         = false
    }
    
    public func setPurple() {
        set(color: .stashPurple)
    }
    
    public func setWhite() {
        set(color: .white)
    }
    
    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    public func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    public func popToRootViewController(animated: Bool, completion: @escaping () -> Void) {
        popToRootViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }


}
