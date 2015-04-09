//
//  NexusTests.swift
//  NexusTests
//
//  Created by Rich Burdon on 4/5/15.
//  Copyright (c) 2015 Alien Laboratories. All rights reserved.
//

import UIKit
import XCTest
import SwiftyJSON

class NexusTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // ...
    }
    
    override func tearDown() {
        // ...
        super.tearDown()
    }
    
    func testExample() {
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        self.measureBlock() {
        }
    }
    
    // http://www.raywenderlich.com/82706/working-with-json-in-swift-tutorial
    
    func testJson() {
        let raw = [
            "id": "123",
            "summary": [
                "title": "Test"
            ]
        ]

        let json = JSON(raw)
        let title = json["summary"]["title"]
        XCTAssert(title == "Test")
    }

    func testItemUtil() {
        var item = ItemUtil.create(meta: JSON(["id": "124", "type": "org"]), summary: JSON(["title": "AlienLabs"]))
        XCTAssert("AlienLabs" == item["summary"]["title"])
    }
    
}
