//
//  PhoneNumber.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 1/28/15.
//  Copyright (c) 2015 Hyuk Hur. All rights reserved.
//

import Foundation

public enum CountryCodeSource {
    case FROM_NUMBER_WITH_PLUS_SIGN
    case FROM_NUMBER_WITH_IDD
    case FROM_NUMBER_WITHOUT_PLUS_SIGN
    case FROM_DEFAULT_COUNTRY
}

public class PhoneNumber:Equatable {
    public var countryCode = 0
    public var nationalNumber = 0
    public var extensionFormat = ""
    public var isItalianLeadingZero = false
    public var numberOfLeadingZeros = 1
    public var rawInput = ""
    public var countryCodeSource = CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN
    public var preferredDomesticCarrierCode = ""

    public init() {
        // TODO: should be implemented
    }
    public func setCountryCode(code:Int) -> PhoneNumber {
        countryCode = code
        return self
    }
    public func setNationalNumber(nationalNumber:Int) -> PhoneNumber {
        self.nationalNumber = nationalNumber
        return self
    }
    public func setItalianLeadingZero(value:Bool) -> PhoneNumber {
        // TODO: should be implemented
        return self
    }
    public func setRawInput(value:String) -> PhoneNumber {
        // TODO: should be implemented
        return self
    }
    public func clear() {
        // TODO: should be implemented
    }
    public func mergeFrom(other:PhoneNumber) -> PhoneNumber {
        // TODO: should be implemented
        return self
    }
    public func setExtension(value:String) -> PhoneNumber {
        // TODO: should be implemented
        return self
    }
    public func clearRawInput() -> PhoneNumber {
        // TODO: should be implemented
        return self
    }
    public func setPreferredDomesticCarrierCode(value:String) -> PhoneNumber {
        // TODO: should be implemented
        return self
    }
    public func setNumberOfLeadingZeros(value:Int) -> PhoneNumber {
        // TODO: should be implemented
        return self
    }
    public func getCountryCodeSource() -> CountryCodeSource {
        // TODO: should be implemented
        return CountryCodeSource.FROM_DEFAULT_COUNTRY
    }
    public func setCountryCodeSource(value:CountryCodeSource) -> PhoneNumber {
        // TODO: should be implemented
        return self
    }
    public func hasCountryCodeSource() -> Bool {
        // TODO: should be implemented
        return false
    }
    public func clearItalianLeadingZero() {
        // TODO: should be implemented
    }
}

public func == (lhs: PhoneNumber, rhs: PhoneNumber) -> Bool {
    // TODO: should be implemented
    return false
}
