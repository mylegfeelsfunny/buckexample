//
//  MessageSource.swift
//  BannerStack
//
//  Created by Scott Jones on 11/17/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import Foundation

protocol MessageSourceDelegate: class {
    func didAdd(at indexPath: IndexPath, messages: [SuccessResponse])
    func didRemove(at indexPath: IndexPath, messages: [SuccessResponse])
    func didEnd()
}

final class MessageSource {
    
    fileprivate var messages: [SuccessResponse]
    fileprivate var fifoQueue: FIFOQueue<SuccessResponse>

    public weak var delegate: MessageSourceDelegate?
    
    fileprivate var group = DispatchGroup()
    var timeAlive = 6.0
    var delay = 4.0
    
    init(messages: [SuccessResponse]) {
        self.messages = messages.reversed()
        fifoQueue = FIFOQueue<SuccessResponse>()
        messages.forEach { _ in group.enter() }

        group.notify(queue: DispatchQueue.main) { [weak self] in
            self?.delegate?.didEnd()
        }
    }
    
    func startMessages() {
        guard let message = messages.popLast() else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.enqueue(message: message)
        }
    }
    
    func stop() {
        group.notify(queue: DispatchQueue.main) {}
        fifoQueue.forEach { $0.removeSelfTimer?.invalidate() }
        delegate?.didEnd()
    }
    
    func loadMessage() {
        guard let message = messages.popLast() else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.enqueue(message: message)
        }
    }
    
    func removeMessage(_ message: SuccessResponse) {
        guard fifoQueue.contains(where: { $0.message == message.message }) else {
            return
        }
        dequeue()
    }
    
    func enqueue(message: SuccessResponse) {
        message.removeSelfTimer = Timer.schedule(delay: timeAlive) { [weak self] in
            self?.dequeue()
        }
        
        let indexPath = IndexPath(row: fifoQueue.count, section: 0)
        fifoQueue.enqueue(message)
        delegate?.didAdd(at: indexPath, messages: fifoQueue.allObjects)
        loadMessage()
    }
    
    func dequeue() {
        fifoQueue.dequeue()
        delegate?.didRemove(at: IndexPath(row:0, section:0), messages: fifoQueue.allObjects)
        group.leave()
    }
    
    func removeIndex(indexPath: IndexPath) {
        let message = fifoQueue[indexPath.row]
        message.removeSelfTimer?.invalidate()
        fifoQueue.removeIndex(index: indexPath.row)
        delegate?.didRemove(at: indexPath, messages: fifoQueue.allObjects)
        group.leave()
    }
}

extension Timer {
    
    public class func schedule(delay: TimeInterval, handler: @escaping () -> ()) -> Timer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, { _ in handler() })
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
    public class func schedule(repeatInterval interval: TimeInterval, handler: @escaping () -> ()) -> Timer {
        let fireDate = interval + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, interval, 0, 0, { _ in handler() })
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
}









