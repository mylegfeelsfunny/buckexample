//
//  BankPickerView.swift
//  BankPicker
//
//  Created by Scott Jones on 11/21/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public typealias SelectSource = (Int, String)->()

public enum PiePlace {
    case left 
    case right
    case center
}

public class SourcePickerView: UIView, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView:UITableView?
    @IBOutlet weak var pieView:PieSliceView?
    @IBOutlet weak var tableContainerView:UIView?
    @IBOutlet weak var tableHiderView:UIView?
    @IBOutlet weak var tableViewHeight:NSLayoutConstraint?
    @IBOutlet weak var tableViewWidth:NSLayoutConstraint?
    @IBOutlet weak var tableViewTop:NSLayoutConstraint?
    @IBOutlet weak var tableViewTopToContainer:NSLayoutConstraint?
    @IBOutlet public weak var topY:NSLayoutConstraint?
    
    public var topAnchorForInnerPickerView: NSLayoutYAxisAnchor? {
        return self.tableContainerView?.topAnchor
    }
    
    @IBOutlet weak var pieLeading:NSLayoutConstraint?
    @IBOutlet weak var pieTrailing:NSLayoutConstraint?
    @IBOutlet weak var pieCenter:NSLayoutConstraint?

    var tapGesture:UITapGestureRecognizer!
    public var selectedSource:SelectSource?
    public var piePlacement: PiePlace = .center {
        didSet {
            clearPie()
            switch piePlacement {
            case .center:
                pieCenter?.priority = UILayoutPriority(rawValue: 1000)
            case .left:
                pieLeading?.priority = UILayoutPriority(rawValue: 1000)
            case .right:
                pieTrailing?.priority = UILayoutPriority(rawValue: 1000)
            }
        }
    }
    
    func clearPie() {
        pieLeading?.priority = UILayoutPriority(rawValue: 750)
        pieTrailing?.priority = UILayoutPriority(rawValue: 750)
        pieCenter?.priority = UILayoutPriority(rawValue: 750)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var sources: [String]                        = []
    
    var openHieght: CGFloat {
        return (CGFloat(sources.count) * SourceTableViewCell.Height) + (UIScreen.main.bounds.height * 0.01)
    }
    
    var openWidth: CGFloat {
        return UIScreen.main.bounds.width * 0.8
    }
    
    var closedHieght: CGFloat {
        return 0
    }
    var closedWidth: CGFloat {
        return 0
    }
    
    public func indexForSource(source: String) -> Int? {
        return sources.index { $0 == source }
    }
    
    deinit {}
    
    public func didLoad() {
        let height                              = UIScreen.main.bounds.height
        tableViewTop?.constant                  = height * 0.028
        
        tableContainerView?.backgroundColor     = .clear
        tableContainerView?.clipsToBounds       = true
        tableContainerView?.layer.cornerRadius  = 4
        
        tableHiderView?.clipsToBounds           = true
        tableHiderView?.layer.cornerRadius      = 4

        tableViewTopToContainer?.constant       = height * 0.0105

        tableView?.layer.cornerRadius           = 4
        tableView?.separatorStyle               = .none
        tableView?.separatorInset               = UIEdgeInsets.zero
        tableView?.isScrollEnabled              = false
        tableView?.separatorColor               = UIColor.stashBlue(alpha: 0.2)
        tableView?.register(UINib(nibName: SourceTableViewCell.Identifier, bundle: Bundle(for: SourceTableViewCell.self)), forCellReuseIdentifier: SourceTableViewCell.Identifier)

        tapGesture                              = UITapGestureRecognizer(target: self, action: #selector(didTapOutSide))
        tapGesture.delegate                     = self
        
        isOpaque = false
        backgroundColor                         = UIColor.black.withAlphaComponent(0.4)
        isHidden                                = true
        alpha                                   = 0
    }
    
    @objc func didTapOutSide(sender:UIGestureRecognizer) {
        animateOut()
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view!.isKind(of: SourcePickerView.self)
    }

    public func populate(sources:[String]) {
        self.sources                            = sources
        tableView?.delegate                     = self
        tableView?.dataSource                   = self
    }
    
    public func animateIn(selectedIndex: Int) {
        self.animateIn(withSelected: IndexPath(row: selectedIndex, section: 0))
    }
    
    public func animateIn(withSelected indexPath: IndexPath) {
        addGestureRecognizer(tapGesture)
        isHidden                                = false
        tableContainerView?.isHidden            = false
        tableContainerView?.alpha               = 0

        self.tableViewHeight?.constant          = 0
        self.tableViewWidth?.constant           = 0
        self.layoutIfNeeded()

        CATransaction.flush()
        
        self.tableView?.selectRow(at: indexPath, animated: false, scrollPosition: .none)

        tableContainerView?.alpha               = 1
        tableHiderView?.alpha                   = 1
        alpha                                   = 1

        backgroundColor                         = .clear
        UIView.animate(withDuration: 0.6, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.9, options: [.curveEaseOut], animations: { [weak self] in
                self?.backgroundColor           = UIColor.black.withAlphaComponent(0.4)
                self?.tableHiderView?.alpha     = 0
                self?.tableView?.alpha          = 1

                self?.pieView?.alpha            = 1
                self?.tableViewWidth?.constant  = self!.openWidth
                self?.tableViewHeight?.constant = self!.openHieght
                self?.layoutIfNeeded()

            }, completion: nil)
    }
    
    func animateOut() {
        removeGestureRecognizer(tapGesture)

        tableViewWidth?.constant = 0
        tableViewHeight?.constant = 0
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.9, options: [.curveEaseOut], animations: {
            self.tableHiderView?.alpha = 1
            self.alpha = 0.0
            self.backgroundColor   = .clear
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
}

extension SourcePickerView : UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let selObject = sources[index]
        DispatchQueue.main.async { [weak self] in
            self?.selectedSource?(index, selObject)
        }
        
        animateOut()
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SourceTableViewCell.Height
    }
}

extension SourcePickerView : UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sources.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SourceTableViewCell.Identifier, for: indexPath) as? SourceTableViewCell else { fatalError("No cell with identifier SourceTableViewCell") }
        cell.configure(object: sources[indexPath.row])
        cell.separator?.isHidden = !(indexPath.row > 0)
        return cell
    }
    
}
