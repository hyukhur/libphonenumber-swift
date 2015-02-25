//
//  PhoneMetadata.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 1/27/15.
//  Copyright (c) 2015 Hyuk Hur. All rights reserved.
//

import Foundation

public class NumberFormat {
    public var pattern = ""
    public var format = ""
    public var leadingDigitsPattern = [String]()
    public var nationalPrefixFormattingRule = ""

    public init() {
        // TODO: should be implemented
    }
    public func getPattern() -> String {
        return pattern
    }
    public func setPattern(value:String) -> NumberFormat {
        pattern = value
        return self
    }
    public func getFormat() -> String {
        return format
    }
    public func setFormat(value:String) -> NumberFormat {
        format = value
        return self
    }
    public func leadingDigitsPatternSize() -> Int {
        return leadingDigitsPattern.count
    }
    public func getLeadingDigitsPattern(index:Int) -> String {
        return leadingDigitsPattern[index]
    }
    public func setNationalPrefixFormattingRule(value:String) -> NumberFormat {
        nationalPrefixFormattingRule = value
        return self
    }
}

public class PhoneNumberDesc {
    public init() {
        // TODO: should be implemented
    }
    public func getNationalNumberPattern() -> String {
        // TODO: should be implemented
        return ""
    }
    public func setNationalNumberPattern(value:String) -> PhoneNumberDesc {
        // TODO: should be implemented
        return self
    }
    public func getPossibleNumberPattern() -> String {
        // TODO: should be implemented
        return ""
    }
    public func exactlySameAs(other:PhoneNumberDesc) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func getExampleNumber() -> String {
        // TODO: should be implemented
        return ""
    }
}

public class PhoneMetadataCollection {
    // TODO: should be implemented
}

public class PhoneMetadata {
    public var metadataID = ""
    public var countryCode = -1
    public var internationalPrefix = ""
    public var nationalPrefix = ""
    public var nationalPrefixForParsing = ""
    public var nationalPrefixTransformRule = ""
    public var numberFormats = [NumberFormat]()
    public var intlNumberFormats = [NumberFormat]()
    public var generalDesc = PhoneNumberDesc()
    public var tollFree = PhoneNumberDesc()
    public var fixedLine = PhoneNumberDesc()
    public var premiumRate = PhoneNumberDesc()
    public var sharedCost = PhoneNumberDesc()

    public init() {
        // TODO: should be implemented
    }
    public func getId() -> String {
        return metadataID
    }
    public func setId(value:String) {
        metadataID = value
    }
    public func getCountryCode() -> Int {
        return countryCode
    }
    public func getInternationalPrefix() -> String {
        return internationalPrefix
    }
    public func hasNationalPrefix() -> Bool {
        return nationalPrefix != ""
    }
    public func getNationalPrefix() -> String {
        return nationalPrefix
    }
    public func getNationalPrefixForParsing() -> String {
        return nationalPrefixForParsing
    }
    public func setNationalPrefixForParsing(value:String) {
        nationalPrefixForParsing = value
    }
    public func getNationalPrefixTransformRule() -> String {
        return nationalPrefixTransformRule
    }
    public func setNationalPrefixTransformRule(value:String) {
        nationalPrefixTransformRule = value
    }
    public func numberFormatSize() -> Int {
        return numberFormats.count
    }
    public func getNumberFormat(index:Int) -> NumberFormat {
        return numberFormats[index]
    }
    public func addNumberFormat(numberFormat:NumberFormat) {
        numberFormats.append(numberFormat)
    }
    public func getIntlNumberFormat(index:Int) -> NumberFormat {
        return intlNumberFormats[index]
    }
    public func getGeneralDesc() -> PhoneNumberDesc {
        return generalDesc
    }
    public func setGeneralDesc(phoneNumberDesc:PhoneNumberDesc) {
        generalDesc = phoneNumberDesc
    }
    public func getTollFree() -> PhoneNumberDesc {
        return tollFree
    }
    public func getFixedLine() -> PhoneNumberDesc {
        return fixedLine
    }
    public func getPremiumRate() -> PhoneNumberDesc {
        return premiumRate
    }
    public func getSharedCost() -> PhoneNumberDesc {
        return sharedCost
    }
}
