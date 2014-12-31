//
//  PhoneNumberUtilTest.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 12/31/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

import Foundation
import XCTest

class PhoneNumberUtil_SwiftTests: XCTestCase {
    internal var testDriver = "Swift"

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

class PhoneNumberUtil_JavascriptTests: PhoneNumberUtil_SwiftTests {
    override func setUp() {
        super.setUp()
        testDriver = "Javascript"
    }
}
