//
//  ImagePromptView.swift
//  StashUI
//
//  Created by Dawid Skiba on 10/25/17.
//  Copyright © 2017 Collective Returns, INC. All rights reserved.
//

import UIKit
import SnapKit

/*
       HOW ITS LAID OUT:
 
         [ImageView]
           [title]
          [subtitle]
 */

public class ImagePromptView: UIView {
    private let masterView = UIView()
    private let titleLabel = UILabel()
    private var imageView: UIImageView?
    private var subtitleLabel: UILabel?
    
    public init(model: ImagePromptViewModel) {
        super.init(frame: .zero)
        setup(with: model)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ImagePromptView {
    func setup(with model: ImagePromptViewModel) {
        if model.isUseless { return }
        
        backgroundColor = model.backgroundColor
        
        masterView.backgroundColor = .clear
        addSubview(masterView)
        masterView.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.greaterThanOrEqualTo(self.snp.top).offset(16).priority(400)
            make.bottom.greaterThanOrEqualTo(self.snp.bottom).offset(-16).priority(400)
        }
        
        // image shite
        if let imageName = model.imageName, let image = UIImage(named: imageName) {
            let imageView = UIImageView()
            
            imageView.contentMode = model.imageContentMode
            imageView.image = image
            if let tint = model.imageTintColor {
                imageView.image = image.withRenderingMode(.alwaysTemplate)
                imageView.tintColor = tint
            }
            masterView.addSubview(imageView)
            imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 500), for: .vertical)
            imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 800), for: .vertical)
            imageView.snp.makeConstraints { (make) in
                make.top.equalTo(self.masterView.snp.top).priority(900)
                make.centerX.equalTo(self.masterView.snp.centerX)
                if let imageSize = model.imageSize {
                    if model.scaleImageToSuperview {
                        // 375 is screen width on zeplin
                        make.width.equalTo(self.snp.width).multipliedBy(imageSize.width/375).priority(1000)
                        make.height.equalTo(imageView.snp.width).multipliedBy(imageSize.width/imageSize.height).priority(1000)
                    } else {
                        make.width.equalTo(imageSize.width).priority(1000)
                        make.height.equalTo(imageSize.height).priority(1000)
                    }
                } else {
                    make.left.greaterThanOrEqualTo(self.masterView.snp.left).offset(16)
                    make.right.greaterThanOrEqualTo(self.masterView.snp.right).offset(-16)
                }
            }
            self.imageView = imageView
        }
        
        // subtitle
        if let subtitleInfo = model.subtitleInfo {
            let subtitleLabel = UILabel()
            
            subtitleLabel.text = subtitleInfo.text
            subtitleLabel.stashalize(subtitleInfo.style)
            masterView.addSubview(subtitleLabel)
            subtitleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 900), for: .vertical)
            subtitleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 800), for: .vertical)
            subtitleLabel.snp.makeConstraints { (make) in
                make.bottom.equalTo(self.masterView.snp.bottom)
                make.left.equalTo(self.masterView.snp.left).offset(model.labelHortizontalPads.left)
                make.right.equalTo(self.masterView.snp.right).offset(model.labelHortizontalPads.right)
            }
            
            self.subtitleLabel = subtitleLabel
        }
        
        // title
        titleLabel.text = model.titleInfo.text
        titleLabel.stashalize(model.titleInfo.style)
        masterView.addSubview(titleLabel)
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        titleLabel.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 1000), for: .vertical)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.masterView.snp.left).offset(model.labelHortizontalPads.left)
            make.right.equalTo(self.masterView.snp.right).offset(model.labelHortizontalPads.right)
            
            // image view
            if let iv = self.imageView {
                make.top.equalTo(iv.snp.bottom).offset(model.neighborViewPads.imageTitle).priority(1000)
            } else {
                make.top.equalTo(self.masterView.snp.top)
            }
            
            // subtitle
            if let sl = self.subtitleLabel {
                make.bottom.equalTo(sl.snp.top).offset(-1.0 * fabs(model.neighborViewPads.titleSubtitle))
            } else {
                make.bottom.equalTo(self.masterView.snp.bottom)
            }
        }
    }
}

private let kThatSecretTag = 5293
extension UIViewController {
    public var containsImagePromptView: Bool {
        return ((view as? BackgroundViewHolding)?.backgroundView ?? view).containsImagePromptView
    }
    
    public func addImagePromptView(model: ImagePromptViewModel) {
        ((view as? BackgroundViewHolding)?.backgroundView ?? view)?.addImagePromptView(model: model)
    }
    
    public func removeImagePromptView() {
        ((view as? BackgroundViewHolding)?.backgroundView ?? view)?.removeImagePromptView()
    }
}

extension UIView {
    public var containsImagePromptView: Bool {
        if var backgroundViewHolding = self as? BackgroundViewHolding {
            if let backView = backgroundViewHolding.backgroundView {
                if let avocadoView = backView as? ImagePromptView {
                    return avocadoView.tag == kThatSecretTag
                }
                return backView.viewWithTag(kThatSecretTag) != nil
            }
        }
        
        if let _ = viewWithTag(kThatSecretTag) { return true }
        return false
    }
    
    public func addImagePromptView(model: ImagePromptViewModel) {
        guard !self.containsImagePromptView else { return }
        
        let imagePromptView = ImagePromptView(model: model)
        imagePromptView.tag = kThatSecretTag
        var viewToAddTo: UIView?
        
        if var backgroundViewHolding = self as? BackgroundViewHolding {
            if let backView = backgroundViewHolding.backgroundView {
                viewToAddTo = backView
            } else {
                backgroundViewHolding.backgroundView = imagePromptView
            }
        } else {
            viewToAddTo = self
        }
        
        guard let v = viewToAddTo else { return }
        v.addSubview(imagePromptView)
        imagePromptView.snp.makeConstraints({ (make) in
            make.edges.equalTo(v)
        })
    }
    
    public func removeImagePromptView() {
        guard containsImagePromptView else { return }
        
        if var backgroundViewHolding = self as? BackgroundViewHolding {
            if let backView = backgroundViewHolding.backgroundView {
                if let _ = backView as? ImagePromptView {
                    backgroundViewHolding.backgroundView = nil
                } else {
                    (backgroundViewHolding as? UIView)?.viewWithTag(kThatSecretTag)?.removeFromSuperview()
                }
                return
            }
        }
        
        viewWithTag(kThatSecretTag)?.removeFromSuperview()
    }
}
