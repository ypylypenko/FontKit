//
//  FontKitTests.swift
//  FontKitTests
//
//  Created by Ievhenii Pylypenko on 30.06.16.
//  Copyright © 2016 Ievhenii Pylypenko. All rights reserved.
//

import UIKit
import XCTest
@testable import FontKit

class FontKitTests: XCTestCase {
   
    func testIconFontShouldBeRegisted() {
        let label = UILabel()
        label.font = UIFont.wiIconOfSize(200)
        XCTAssertNotNil(label.font, "Icon font should not be nil.")
    }
    
    func testLabelText() {
        let label = UILabel()
        label.font = UIFont.wiIconOfSize(200)
        label.text = String.wiIconWithName(FKWeatherIcon.WiDayCloudy)
        XCTAssertEqual(label.text, "\u{f002}")
        label.text = String.wiIconWithCode("wi-day-cloudy")
        XCTAssertEqual(label.text, "\u{f002}")
    }

    func testButtonTitle() {
        let button = UIButton()
        button.titleLabel?.font = UIFont.wiIconOfSize(30)
        button.setTitle(String.wiIconWithName(.WiDayCloudy), forState: .Normal)
        XCTAssertEqual(button.titleLabel?.text, "\u{f002}")
    }

    func testBarItemTitle() {
        let barItem = UIBarButtonItem()
        let attributes = [NSFontAttributeName: UIFont.wiIconOfSize(20)] as Dictionary!
        barItem.setTitleTextAttributes(attributes, forState: .Normal)
        barItem.title = String.wiIconWithName(.WiDayCloudy)
        XCTAssertEqual(barItem.title, "\u{f002}")
    }
    
    func testIconImage() {
        let barItem = UIBarButtonItem()
        barItem.image = UIImage.wiIconWithName(FKWeatherIcon.WiDayCloudy, textColor: UIColor.blueColor(), size: CGSizeMake(4000, 4000), backgroundColor: UIColor.redColor())
        XCTAssertNotNil(barItem.image)
    }
    
}
