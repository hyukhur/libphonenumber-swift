
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


extension NumberFormat {
    convenience init(javascriptValue:JSValue) {
        self.init()
        if let value = javascriptValue.invokeMethod("getPattern", withArguments: nil).toString() where value != "undefined"  {
            self.pattern = value
        }
        if let value = javascriptValue.invokeMethod("getFormat", withArguments: nil).toString() where value != "undefined"  {
            self.format = value
        }
        if let value:[String] = javascriptValue.invokeMethod("leadingDigitsPatternArray", withArguments: nil).toArray() as? [String] {
            for pattern in value {
                self.leadingDigitsPattern.append(pattern)
            }
        }
        if let value = javascriptValue.invokeMethod("getNationalPrefixFormattingRule", withArguments: nil).toString() where value != "undefined"  {
            self.nationalPrefixFormattingRule = value
        }
    }
}

var callCount:Int = 0
extension PhoneNumber {
    func invokeMethod(functionName:String, context:JSContext, lineNumber:Int = __LINE__) -> JSValue? {
        let varName = "phoneNumber_\(lineNumber)_\(callCount++)"
        var javascript = " " +
            "var \(varName) = new i18n.phonenumbers.PhoneNumber();" +
            "\(varName).setCountryCode(\(self.countryCode));" +
        "\(varName).setNationalNumber(\(self.nationalNumber));"

        if self.isItalianLeadingZero {
            javascript += "\(varName).setItalianLeadingZero(\(self.isItalianLeadingZero));"
        }
        if self.countryCodeSource != CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN {
            javascript += "\(varName).setCountryCodeSource(\(self.countryCodeSource.rawValue));"
        }
        if self.rawInput != "" {
            javascript += "\(varName).setRawInput(\"\(self.rawInput)\");"
        }
        if self.extensionFormat != "" {
            javascript += "\(varName).setExtensionFormat(\"\(self.extensionFormat)\");"
        }
        if self.numberOfLeadingZeros != 1 {
            javascript += "\(varName).setNumberOfLeadingZeros(\(self.numberOfLeadingZeros));"
        }
        if self.preferredDomesticCarrierCode != "" {
            javascript += "\(varName).setPreferredDomesticCarrierCode(\"\(self.preferredDomesticCarrierCode)\");"
        }

        javascript += "phoneUtil.\(functionName)(\(varName));"
        return context.evaluateScript(javascript)
    }
    convenience init(javascriptValue:JSValue) {
        self.init()
        if let value = javascriptValue.invokeMethod("getCountryCode", withArguments: nil) where value.isNumber()  {
            self.countryCode = value.toNumber().integerValue
        }
        if let value = javascriptValue.invokeMethod("getNationalNumber", withArguments: nil) where value.isNumber()  {
            self.nationalNumber = value.toNumber().integerValue
        }
        if let value = javascriptValue.invokeMethod("getExtension", withArguments: nil) where value.isString()  {
            self.extensionFormat = value.toString()
        }
        if let value = javascriptValue.invokeMethod("getItalianLeadingZero", withArguments: nil) where value.isBoolean()  {
            self.isItalianLeadingZero = value.toBool()
        }
        if let value = javascriptValue.invokeMethod("getNumberOfLeadingZeros", withArguments: nil) where value.isNumber()  {
            self.numberOfLeadingZeros = value.toNumber().integerValue
        }
        if let value = javascriptValue.invokeMethod("getRawInput", withArguments: nil) where value.isString()  {
            self.rawInput = value.toString()
        }
        if let value = javascriptValue.invokeMethod("getCountryCodeSource", withArguments: nil) where value.isNumber()  {
            self.countryCodeSource = CountryCodeSource(rawValue:value.toNumber().integerValue)!
        }
        if let value = javascriptValue.invokeMethod("getPreferredDomesticCarrierCode", withArguments: nil) where value.isString()  {
            self.preferredDomesticCarrierCode = value.toString()
        }
    }
}

extension PhoneNumberDesc {
    convenience init(javascriptValue:JSValue) {
        self.init()
        if let value = javascriptValue.invokeMethod("getNationalNumberPattern", withArguments: nil).toString() where value != "undefined"  {
            self.nationalNumberPattern = value
        }
        if let value = javascriptValue.invokeMethod("getPossibleNumberPattern", withArguments: nil).toString() where value != "undefined"  {
            self.possibleNumberPattern = value
        }
        if let value = javascriptValue.invokeMethod("getExampleNumber", withArguments: nil).toString() where value != "undefined"  {
            self.exampleNumber = value
        }
    }
}

extension PhoneMetadata {
    convenience init(javascriptValue:JSValue) {
        self.init()
        if let value = javascriptValue.invokeMethod("getId", withArguments: nil).toString() where value != "undefined" {
            self.metadataID = value
        }
        if let value = javascriptValue.invokeMethod("getCountryCode", withArguments: nil).toNumber() where !isnan(value.doubleValue) {
            self.countryCode = value.integerValue
        }
        if let value = javascriptValue.invokeMethod("getInternationalPrefix", withArguments: nil).toString() where value != "undefined" {
            self.internationalPrefix = value
        }
        if let value = javascriptValue.invokeMethod("getNationalPrefix", withArguments: nil).toString() where value != "undefined" {
            self.nationalPrefix = value
        }
        if let value = javascriptValue.invokeMethod("getNationalPrefixForParsing", withArguments: nil).toString() where value != "undefined" {
            self.nationalPrefixForParsing = value
        }
        if let value = javascriptValue.invokeMethod("getNationalPrefixTransformRule", withArguments: nil).toString() where value != "undefined" {
            self.nationalPrefixTransformRule = value
        }
        if let value = javascriptValue.invokeMethod("numberFormatArray", withArguments: nil) {
            var format = value.invokeMethod("shift", withArguments:nil)
            while format.toString() != "undefined" {
                self.numberFormats.append(NumberFormat(javascriptValue:format))
                format = value.invokeMethod("shift", withArguments:nil)
            }
        }
        if let value = javascriptValue.invokeMethod("intlNumberFormatArray", withArguments: nil) {
            var format = value.invokeMethod("shift", withArguments:nil)
            while format.toString() != "undefined" {
                self.intlNumberFormats.append(NumberFormat(javascriptValue:format))
                format = value.invokeMethod("shift", withArguments:nil)
            }
        }
        if let value = javascriptValue.invokeMethod("getGeneralDesc", withArguments: nil) {
            self.generalDesc = PhoneNumberDesc(javascriptValue:value)
        }
        if let value = javascriptValue.invokeMethod("getTollFree", withArguments: nil) {
            self.tollFree = PhoneNumberDesc(javascriptValue:value)
        }
        if let value = javascriptValue.invokeMethod("getFixedLine", withArguments: nil) {
            self.fixedLine = PhoneNumberDesc(javascriptValue:value)
        }
        if let value = javascriptValue.invokeMethod("getPremiumRate", withArguments: nil) {
            self.premiumRate = PhoneNumberDesc(javascriptValue:value)
        }
        if let value = javascriptValue.invokeMethod("getSharedCost", withArguments: nil) {
            self.sharedCost = PhoneNumberDesc(javascriptValue:value)
        }
    }
}


let isTestData = true
var sharedInstance: PhoneNumberUtilJavascript = PhoneNumberUtilJavascript()

public class PhoneNumberUtilJavascript: PhoneNumberUtil {
    var phoneUtil:JSValue?
    static var phoneUtilClass:JSValue?
    let context:JSContext = JSContext()

    class func getInstance() -> PhoneNumberUtilJavascript {
        return sharedInstance
    }

    /*
        Just easy to read downloaded file then NSCache.
    */
    func cacheFilePath() -> String? {
        let path = NSTemporaryDirectory().stringByAppendingPathComponent("LibPhoneNumberSwift")
        var error:NSError?;
        if (!NSFileManager.defaultManager().fileExistsAtPath(path) && !NSFileManager.defaultManager().createDirectoryAtPath(path, withIntermediateDirectories: false, attributes: nil, error: &error)) {
            println("Cache File Directory making fail \(error)")
            return nil
        }
        return path.stringByAppendingPathComponent("libphonenumber.js")
    }

    func saveJavascript(string:String) {
        if let path = cacheFilePath() {
            var error:NSError?;
            string.writeToFile(path, atomically: false, encoding: NSUTF8StringEncoding, error: &error)
            if let error = error {
                println("cache file save error: \(error)")
            }
        } else {
            println("cache file path search fail")
        }
    }

    func loadJavascript() -> String? {
        if let path = cacheFilePath() {
            var error:NSError?;
            if let result = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: &error) {
                println("cache file hit: \(path)")
                return result
            }
            if let error = error {
                println("cache file load error: \(error)")
            }
        } else {
            println("cache file path search fail")
        }
        return nil
    }

    func clearJavascript() {
        if let path = cacheFilePath() {
            var error:NSError?;
            if (!NSFileManager.defaultManager().removeItemAtPath(path, error:&error)) {
                println(" cache file clear success")
            }
            if let error = error {
                println("cache file load error: \(error)")
            }
        } else {
            println("cache file path search fail")
        }
    }

    /*
        FIXME: 2015.Feb.16, downloaded contents is too small and broken Javascript file.
        I should get compiled javascript library from the site manually.
    */
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
            "&code_url=" + libphonenumberJavascriptRepo + "phonemetadata.pb.js" +
            "&code_url=" + libphonenumberJavascriptRepo + "phonenumber.pb.js" +
            "&code_url=" + libphonenumberJavascriptRepo + metadataFileName +
            "&code_url=" + libphonenumberJavascriptRepo + "phonenumberutil.js" +
            "&code_url=" + libphonenumberJavascriptRepo + "asyoutypeformatter.js"

        request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)

        let semaphore = dispatch_semaphore_create(0);
        var result:String?
        let task = session.downloadTaskWithRequest(request, completionHandler: { (location:NSURL!, response:NSURLResponse!, error:NSError!) -> Void in
            if let error = error {
                println("Request Fail \(error)")
                dispatch_semaphore_signal(semaphore);
                return
            }
            let data = NSData(contentsOfURL: location)
            if data == nil {
                println("Request Fail without error")
                dispatch_semaphore_signal(semaphore);
                return
            }

            var error: NSError?
            if let data:NSData = data, json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &error) as? NSDictionary {
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
            if let error = error {
                println("Response Error: \(error)")
            }
            println("JSON Parsing Error with: \(NSString(data: data!, encoding: NSUTF8StringEncoding)!)")
            dispatch_semaphore_signal(semaphore);
        })

        task.resume()

        dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, (Int64)(60 * NSEC_PER_SEC)))
        return result
    }

    func loadLibrary(#javascript:String?) -> Bool {
        self.context.exceptionHandler = {(context, exception) -> Void in
            println("#### Javascript Exception: \(exception)")
        }
        if let result = self.context.evaluateScript(javascript) {
            println("Success Load libphonenumber library")
        } else {
            println("Fail evaluateScript libphonenumber library")
        }
        if let phoneUtilClass = self.context.globalObject.objectForKeyedSubscript("i18n").objectForKeyedSubscript("phonenumbers").objectForKeyedSubscript("PhoneNumberUtil") {
            if !phoneUtilClass.isUndefined() && !phoneUtilClass.isNull() {
                self.dynamicType.phoneUtilClass = phoneUtilClass
            }
        }
        self.context.evaluateScript("var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();");
        if let phoneUtil = self.context.globalObject?.objectForKeyedSubscript("phoneUtil") {
            if !phoneUtil.isUndefined() && !phoneUtil.isNull() {
                self.phoneUtil = phoneUtil
                println("Success Load LibPhoneNumber")
                return true
            } else {
                println("Fail Load LibPhoneNumber Object")
            }
        }
        return false
    }

    public init() {
        super.init(URL: NSURL(), countryCodeToRegionCodeMap: getCountryCodeToRegionCodeMap())
        var javascript:String? = loadJavascript()
        if let javascriptDownloaded = downloadLibrary() where javascript == nil {
            saveJavascript(javascriptDownloaded)
            javascript = javascriptDownloaded
        }
        if let javascript = javascript {
            if loadLibrary(javascript: javascript) == false {
                clearJavascript()
                println("############## PhoneNumberUtilJavascript init Fail ################")
            }
        }
    }

    // MARK: - Public instance APIs

    public override func getSupportedRegions() -> [String] {
        if let result = self.phoneUtil?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments:nil)?.toArray() {
            return result as! [String]
        }
        return []
    }

    public override func getSupportedGlobalNetworkCallingCodes() -> [Int] {
        if let codes = self.phoneUtil?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments: nil)?.toArray() {
            return codes.reduce([], combine: { (var result:[Int], value) -> [Int] in
                if let code = value.integerValue {
                    result.append(code)
                }
                return result
            })
        }
        return []
    }
    public override func getRegionCodeForCountryCode(callingCode:Int) -> String {
        if let result = self.phoneUtil?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments: [callingCode]) where result.isString() {
            return result.toString()
        }
        return ""
    }
    public override func getCountryCodeForRegion(countryCode:String) -> Int{
        if let result = self.phoneUtil?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments: [countryCode]) where result.isNumber() {
            return result.toNumber().integerValue
        }
        return -1
    }
    public override func getMetadataForRegion(regionCode:String) -> PhoneMetadata? {
        if let result:JSValue = self.phoneUtil?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments: [regionCode]) where !(result.isNull() || result.isUndefined()) {
            return PhoneMetadata(javascriptValue:result)
        }
        return nil
    }
    public override func getMetadataForNonGeographicalRegion(countryCallingCode:Int) -> PhoneMetadata? {
        if let result:JSValue = self.phoneUtil?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments: [countryCallingCode]) where result.toDictionary() != nil  {
            return PhoneMetadata(javascriptValue:result)
        }
        return nil
    }
    public override func isNumberGeographical(phoneNumber:PhoneNumber) -> Bool {
        if let result = phoneNumber.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first!, context: self.context) where result.isBoolean() {
            return result.toBool()
        }
        return false
    }
    public override func isLeadingZeroPossible(countryCallingCode:Int) -> Bool {
        if let result:JSValue = self.phoneUtil?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments: [countryCallingCode]) where result.isBoolean()  {
            return result.toBool()
        }
        return false
    }
    public override func getLengthOfGeographicalAreaCode(phoneNumber:PhoneNumber) -> Int {
        if let result = phoneNumber.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first!, context: self.context) where result.isNumber() {
            return result.toNumber().integerValue
        }
        return -1
    }
    public override func getLengthOfNationalDestinationCode(phoneNumber:PhoneNumber) -> Int {
        if let result = phoneNumber.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first!, context: self.context) where result.isNumber() {
            return result.toNumber().integerValue
        }
        return -1
    }
    public override func getNationalSignificantNumber(phoneNumber:PhoneNumber) -> String {
        if let result = phoneNumber.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first!, context: self.context) where result.isString() {
            return result.toString()
        }
        return ""
    }
    public override func getExampleNumber(regionCode:String) -> PhoneNumber? {
        if let result:JSValue = self.phoneUtil?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments: [regionCode]) where !(result.isNull() || result.isUndefined())  {
            return PhoneNumber(javascriptValue:result)
        }
        return nil
    }
    public override func getExampleNumberForType(regionCode:String, phoneNumberType:PhoneNumberType) -> PhoneNumber? {
        let functionName = __FUNCTION__.componentsSeparatedByString("(").first!
        let javascript = "phoneUtil.\(functionName)(\"\(regionCode)\", i18n.phonenumbers.PhoneNumberType.\(phoneNumberType.toString()));"
        if let result:JSValue = context.evaluateScript(javascript) where !(result.isNull() || result.isUndefined()) {
            return PhoneNumber(javascriptValue:result)
        }
        return nil
    }
    public override func getExampleNumberForNonGeoEntity(countryCallingCode:Int) -> PhoneNumber {
        if let result:JSValue = self.phoneUtil?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments: [countryCallingCode]) where !(result.isNull() || result.isUndefined()) {
            return PhoneNumber(javascriptValue:result)
        }
        return PhoneNumber()
    }
    public override func format(number:PhoneNumber, numberFormat:PhoneNumberFormat) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func formatOutOfCountryCallingNumber(number:PhoneNumber, regionCallingFrom:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func formatOutOfCountryKeepingAlphaChars(number:PhoneNumber, regionCallingFrom:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func formatNationalNumberWithCarrierCode(number:PhoneNumber, carrierCode:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func formatNationalNumberWithPreferredCarrierCode(number:PhoneNumber, fallbackCarrierCode:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func formatNumberForMobileDialing(number:PhoneNumber, regionCallingFrom:String, withFormatting:Bool) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func formatByPattern(number:PhoneNumber, numberFormat:PhoneNumberFormat, userDefinedFormats:[NumberFormat]) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func parseAndKeepRawInput(numberToParse:String, defaultRegion:String, error:NSErrorPointer) -> PhoneNumber {
        // TODO: should be implemented
        error.memory = NSError(domain: "", code: -1, userInfo:[NSLocalizedDescriptionKey:""])
        return PhoneNumber()
    }
    public override func formatInOriginalFormat(number:PhoneNumber, regionCallingFrom:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func parse(numberToParse:String, defaultRegion:String, error:NSErrorPointer) -> PhoneNumber {
        // TODO: should be implemented
        error.memory = NSError(domain: "", code: -1, userInfo:[NSLocalizedDescriptionKey:""])
        return PhoneNumber()
    }
    public override func getNumberType(number:PhoneNumber) -> PhoneNumberType {
        // TODO: should be implemented
        return PhoneNumberType.UNKNOWN
    }
    public override func isValidNumber(number:PhoneNumber) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override func isValidNumberForRegion(number:PhoneNumber, regionCode:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override func getRegionCodeForNumber(number:PhoneNumber) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func getRegionCodesForCountryCode(countryCallingCode:Int) -> [String] {
        // TODO: should be implemented
        return [""]
    }
    public override func getNddPrefixForRegion(regionCode:String, stripNonDigits:Bool) -> String {
        // TODO: should be implemented
        return ""
    }
    public override func isNANPACountry(regionCode:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override func isPossibleNumber(number:PhoneNumber) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override func isPossibleNumber(number:String, regionDialingFrom:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override func isPossibleNumberWithReason(number:PhoneNumber) -> ValidationResult {
        // TODO: should be implemented
        return ValidationResult.TOO_SHORT
    }
    public override func truncateTooLongNumber(number:PhoneNumber) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override func maybeStripNationalPrefixAndCarrierCode(number:String, metadata:PhoneMetadata, carrierCode:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override func maybeStripInternationalPrefixAndNormalize(number:String, possibleIddPrefix:String) -> CountryCodeSource {
        // TODO: should be implemented
        return CountryCodeSource.FROM_DEFAULT_COUNTRY
    }
    public override func maybeExtractCountryCode(number:String, defaultRegionMetadata:PhoneMetadata, nationalNumber:String, keepRawInput:Bool, phoneNumber:PhoneNumber, error:NSErrorPointer) -> Int {
        // TODO: should be implemented
        error.memory = NSError(domain: "", code: -1, userInfo:[NSLocalizedDescriptionKey:""])
        return -1
    }
    public override func isNumberMatch(firstString:String, secondString:String) -> MatchType {
        // TODO: should be implemented
        return MatchType.NOT_A_NUMBER
    }
    public override func isNumberMatch(firstNumber:PhoneNumber, secondString:String) -> MatchType {
        // TODO: should be implemented
        return MatchType.NOT_A_NUMBER
    }
    public override func isNumberMatch(firstNumber:PhoneNumber, secondNumber:PhoneNumber) -> MatchType {
        // TODO: should be implemented
        return MatchType.NOT_A_NUMBER
    }
    public override func canBeInternationallyDialled(number:PhoneNumber) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override func isAlphaNumber(number:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override func isMobileNumberPortableRegion(regionCode:String) -> Bool {
        // TODO: should be implemented
        return false
    }

    // MARK: - Class APIs

    public override class func getCountryMobileToken(countryCode:Int) -> String {
        if let result:JSValue = self.phoneUtilClass?.invokeMethod(__FUNCTION__.componentsSeparatedByString("(").first, withArguments: [countryCode]) where result.isString()  {
            return result.toString()
        }
        return ""
    }
    public override class func convertAlphaCharactersInNumber(input:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override class func normalize(phoneNumberString:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override class func normalizeDigitsOnly(inputNumber:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override class func normalizeDiallableCharsOnly(inputNumber:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override class func isViablePhoneNumber(number:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public override class func extractPossibleNumber(number:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public override class func nsNumberMatch(firstNumberIn:PhoneNumber, secondNumberIn:PhoneNumber) -> MatchType {
        // TODO: should be implemented
        return MatchType.NO_MATCH
    }
}
