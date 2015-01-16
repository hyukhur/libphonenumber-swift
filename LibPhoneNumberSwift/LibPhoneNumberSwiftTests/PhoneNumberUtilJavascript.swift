//
//  PhoneNumberUtilJavascript.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 1/1/15.
//  Copyright (c) 2015 Hyuk Hur. All rights reserved.
//

import Foundation
import LibPhoneNumberSwift
import JavaScriptCore

public class PhoneNumberUtilJavascript: PhoneNumberUtil {
    var phoneUtil:JSValue?
    let context:JSContext = JSContext()

    override public init() {
        super.init()

        self.context.exceptionHandler = {(context, exception) -> Void in
            println("#### Javascript Exception: \(exception)")
        }

        var error:NSError?
        if let URL = NSURL(fileURLWithPath: "/Users/hyukhur/Documents/source/libphonenumber-swift/LibPhoneNumberSwift/LibPhoneNumberSwiftTests/libphonenumber.js")? {
            let javascript = String(contentsOfURL: URL, encoding: NSUTF8StringEncoding, error: &error)
            if let result = self.context.evaluateScript(javascript)? {
                println("Success Load LibPhoneNumber Javascript")
            }
        }
        self.context.evaluateScript("var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();");
        var phoneUtil:JSValue? = self.context.globalObject?.objectForKeyedSubscript("phoneUtil")
        if let phoneUtil = phoneUtil? {
            if !phoneUtil.isUndefined() && !phoneUtil.isNull() {
                self.phoneUtil = phoneUtil
                println(phoneUtil.toObject())
            } else {
                println("Fail Load LibPhoneNumber Object")
            }
        }
    }

    public override func getSupportedRegions() -> [String:AnyObject] {
        if let result = self.phoneUtil?.invokeMethod("getSupportedRegions", withArguments:nil).toDictionary()? {
            return result as [String:AnyObject]
        } else {
            return ["1":[]]
        }
    }
}