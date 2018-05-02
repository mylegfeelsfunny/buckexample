//
//  UIImage+Stash.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 4/4/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import UIKit

public extension UIImage {
    public static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    public func with(cornerRadius: CGFloat, size: CGSize, borderColor: UIColor = .clear, borderWidth: CGFloat = 0) -> UIImage? {
        let imageView = UIImageView(frame: CGRect(origin: .zero, size: size))
        imageView.contentMode = .scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = cornerRadius
        imageView.layer.borderWidth = borderWidth
        imageView.layer.borderColor = borderColor.cgColor
        imageView.clipsToBounds = true
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }

}

public extension UIImage {
    
    public static func stashGradient(_ size: CGSize) -> UIImage {
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorComponents: [CGFloat] = [105.0, 54.0, 206.0, 255.0, 68.0, 209.0, 219.0, 255.0].map { $0/255.0 }
        let locations: [CGFloat] = [0.0, 1.0]
        let gradient = CGGradient(colorSpace: colorSpace, colorComponents: colorComponents, locations: locations, count: locations.count)!
        
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        
        let start = CGPoint(x: 0.0, y: 0.0)
        let end = CGPoint(x: size.width, y: size.height)
        
        context?.drawLinearGradient(gradient, start: start, end: end, options: [])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    public func tinted(with color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)
      
        let rect: CGRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        color.setFill()
        context.fill(rect)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
       
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIImage {
    
    public static let gradient = stashGradient(UIScreen.main.bounds.size)
}
