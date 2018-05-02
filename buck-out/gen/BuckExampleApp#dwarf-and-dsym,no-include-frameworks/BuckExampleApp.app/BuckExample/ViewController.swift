//
//  ViewController.swift
//  BuckExample
//
//  Created by Scott Jones on 4/16/18.
//  Copyright © 2018 Stash Invest. All rights reserved.
//

import UIKit
import StashUI

private let kOffsetVertical: CGFloat = 16.0
private let kOffsetHorizontal: CGFloat = 16.0
private let kButtonHeight: CGFloat = 48
private typealias ButtonAndType = (button: Button, style: ButtonStyle)

private var kRandomButtonStyle: ButtonModel {
    return ButtonModel(font: .italicSFFont(ofSize: 14), textColor: .white, backgroundColor: .stashTeel, edgeType: .custom(radius: 14))
}

extension ButtonStyle {

    public static var allTypes: [ButtonStyle] {
        return [primary, secondary, dismiss, defaultShare, share(.white, .stashPurple), remove, underlined(.gray), .custom(kRandomButtonStyle), hollow(.stashPurple), clear(.gray)]
    }

}

class ViewController: UIViewController {
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private var buttonsInfo = [ButtonAndType]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.buttonsInfo.forEach {
                $0.button.alpha = 0.0
                $0.button.style = $0.style
                $0.button.setTitle($0.style.description, for: .normal)
                if case .underlined(_) = $0.style {
                    $0.button.style = .underlined(.stashGray())
                }
            }

            UIView.animate(withDuration: 0.2, animations: {
                self?.buttonsInfo.forEach { $0.button.alpha = 1.0 }
            })
        }
    }
    
}

private extension ViewController {
    func setup() {
        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        scrollView.delaysContentTouches = false
        contentView.isUserInteractionEnabled = true
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.height.lessThanOrEqualTo(scrollView).priority(900)
            make.width.equalTo(view.bounds.width)
        }
        
        for i in 0..<ButtonStyle.allTypes.count {
            let style = ButtonStyle.allTypes[i]
            let button = Button(type: .custom)
            button.style = style
            button.alpha = 0.0
            
            contentView.addSubview(button)
            button.snp.makeConstraints({ (make) in
                make.height.equalTo(kButtonHeight)
                make.left.equalTo(contentView.snp.left).offset(kOffsetHorizontal)
                make.right.equalTo(contentView.snp.right).offset(-kOffsetHorizontal)
                
                if let previousButton = buttonsInfo.last?.button {
                    make.top.equalTo(previousButton.snp.bottom).offset(kOffsetVertical)
                }
                else {
                    make.top.equalTo(contentView.snp.top).offset(kOffsetVertical)
                }
                
                // last one
                if i == ButtonStyle.allTypes.count - 1 {
                    make.bottom.equalTo(contentView.snp.bottom).offset(-kOffsetVertical)
                }
            })
            buttonsInfo.append((button, style))
        }
    }
    
}
