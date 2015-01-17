//
//  PhoneNumberUtilTest.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 12/31/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

import Foundation
import XCTest
import LibPhoneNumberSwift

class PhoneNumberUtil_SwiftTests: XCTestCase {
    lazy var phoneUtil:PhoneNumberUtil = self.driver

    var driver:PhoneNumberUtil {
        return PhoneNumberUtil()
    }

    func testGetSupportedRegions() {
        XCTAssertTrue(phoneUtil.getSupportedRegions().count > 1, "")
    }
}

class PhoneNumberUtil_JavascriptTests: PhoneNumberUtil_SwiftTests {
    override var driver:PhoneNumberUtil {
        return PhoneNumberUtilJavascript.getInstance()
    }
}
