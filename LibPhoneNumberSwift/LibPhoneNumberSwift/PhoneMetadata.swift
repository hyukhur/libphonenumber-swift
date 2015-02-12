//
//  PhoneMetadata.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 1/27/15.
//  Copyright (c) 2015 Hyuk Hur. All rights reserved.
//

import Foundation

public class NumberFormat {
    public init() {
        // TODO: should be implemented
    }
    public func getPattern() -> String {
        // TODO: should be implemented
        return ""
    }
    public func setPattern(value:String) -> NumberFormat {
        // TODO: should be implemented
        return self
    }
    public func getFormat() -> String {
        // TODO: should be implemented
        return ""
    }
    public func setFormat(value:String) -> NumberFormat {
        // TODO: should be implemented
        return self
    }
    public func leadingDigitsPatternSize() -> Int {
        // TODO: should be implemented
        return 1
    }
    public func getLeadingDigitsPattern(index:Int) -> String {
        // TODO: should be implemented
        return ""
    }
    public func setNationalPrefixFormattingRule(value:String) -> NumberFormat {
        // TODO: should be implemented
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
    public init() {
        // TODO: should be implemented
    }
    public func getId() -> String {
        // TODO: should be implemented
        return ""
    }
    public func getCountryCode() -> Int {
        // TODO: should be implemented
        return -1
    }
    public func getInternationalPrefix() -> String {
        // TODO: should be implemented
        return ""
    }
    public func hasNationalPrefix() -> Bool {
        // TODO: should be implemented
        return false
    }
    public func numberFormatSize() -> Int {
        // TODO: should be implemented
        return -1
    }
    public func getNationalPrefix() -> String {
        // TODO: should be implemented
        return ""
    }
    public func getNationalPrefixForParsing() -> String {
        // TODO: should be implemented
        return ""
    }
    public func setNationalPrefixForParsing(value:String) {
        // TODO: should be implemented
    }
    public func getNationalPrefixTransformRule() -> String {
        // TODO: should be implemented
        return ""
    }
    public func setNationalPrefixTransformRule(value:String) {
        // TODO: should be implemented
    }
    public func getNumberFormat(index:Int) -> NumberFormat {
        // TODO: should be implemented
        return NumberFormat()
    }
    public func getIntlNumberFormat(index:Int) -> NumberFormat {
        // TODO: should be implemented
        return NumberFormat()
    }
    public func getGeneralDesc() -> PhoneNumberDesc {
        // TODO: should be implemented
        return PhoneNumberDesc()
    }
    public func setGeneralDesc(phoneNumberDesc:PhoneNumberDesc) {
        // TODO: should be implemented
    }
    public func getTollFree() -> PhoneNumberDesc {
        // TODO: should be implemented
        return PhoneNumberDesc()
    }
    public func getFixedLine() -> PhoneNumberDesc {
        // TODO: should be implemented
        return PhoneNumberDesc()
    }
    public func getPremiumRate() -> PhoneNumberDesc {
        // TODO: should be implemented
        return PhoneNumberDesc()
    }
    public func getSharedCost() -> PhoneNumberDesc {
        // TODO: should be implemented
        return PhoneNumberDesc()
    }
}
