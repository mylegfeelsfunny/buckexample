//
//  AttributesTests.swift
//  StashInvest
//
//  Created by Mikael Konutgan on 3/31/17.
//  Copyright © 2017 Stash Capital, INC. All rights reserved.
//

import XCTest
@testable import StashUI
import UIKit

class AttributesTests: XCTestCase {
    
    func testFont() {
        let attributes = Attributes().withFont(.systemFont(ofSize: 16.0))
        XCTAssertEqual(attributes.attributes[NSAttributedStringKey.font] as! UIFont, .systemFont(ofSize: 16.0))
    }
    
    func testForegroundColor() {
        let attributes = Attributes().withForegroundColor(.white)
        XCTAssertEqual(attributes.attributes[NSAttributedStringKey.foregroundColor] as! UIColor, .white)
    }
    
    func testLineSpacing() {
        let attributes = Attributes().withLineSpacing(2.0)
        XCTAssertEqual((attributes.attributes[NSAttributedStringKey.paragraphStyle] as! NSParagraphStyle).lineSpacing, 2.0)
    }
    
    func testAlignment() {
        let attributes = Attributes().withAlignment(.center)
        XCTAssertEqual((attributes.attributes[NSAttributedStringKey.paragraphStyle] as! NSParagraphStyle).alignment, .center)
    }
    
    func testLineSpacingAndAlignment() {
        let attributes = Attributes().withAlignment(.center).withLineSpacing(4.0)
        XCTAssertEqual((attributes.attributes[NSAttributedStringKey.paragraphStyle] as! NSParagraphStyle).alignment, .center)
        XCTAssertEqual((attributes.attributes[NSAttributedStringKey.paragraphStyle] as! NSParagraphStyle).lineSpacing, 4.0)
    }
    
    func testForegroundColorAndFont() {
        let attributes = Attributes().withForegroundColor(.white).withFont(.boldSystemFont(ofSize: 14.0))
        XCTAssertEqual(attributes.attributes[NSAttributedStringKey.foregroundColor] as! UIColor, .white)
        XCTAssertEqual(attributes.attributes[NSAttributedStringKey.font] as! UIFont, .boldSystemFont(ofSize: 14.0))
    }
    
    func testALLTHETHINGS() {
        let attributes = Attributes()
            .withAlignment(.left)
            .withLineSpacing(8.0)
            .withForegroundColor(.lightGray)
            .withFont(.italicSystemFont(ofSize: 18.0))
        
        XCTAssertEqual((attributes.attributes[NSAttributedStringKey.paragraphStyle] as! NSParagraphStyle).alignment, .left)
        XCTAssertEqual((attributes.attributes[NSAttributedStringKey.paragraphStyle] as! NSParagraphStyle).lineSpacing, 8.0)
        XCTAssertEqual(attributes.attributes[NSAttributedStringKey.foregroundColor] as! UIColor, .lightGray)
        XCTAssertEqual(attributes.attributes[NSAttributedStringKey.font] as! UIFont, .italicSystemFont(ofSize: 18.0))
    }
}
