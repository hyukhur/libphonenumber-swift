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
    public init() {
    }
    public func setCountryCode(code:Int) -> PhoneNumber {
        return self
    }
    public func setNationalNumber(nationalNumber:Int) -> PhoneNumber {
        return self
    }
    public func setItalianLeadingZero(value:Bool) -> PhoneNumber {
        return self
    }
    public func setRawInput(value:String) -> PhoneNumber {
        return self
    }
    public func clear() {
        
    }
    public func mergeFrom(other:PhoneNumber) -> PhoneNumber {
        return self
    }
    public func setExtension(value:String) -> PhoneNumber {
        return self
    }
    public func clearRawInput() -> PhoneNumber {
        return self
    }
    public func setPreferredDomesticCarrierCode(value:String) -> PhoneNumber {
        return self
    }
    public func setNumberOfLeadingZeros(value:Int) -> PhoneNumber {
        return self
    }
    public func getCountryCodeSource() -> CountryCodeSource {
        return CountryCodeSource.FROM_DEFAULT_COUNTRY
    }
    public func setCountryCodeSource(value:CountryCodeSource) -> PhoneNumber {
        return self
    }
    public func hasCountryCodeSource() -> Bool {
        return false
    }
    public func clearItalianLeadingZero() {
        
    }
}

public func == (lhs: PhoneNumber, rhs: PhoneNumber) -> Bool {
    return false
}
