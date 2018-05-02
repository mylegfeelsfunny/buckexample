//
//  HeadDockedScrollView.swift
//  StashInvest
//
//  Created by Scott Jones on 10/21/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public protocol HeadScrollable: class {
    var headerHeight: CGFloat { get set }
    func set(minY: CGFloat, maxY: CGFloat)
    func adjust()
}

public typealias Updater = (_ y: CGFloat) -> Void
public protocol HeadDockable: class {
    var scrollView: HeadScrollable? { get }
    var updater: Updater? { get set }
}

public class HeaderScrollView: UIScrollView, HeadScrollable {

    public weak var bottomView: UIView?
    public var footerView: UIView?
    private var _minimumY: CGFloat   = 0
    private var _maximumY: CGFloat   = 0
    private var _cOffsetY: CGFloat   = 0
    private var _sOffsetY: CGFloat   = 0

    public var headerHeight: CGFloat {
        get { return _cOffsetY }
        set {
            _sOffsetY               = newValue
            adjust()
        }
    }

    var minimumY: CGFloat {
        get { return _minimumY }
        set {
            _minimumY               = newValue
            adjust()
        }
    }
    var maximumY: CGFloat {
        get { return _maximumY }
        set {
            _maximumY               = newValue
            adjust()
        }
    }
    
    public func set(minY: CGFloat, maxY: CGFloat) {
        _minimumY                   = minY
        _maximumY                   = maxY
        _cOffsetY                   = maxY
        
        adjust()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if self.contentOffset.y < 0 {
            _cOffsetY               = _maximumY + fabs(self.contentOffset.y)
        } else {
            _cOffsetY               = _maximumY - self.contentOffset.y
            _cOffsetY               = (_cOffsetY < _minimumY) ? _minimumY : _cOffsetY
        }
        var scrollInsets            = self.scrollIndicatorInsets
        scrollInsets.top            = _cOffsetY
        self.scrollIndicatorInsets  = scrollInsets
    }
    
    override public var contentSize: CGSize {
        get {
            return super.contentSize
        }
        set {
            super.contentSize       = CGSize(width: newValue.width, height: newValue.height + _maximumY)
        }
    }
    
    public func adjust() {
        bottomView?.frame           = CGRect(x:0, y:_maximumY, width: bottomView!.frame.size.width, height: bottomView!.frame.size.height)
        contentSize                 = CGSize(width: bottomView!.frame.size.width, height: bottomView!.frame.size.height)
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.adjustFooter()
            strongSelf.adjustHeader()
            strongSelf.delegate?.scrollViewDidScroll?(strongSelf)
        }
    }
    
    private func adjustFooter() {
        footerView?.removeFromSuperview()
        let total                   = contentSize.height
        if total < frame.height {
            contentSize             = CGSize(width: bottomView!.frame.size.width, height: bottomView!.frame.maxY + 0.5)
        }
        layoutSubviews()
    }
    
    private func adjustHeader() {
        if _sOffsetY == contentOffset.y {
            return
        }
        
        if Int(_sOffsetY) == Int(_minimumY) && contentOffset.y >= (_maximumY - _minimumY) {
            return
        }
        
        let rat: CGFloat             = 1 - (_sOffsetY / _maximumY)
        contentOffset               = CGPoint(x: contentOffset.x, y:_maximumY * rat)
        layoutSubviews()
    }
    
}

public class HeaderTableView: UITableView, HeadScrollable {
    
    private var _minimumY: CGFloat   = 0
    private var _maximumY: CGFloat   = 0
    private var _cOffsetY: CGFloat   = 0
    private var _sOffsetY: CGFloat   = 0

    public var headerHeight: CGFloat {
        get { return _cOffsetY }
        set {
            _sOffsetY               = newValue
            adjust()
        }
    }
    
    var minimumY: CGFloat {
        get { return _minimumY }
        set {
            _minimumY               = newValue
            layoutSubviews()
        }
    }
    var maximumY: CGFloat {
        get { return _maximumY }
        set {
            _maximumY               = newValue
            layoutSubviews()
        }
    }
    
    public func set(minY: CGFloat, maxY: CGFloat) {
        _minimumY                   = minY
        _maximumY                   = maxY
        _cOffsetY                   = maxY
        
        tableHeaderView             = nil
        let view                    = UIView()
        view.backgroundColor        = .clear
        view.frame                  = CGRect(x:0, y:0, width: frame.width, height: _cOffsetY)
        self.tableHeaderView        = view
        layoutSubviews()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if self.contentOffset.y < 0 {
            _cOffsetY               = _maximumY + fabs(self.contentOffset.y)
        } else {
            _cOffsetY               = _maximumY - self.contentOffset.y
            _cOffsetY               = (_cOffsetY < _minimumY) ? _minimumY : _cOffsetY
        }
//        tableHeaderView?.frame      = CGRect(x: 0, y: self.contentOffset.y, width: self.tableHeaderView!.frame.width, height: _cOffsetY)
//
        var scrollInsets            = self.scrollIndicatorInsets
        scrollInsets.top            = _cOffsetY
        self.scrollIndicatorInsets  = scrollInsets
    }
  
    override public func reloadData() {
        super.reloadData()
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.adjustFooter()
            strongSelf.delegate?.scrollViewDidScroll?(strongSelf)
        }
    }
    
    public func adjust() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.adjustFooter()
            strongSelf.adjustHeader()
            strongSelf.delegate?.scrollViewDidScroll?(strongSelf)
        }
    }
    
    private func adjustFooter() {
        tableFooterView             = nil
        layoutSubviews()

        let total                   = contentSize.height
        if total < bounds.height {
            
            if tableHeaderView != nil {
                addFooterView(height: bounds.height - (floor(contentSize.height - tableHeaderView!.frame.height) + _minimumY))
            }
        }
        layoutSubviews()
    }
   
    private func addFooterView(height: CGFloat) {
        let view                    = UIView()
        view.frame                  = CGRect(x:0, y:0, width: bounds.width, height: height)
        view.backgroundColor        = .clear
        self.tableFooterView        = view
    }
    
    private func adjustHeader() {
        if _sOffsetY == contentOffset.y {
            return
        }
        
        if Int(_sOffsetY) == Int(_minimumY) && contentOffset.y >= (_maximumY - _minimumY) {
            return
        }
        
        let rat: CGFloat             = 1 - (_sOffsetY / _maximumY)
        contentOffset               = CGPoint(x: contentOffset.x, y:_maximumY * rat)
        layoutSubviews()
    }
    
}

public class HeaderTableViewDelegate: TableViewDelegate {
    
    override public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let hd = scrollView as! HeaderTableView // swiftlint:disable:this force_cast
        updater?(hd.headerHeight)

        super.scrollViewDidScroll(scrollView)
    }
    
    public var updater: Updater?
    
}
