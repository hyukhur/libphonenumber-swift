//
//  LibPhoneNumberSwiftTests.swift
//  LibPhoneNumberSwiftTests
//
//  Created by Hyuk Hur on 12/31/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

import Cocoa
import Foundation
import XCTest

class LibPhoneNumberSwift_SwiftTests: XCTestCase {
    internal var testDriver = "Swift"

    override func setUp() {
        super.setUp()
//        self.testDriver = NSObject()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}

class LibPhoneNumberSwift_JavascriptTests: LibPhoneNumberSwift_SwiftTests {
    override func setUp() {
        super.setUp()
        testDriver = "Javascript"
    }
}
