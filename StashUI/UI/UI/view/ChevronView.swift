//
//  ChevronView.swift
//
//  Created by Dawid Skiba on 12/27/16.
//  Copyright © 2016 Stash Capital, INC. All rights reserved.
//

import UIKit

public enum ChevronType: Int {
    case forward = 0, backward, downward, upward
}

private let magicNum: CGFloat = 10
/*
 might be too magical to explain...but basically represent by how many units you want to split your view's bounds in vertically/horizontally
      magicNum = 3  [][][]            magicNum = 2  [][]
                    [][][]                          [][]
                    [][][]
 */

public struct ChevronViewModel {
    var strokeWidth: CGFloat = 2.0
    var strokeColor: UIColor = UIColor.black
    var type: ChevronType
}

public class ChevronView: UIView {
    public var strokeWidth: CGFloat = 2.0 {
        didSet { setNeedsDisplay() }
    }
    public var strokeColor: UIColor = UIColor.black {
        didSet { setNeedsDisplay() }
    }
    public var type: ChevronType {
        didSet { setNeedsDisplay() }
    }

    // MARK: Initialization
    public init(model: ChevronViewModel, frame: CGRect = .zero) {
        self.type = model.type
        self.strokeColor = model.strokeColor
        self.strokeWidth = model.strokeWidth
        
        super.init(frame: frame)
        setup()
    }
    
    public init(type: ChevronType, strokeColor: UIColor = UIColor.black, strokeWidth: CGFloat = 2.0, frame: CGRect = .zero) {
        self.type = type
        self.strokeColor = strokeColor
        self.strokeWidth = strokeWidth
    
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        self.type = .forward
        
        super.init(coder: aDecoder)!
        setup()
    }
    
    
    // MARK: Draw
    public override func draw(_ rect: CGRect) {
        let path: UIBezierPath!
        
        switch self.type {
        case .forward:
            path = bezierPathForward()
            
        case .backward:
            path = bezierPathBackward()
            
        case .downward:
            path = bezierPathDownward()
            
        case .upward:
            path = bezierPathUpward()
        }
            
        strokeColor.setStroke()
        path.lineWidth = strokeWidth
        path.stroke()
    }
}

private extension ChevronView {
    func setup() {
        backgroundColor = .clear
        clipsToBounds = true
    }
    
    func bezierPathForward() -> UIBezierPath {
        let width = bounds.size.width
        let height = bounds.size.height
        
        let minX = width*(1/magicNum)
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: minX, y: height*(1/magicNum)))
        path.addLine(to: CGPoint.init(x: width*((magicNum - 1)/magicNum), y: height*((magicNum/2.0)/magicNum)))
        path.addLine(to: CGPoint.init(x: minX, y: height*((magicNum - 1)/magicNum)))
        return path
    }
    
    func bezierPathBackward() -> UIBezierPath {
        let width = bounds.size.width
        let height = bounds.size.height
        
        let maxX = width*((magicNum - 1)/magicNum)
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: maxX, y: height*(1/magicNum)))
        path.addLine(to: CGPoint.init(x: width*(1/magicNum), y: height*((magicNum/2.0)/magicNum)))
        path.addLine(to: CGPoint.init(x: maxX, y: height*((magicNum - 1)/magicNum)))
        return path
    }
    
    func bezierPathDownward() -> UIBezierPath {
        let width = bounds.size.width
        let height = bounds.size.height
        
        let minY = height*(1/magicNum)
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: width*(1/magicNum), y: minY))
        path.addLine(to: CGPoint.init(x: width*((magicNum/2.0)/magicNum), y: height*((magicNum - 1)/magicNum)))
        path.addLine(to: CGPoint.init(x: width*((magicNum - 1)/magicNum), y: minY))
        return path
    }
    
    func bezierPathUpward() -> UIBezierPath {
        let width = bounds.size.width
        let height = bounds.size.height
        
        let maxY = height*((magicNum - 1)/magicNum)
        let path = UIBezierPath()
        path.move(to: CGPoint.init(x: width*(1/magicNum), y: maxY))
        path.addLine(to: CGPoint.init(x: width*((magicNum/2.0)/magicNum), y: height*(1/magicNum)))
        path.addLine(to: CGPoint.init(x: width*((magicNum - 1)/magicNum), y: maxY))
        return path
    }
}
