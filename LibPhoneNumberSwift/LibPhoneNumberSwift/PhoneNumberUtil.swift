//
//  PhoneNumberUtil.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 12/31/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

import Foundation

public class PhoneNumberUtil {
    var metaData:Array<Dictionary<String, AnyObject>>
    public init() {
        self.metaData = [Dictionary()]
    }

    public convenience init(URL:NSURL) {
        self.init()
        if let metaData = NSArray(contentsOfURL: URL)? as? Array<Dictionary<String, AnyObject>> {
            self.metaData = metaData;
        }
    }

    public func getSupportedRegions() -> [String] {
        return metaData.reduce([], combine: { (var result:[String], each) -> [String] in
            result.append(each["id"] as String)
            return result
        })
    }
}