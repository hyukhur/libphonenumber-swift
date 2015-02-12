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

    }
    public func getPattern() -> String {
        // TODO: should be implemented
        return ""
    }
    public func setPattern(value:String) -> NumberFormat {
        return self
    }
    public func getFormat() -> String {
        // TODO: should be implemented
        return ""
    }
    public func setFormat(value:String) -> NumberFormat {
        return self
    }
    public func leadingDigitsPatternSize() -> Int {
        return 1
    }

    public func getLeadingDigitsPattern(index:Int) -> String {
        return ""
    }
    public func setNationalPrefixFormattingRule(value:String) -> NumberFormat {
        return self
    }
}

public class PhoneNumberDesc {
    public init() {
        
    }
    public func getNationalNumberPattern() -> String {
        // TODO: should be implemented
        return ""
    }
    public func setNationalNumberPattern(value:String) -> PhoneNumberDesc {
        return self
    }
    public func getPossibleNumberPattern() -> String {
        // TODO: should be implemented
        return ""
    }

    public func exactlySameAs(other:PhoneNumberDesc) -> Bool {
        return false
    }

    public func getExampleNumber() -> String {
        return ""
    }
}

public class PhoneMetadataCollection {

}

public class PhoneMetadata {
    public init() {
        
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
        return ""
    }
    public func getNationalPrefixForParsing() -> String {
        return ""
    }
    public func setNationalPrefixForParsing(value:String) {

    }
    public func getNationalPrefixTransformRule() -> String {
        return ""
    }
    public func setNationalPrefixTransformRule(value:String) {
        
    }
    public func getNumberFormat(index:Int) -> NumberFormat {
        return NumberFormat()
    }

    public func getIntlNumberFormat(index:Int) -> NumberFormat {
        return NumberFormat()
    }
    public func getGeneralDesc() -> PhoneNumberDesc {
        return PhoneNumberDesc()
    }
    public func setGeneralDesc(phoneNumberDesc:PhoneNumberDesc) {

    }
    public func getTollFree() -> PhoneNumberDesc {
        return PhoneNumberDesc()
    }

    public func getFixedLine() -> PhoneNumberDesc {
        return PhoneNumberDesc()
    }

    public func getPremiumRate() -> PhoneNumberDesc {
        return PhoneNumberDesc()
    }
    public func getSharedCost() -> PhoneNumberDesc {
        return PhoneNumberDesc()
    }
}
