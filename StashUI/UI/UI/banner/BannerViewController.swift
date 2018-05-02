//
//  BannerViewController.swift
//  BannerStack
//
//  Created by Scott Jones on 11/16/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit
import Dwifft

public enum BannerTimeAlive: TimeInterval {
    case normal = 6
    case extended = 8
}

public enum BannerDelay: TimeInterval {
    case none = 0
    case normal = 3
}

class BannerViewController: UIViewController, UIGestureRecognizerDelegate {

    public var theView: BannerView {
        guard let v = view as? BannerView else { fatalError("\(view) is not a BannerView") }
        return v
    }
    
    var messageSource: MessageSource?
    private let messagesQueue = DispatchQueue(label: "com.stash.concurrent.messages.queue", qos: .userInitiated, attributes: .concurrent)
    private var _activeMessages: [SuccessResponse] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let sself = self else { return }
                let forceUpdateHeight = (sself._activeMessages.count - oldValue.count) > 0
                sself.didUpdate(with: sself._activeMessages, forceUpdateHeight: forceUpdateHeight)
            }
        }
    }
    public var activeMessages: [SuccessResponse] {
        get {
            var result: [SuccessResponse] = []
            messagesQueue.sync {
                result = self._activeMessages
            }
            return result
        }
        set {
            messagesQueue.async(flags: .barrier) {
                self._activeMessages = newValue
            }
        }
    }
    
    lazy var swipeGesture: UISwipeGestureRecognizer = {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeUp))
        swipeGesture.direction = .up
        swipeGesture.delegate = self
        return swipeGesture
    }()
    
    lazy private var diffCalculator: TableViewDiffCalculator<Int, SuccessResponse> = {
        let diffCalculator = TableViewDiffCalculator<Int, SuccessResponse>(tableView: theView.tableView, initialSectionedValues: SectionedValues<Int, SuccessResponse>([(0, self.activeMessages)]))
        diffCalculator.insertionAnimation = .top
        diffCalculator.deletionAnimation = .top
        return diffCalculator
    }()

    init(messages: [SuccessResponse], delay: BannerDelay = .normal, timeAlive: BannerTimeAlive = .normal) {
        messageSource = MessageSource(messages: messages)
        messageSource?.delay = delay.rawValue
        messageSource?.timeAlive = timeAlive.rawValue
        super.init(nibName: "BannerViewController", bundle: Bundle(for: BannerViewController.self))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theView.didLoad()
        theView.tableView.addGestureRecognizer(swipeGesture)
        theView.tableView.register(UINib(nibName: BannerTableViewCell.Identifier, bundle: Bundle(for: BannerTableViewCell.self)), forCellReuseIdentifier: BannerTableViewCell.Identifier)
        
        theView.tableView.dataSource = self
        theView.tableView.delegate = self
        
        messageSource?.delegate = self
        messageSource?.startMessages()
    }
    
    func updateHeight(to height: CGFloat) {
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height + BannerView.Constants.topOffset)
        theView.updateHeight(height)
    }
    
    func didUpdate(with messages: [SuccessResponse], forceUpdateHeight: Bool = false) {
        if forceUpdateHeight {
            updateHeight(to: messages.totalHeight())
        }
        
        CATransaction.begin()
        CATransaction.setCompletionBlock { [weak self] in
            guard let sself = self else { return }
            sself.updateHeight(to: messages.totalHeight())
        }
        diffCalculator.sectionedValues = SectionedValues([(0, messages)])
        
        CATransaction.commit()
    }
    
    @objc func forceRemove(closure: @escaping () -> ()) {
        messageSource?.stop()
        var frame = view.frame
        frame = CGRect(origin: CGPoint(x: frame.origin.x, y: frame.origin.y - frame.size.height), size: frame.size)
        UIView.animate(withDuration: 0.4, animations: { [weak self] in
            self?.view.frame = frame
        }, completion: {  [weak self] _ in
            self?.view.isHidden = true
            closure()
        })
    }
    
    func didHearSwipe(notification: Notification) {
        guard let sender = notification.object as? UITableViewCell,
              let indexPath = theView.tableView.indexPath(for: sender) else {
            return
        }
        messageSource?.removeIndex(indexPath: indexPath)
    }
    
    @objc func didSwipeUp(sender: UIGestureRecognizer) {
        guard sender.state == .ended else { return }
        let swipeLocation = sender.location(in: theView.tableView)
        guard let indexPath = theView.tableView.indexPathForRow(at: swipeLocation) else { return }
        messageSource?.removeIndex(indexPath: indexPath)
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return true
    }
}

extension BannerViewController : MessageSourceDelegate {
    
    func didAdd(at indexPath: IndexPath, messages: [SuccessResponse]) {
        activeMessages = messages
    }

    func didRemove(at indexPath: IndexPath, messages: [SuccessResponse]) {
        guard activeMessages[safe: indexPath.row] != nil else { didEnd(); return }
        activeMessages = messages
    }
    
    func didEnd() {
        removeBanners()
    }
}

extension BannerViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diffCalculator.numberOfObjects(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.Identifier, for: indexPath) as! BannerTableViewCell
        cell.configureCell(response: activeMessages[indexPath.row])
        return cell
    }
}

extension BannerViewController : UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messageSource?.removeIndex(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = activeMessages[safe: indexPath.row]?.height() else { return CGFloat.leastNonzeroMagnitude }
        return height
    }
}

private var BannerViewControllerKey             = "BannerViewControllerKey"
private var BannerViewControllerViewTag         = 43

extension UIViewController {
    
    private var bannerViewController: BannerViewController? {
        get {
            return objc_getAssociatedObject(self, &BannerViewControllerKey) as? BannerViewController
        }
        set {
            objc_setAssociatedObject(self, &BannerViewControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    public func addBanners(messages: [SuccessResponse], withDelay delay: BannerDelay = .normal, timeAlive: BannerTimeAlive = .normal) {
        let bannerView = view.viewWithTag(BannerViewControllerViewTag)
        bannerView?.removeFromSuperview()
        self.bannerViewController = nil
        guard !messages.isEmpty else { return }
        
        let bannerViewController = BannerViewController(messages: messages, delay: delay, timeAlive: timeAlive)
        bannerViewController.view.tag = BannerViewControllerViewTag
        view.addSubview(bannerViewController.view)
        self.bannerViewController = bannerViewController
    }
    
    public func removeBanners() {
        bannerViewController?.forceRemove { [weak self] in
            self?.view.viewWithTag(BannerViewControllerViewTag)?.removeFromSuperview()
            self?.bannerViewController = nil
        }
    }
}
