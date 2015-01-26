//
//  PhoneNumberUtil.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 12/31/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

import Foundation

public class PhoneNumberUtil {
    var metaData:NSArray
    public init() {
        self.metaData = []
    }

    public convenience init(URL:NSURL) {
        self.init()
        if let metaData = NSArray(contentsOfURL: URL)? {
            self.metaData = metaData;
        }
    }

    public func getSupportedRegions() -> [String] {
        let result = metaData.valueForKey("id") as [String]
        return result
    }
}