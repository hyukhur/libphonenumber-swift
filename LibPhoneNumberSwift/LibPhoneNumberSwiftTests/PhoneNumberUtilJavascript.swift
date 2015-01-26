//
//  PhoneNumberUtilJavascript.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 1/1/15.
//  Copyright (c) 2015 Hyuk Hur. All rights reserved.
//

/* http://closure-compiler.appspot.com */
// ==ClosureCompiler==
// @compilation_level SIMPLE_OPTIMIZATIONS
// @use_closure_library true
// @code_url https://raw.githubusercontent.com/googlei18n/libphonenumber/master/javascript/i18n/phonenumbers/phonemetadata.pb.js
// @code_url https://raw.githubusercontent.com/googlei18n/libphonenumber/master/javascript/i18n/phonenumbers/phonenumber.pb.js
// @code_url https://raw.githubusercontent.com/googlei18n/libphonenumber/master/javascript/i18n/phonenumbers/metadata.js
// @code_url https://raw.githubusercontent.com/googlei18n/libphonenumber/master/javascript/i18n/phonenumbers/phonenumberutil.js
// @code_url https://raw.githubusercontent.com/googlei18n/libphonenumber/master/javascript/i18n/phonenumbers/asyoutypeformatter.js
// ==/ClosureCompiler==


import Foundation
import LibPhoneNumberSwift
import JavaScriptCore

let isTestData = true
var sharedInstance: PhoneNumberUtilJavascript = PhoneNumberUtilJavascript()

public class PhoneNumberUtilJavascript: PhoneNumberUtil {
    var phoneUtil:JSValue?
    let context:JSContext = JSContext()

    class func getInstance() -> PhoneNumberUtilJavascript {
        return sharedInstance
    }

    func cacheFilePath() -> String? {
        let path = NSTemporaryDirectory().stringByAppendingPathComponent("LibPhoneNumberSwift")
        var error:NSError?;
        if (!NSFileManager.defaultManager().fileExistsAtPath(path) && !NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: false, attributes: nil, error: &error)) {
            println("Cache File Directory making fail \(error?)")
            return nil
        }
        return path.stringByAppendingPathComponent("libphonenumber.js")
    }

    func saveJavascript(string:String) {
        if let path = cacheFilePath() {
            var error:NSError?;
            string.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: &error)
            if let error = error {
                println("cache fila save error: \(error)")
            }
        } else {
            println("cache fila path search fail")
        }
    }

    func loadJavascript() -> String? {
        if let path = cacheFilePath() {
            var error:NSError?;
            if let result = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error) {
                return result
            }
            if let error = error {
                println("cache fila load error: \(error)")
            }
        } else {
            println("cache fila path search fail")
        }
        return nil
    }

    func downloadLibrary() -> String? {
        let url:NSURL? = NSURL(string:"http://closure-compiler.appspot.com/compile")
        let request:NSMutableURLRequest = NSMutableURLRequest(URL: url!)
        let session:NSURLSession = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"

        let libphonenumberJavascriptRepo = "https%3A%2F%2Fraw.githubusercontent.com%2Fgooglei18n%2Flibphonenumber%2Fmaster%2Fjavascript%2Fi18n%2Fphonenumbers%2F"
        let metadataFileName = isTestData ? "metadatafortesting.js" : "metadata.js"

        let body:String = "" +
            "output_format=json" +
            "&output_info=compiled_code" +
            "&output_info=errors" +
            "&compilation_level=SIMPLE_OPTIMIZATIONS" +
            "&use_closure_library=true" +
            "&code_url=" + libphonenumberJavascriptRepo + "phonemetadata.pb.js"
            "&code_url=" + libphonenumberJavascriptRepo + "phonenumber.pb.js" +
            "&code_url=" + libphonenumberJavascriptRepo + metadataFileName +
            "&code_url=" + libphonenumberJavascriptRepo + "phonenumberutil.js" +
            "&code_url=" + libphonenumberJavascriptRepo + "asyoutypeformatter.js"

        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)

        let semaphore = dispatch_semaphore_create(0);
        var result:String?
        let task = session.dataTaskWithRequest(request, completionHandler: {(data:NSData!, response:NSURLResponse!, error:NSError!) -> Void in
            if let error = error {
                println("Request Fail \(error)")
                dispatch_semaphore_signal(semaphore);
                return
            }
            if data == nil {
                println("Request Fail without error")
                dispatch_semaphore_signal(semaphore);
                return
            }

            var error: NSError?
            if let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &error) as? NSDictionary {
                if let error = json["errors"] as? NSArray {
                    println("Closure Compile Error: \(error)")
                    dispatch_semaphore_signal(semaphore);
                    return
                } else if let success = json["compiledCode"] as? String {
                    result = success
                    dispatch_semaphore_signal(semaphore);
                    return
                }
            }
            if let error = error? {
                println("Response Error: \(error)")
            }
            println("JSON Parsing Error with: \(NSString(data: data!, encoding: NSUTF8StringEncoding)!)")
            dispatch_semaphore_signal(semaphore);
        })

        task.resume()

        dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, (Int64)(30 * NSEC_PER_SEC)))
        return result
    }

    func loadLibrary(#javascript:String?) {
        self.context.exceptionHandler = {(context, exception) -> Void in
            println("#### Javascript Exception: \(exception)")
        }
        if let result = self.context.evaluateScript(javascript)? {
            println("Success Load libphonenumber library")
        } else {
            println("Fail evaluateScript libphonenumber library")
        }

        self.context.evaluateScript("var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();");
        var phoneUtil:JSValue? = self.context.globalObject?.objectForKeyedSubscript("phoneUtil")
        if let phoneUtil = phoneUtil? {
            if !phoneUtil.isUndefined() && !phoneUtil.isNull() {
                self.phoneUtil = phoneUtil
                println("Success Load LibPhoneNumber \(phoneUtil.toObject())")
            } else {
                println("Fail Load LibPhoneNumber Object")
            }
        }
    }

    override init() {
        super.init()
        if let javascript = downloadLibrary() {
            saveJavascript(javascript)
            loadLibrary(javascript: javascript)
        } else if let cachedJavascript:String? = loadJavascript() {
            loadLibrary(javascript: cachedJavascript)
        }
        println("############## PhoneNumberUtilJavascript init Fail ################")
    }

    public override func getSupportedRegions() -> [String] {
        if let result = self.phoneUtil?.invokeMethod("getSupportedRegions", withArguments:nil)?.toArray()? {
            return result as [String]
        }
        return []
    }
}