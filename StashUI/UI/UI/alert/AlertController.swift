//
//  AlertController.swift
//  stash-invest-ios
//
//  Created by Mikael Konutgan on 1/4/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit



public class AlertController: UIViewController {
    
    let alertTitle: String?
    let alertMessage: String?
    let alertActions: [AlertAction]
    
    let bundle: Bundle
    
    fileprivate let alertViewModel: AlertViewModel
    
    private let alertControllerTransitioningDelegate: UIViewControllerTransitioningDelegate = AlertControllerTransitioningDelegate()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    public init(title: String?, message: String?, actions: [AlertAction]) {
        alertTitle = title
        alertMessage = message
        alertActions = actions
        
        alertViewModel = AlertViewModel(title: alertTitle, message: alertMessage, actions: alertActions)
        
        self.bundle = Bundle(for: AlertController.self)
        super.init(nibName: "AlertController", bundle: self.bundle)
        
        
        modalPresentationStyle = .custom
        transitioningDelegate = alertControllerTransitioningDelegate
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor.clear.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        collectionView.layer.cornerRadius = 4.0
        collectionView.layer.masksToBounds = true
        
        collectionView.delaysContentTouches = false
        
        collectionView.register(UINib(nibName: "AlertHeaderView", bundle: self.bundle),
                                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                withReuseIdentifier: "AlertHeader")
        
        collectionView.register(UINib(nibName: "DefaultAlertActionCollectionViewCell", bundle: self.bundle),
                                forCellWithReuseIdentifier: "DefaultAlertAction")
        
        collectionView.register(UINib(nibName: "CancelAlertActionCollectionViewCell", bundle: self.bundle),
                                forCellWithReuseIdentifier: "CancelAlertAction")
        
        collectionView.register(UINib(nibName: "SpaceCollectionViewCell", bundle: self.bundle),
                                forCellWithReuseIdentifier: "Space")
    }
}

extension AlertController {
    @objc func didSelectAction(sender: UIButton) {
        let point = collectionView.convert(sender.center, from: sender.superview)
        if let indexPath = collectionView.indexPathForItem(at: point) {
            let alertAction = alertActions[indexPath.row]
            alertAction.handler(alertAction)
            dismiss(animated: true, completion: nil)
        }
    }
}

extension AlertController: AlertPresentable {
    public func contentHeight(maxWidth: CGFloat) -> CGFloat {
        var height: CGFloat = 0.0
        
        for section in 0..<numberOfSections(in: collectionView) {
            height += collectionView(collectionView, layout: collectionView.collectionViewLayout, referenceSizeForHeaderInSection: section).height
            
            for item in 0..<collectionView(collectionView, numberOfItemsInSection: section) {
                height += collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: IndexPath(item: item, section: section)).height
            }
        }
        
        return height
    }
}

extension AlertController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return alertActions.count + (alertViewModel.needsSpace ? 1 : 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if alertViewModel.needsSpace && indexPath.row == alertActions.count {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "Space", for: indexPath)
        }
        
        let action = alertActions[indexPath.row]
        switch action.style {
        case .default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultAlertAction", for: indexPath) as! DefaultAlertActionCollectionViewCell
            (cell.button as! Button).color = UIColor(red: 246.0 / 255.0, green: 166.0 / 255.0, blue: 35.0 / 255.0, alpha: 1.0)
            cell.button.setTitle(action.title, for: .normal)
            cell.button.addTarget(self, action: #selector(didSelectAction), for: .touchUpInside)
            return cell
        case .cancel:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CancelAlertAction", for: indexPath) as! CancelAlertActionCollectionViewCell
            cell.button.setTitle(action.title, for: .normal)
            cell.button.addTarget(self, action: #selector(didSelectAction), for: .touchUpInside)
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "AlertHeader", for: indexPath) as! AlertHeaderView
        
        view.titleLabel.attributedText = alertViewModel.attributedTitle
        view.messageLabel.attributedText = alertViewModel.attributedMessage
        
        view.titleLabel.font = alertViewModel.titleFont
        view.messageLabel.font = alertViewModel.messageFont
        
        view.titleViewHeightConstraint.constant = alertViewModel.headerTitleViewHeight()
        view.messageViewHeightConstraint.constant = alertViewModel.headerMessageViewHeight()
        
        return view
    }
}

extension AlertController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if alertViewModel.needsSpace && indexPath.row == alertActions.count {
            return CGSize(width: collectionView.bounds.size.width, height: 16.0)
        }
        
        return alertViewModel.actionSize()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return alertViewModel.headerSize()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return .zero
    }
}
