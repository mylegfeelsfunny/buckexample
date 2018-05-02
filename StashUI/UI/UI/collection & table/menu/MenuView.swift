//
//  MyStashNavigationMenu.swift
//  StashInvest
//
//  Created by Scott Jones on 10/9/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public protocol MenuLabelable {
    var menuLabel: MenuLabel { get }
}
extension Array where Element: UIViewController {
    public var menuLabels: [MenuLabel] {
        return map {
            guard let ml = $0 as? MenuLabelable else { return nil }
            return ml.menuLabel
        }.compactMap { $0 }
    }
}

public struct MenuLabel {
    public let name: String
    public let label: String
    public let identifier: String
    public var font: UIFont             = .title2
    public var textColor: UIColor       = .white
    public init(name: String, label: String, identifier: String) {
        self.name               = name
        self.label              = label
        self.identifier         = identifier
    }
    
    public init(name: String, label: String, identifier: String, textColor: UIColor, font: UIFont) {
        self.name               = name
        self.label              = label
        self.identifier         = identifier
        self.textColor          = textColor
        self.font               = font
    }
}

 
public protocol MenuViewDelegate: class {
    func menuView(_ menuView: MenuView, didSelectItemAt indexPath: IndexPath, cell: MenuCollectionCell)
}

// sticky view (highlight indicator)
public struct MenuStickyView {
    public static let color = UIColor.white
    public static let height: CGFloat = 2.0
    public static let rounded = true
    public static let animationDuration = 0.15
}

public class MenuView: NSObject {
    
    var collectionViewDataSource: CollectionViewDataSource?
    
    fileprivate var layout = MenuLayout()
    public weak var delegate: MenuViewDelegate?
    public weak var collectionView: UICollectionView?
    fileprivate let stickyView = UIView(frame: CGRect.zero)
    public var stickyViewColor: UIColor = MenuStickyView.color {
        didSet {
            stickyView.backgroundColor = stickyViewColor
        }
    }

    public init(collectionView: UICollectionView, titles menuLabels: [MenuLabel]) {
        self.collectionView     = collectionView
        super.init()
        
        layout.font             = menuLabels.first?.font ?? .body3
        layout.menuLabels       = menuLabels

        collectionView.register(UINib(nibName: MenuCollectionCell.reuseIdentifier, bundle: Bundle(for: MenuCollectionCell.self)), forCellWithReuseIdentifier: MenuCollectionCell.reuseIdentifier)
        collectionView.delegate = self

        let items = menuLabels.map { menuLabel -> Item in
            var item = Item(MenuCollectionCell.self)
            
            item.configure = { cell in
                (cell as? MenuCollectionCell)?.configure(for: menuLabel)
            }
            
            return item
        }
    
        collectionViewDataSource    = CollectionViewDataSource(collection: Collection(section: Section(items: items)))
        collectionView.dataSource   = collectionViewDataSource
        collectionView.setCollectionViewLayout(layout, animated: false)
    
        // set up sticky view
        stickyView.backgroundColor = stickyViewColor
        stickyView.clipsToBounds = true
        collectionView.superview?.addSubview(stickyView)
        
        if MenuStickyView.rounded {
            stickyView.layer.cornerRadius = 2.0
        }
        guard let viewToStickTo = collectionView.superview else { return }
        updateStickyViewContraints(to: viewToStickTo, animated: false)
    }
    
    func updateStickyViewContraints(to viewToStickTo: UIView, animated: Bool) {
        stickyView.snp.remakeConstraints { (make) in
            if let menuView = collectionView?.superview {
                // these two will get update frequently
                make.right.equalTo(viewToStickTo.snp.right)
                make.left.equalTo(viewToStickTo.snp.left)
                make.bottom.equalTo(menuView.snp.bottom).offset(1)
                make.height.equalTo(MenuStickyView.height + 1.0)
            }
        }
        
        UIView.animate(withDuration: animated ? MenuStickyView.animationDuration : 0.0) { [weak self] in
            self?.collectionView?.superview?.layoutIfNeeded()
        }
    }

    public var spacing: MenuSpacing {
        get {
            return layout.spacing
        }
        set {
            layout.spacing      = newValue
            layout.invalidateLayout()
        }
    }
    
    public func update(percent: CGFloat, animated: Bool) {
        let buffer              = abs(UIScreen.main.bounds.width - layout.collectionViewContentSize.width)
        layout.collectionView!.setContentOffset(CGPoint(x: buffer * percent, y:0), animated: animated)
        layout.collectionView!.contentInset = UIEdgeInsets.zero
    }
    
    public func selectItem(atIndexPath indexPath: IndexPath, animated: Bool) {
        if let paths = collectionView?.indexPathsForSelectedItems {
            for i in paths {
                collectionView?.deselectItem(at: i, animated: animated)
            }
        }
        if let cell = collectionView?.cellForItem(at: indexPath) as? MenuCollectionCell {
            updateStickyViewContraints(to: cell.textLabel, animated: true)
        }
        collectionView?.selectItem(at: indexPath, animated: animated, scrollPosition: [])
    }
    
    public func menuCollectionViewCell(at indexPath: IndexPath) -> MenuCollectionCell? {
        collectionView?.layoutIfNeeded()
        if let cell = collectionView?.cellForItem(at: indexPath) as? MenuCollectionCell {
            return cell
        }
        return nil
    }
}

extension MenuView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MenuCollectionCell {
            updateStickyViewContraints(to: cell.textLabel, animated: true)
            delegate?.menuView(self, didSelectItemAt: indexPath, cell: cell)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}
