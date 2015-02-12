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
import LibPhoneNumberSwift

extension PhoneNumberUtil {
    @objc public func returnTrue() -> Bool {
        return true
    }
}

extension PhoneNumberUtilJavascript {
    @objc override public func returnTrue() -> Bool  {
        return false
    }
}

class LibPhoneNumberSwift_SwiftTests: XCTestCase {
    lazy var testDriver:PhoneNumberUtil = self.driver

    var driver:PhoneNumberUtil {
        if let plist = NSURL(fileURLWithPath:"metadata/PhoneNumberMetadata.plist") {
            return PhoneNumberUtil(URL:plist)
        }
        return PhoneNumberUtil()
    }

    func testCompatibility() {
        if (self.isKindOfClass(LibPhoneNumberSwift_JavascriptTests)) {
            XCTAssertFalse(testDriver.returnTrue(), "Pass")
        } else {
            XCTAssertTrue(testDriver.returnTrue(), "Pass")
        }
    }

    func testPerformanceExample() {
        self.measureBlock() {
            let testDriver = self.driver
            testDriver.getSupportedRegions()
        }
    }
}

class LibPhoneNumberSwift_JavascriptTests: LibPhoneNumberSwift_SwiftTests {
    override var driver:PhoneNumberUtil {
        return PhoneNumberUtilJavascript.getInstance()
    }
}
