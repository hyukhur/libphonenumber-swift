//
//  PhoneNumber.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 1/28/15.
//  Copyright (c) 2015 Hyuk Hur. All rights reserved.
//

import Foundation

public enum CountryCodeSource: Int, Printable {
    case FROM_NUMBER_WITH_PLUS_SIGN = 1
    case FROM_NUMBER_WITH_IDD = 5
    case FROM_NUMBER_WITHOUT_PLUS_SIGN = 10
    case FROM_DEFAULT_COUNTRY = 20
    static let strings = [FROM_NUMBER_WITH_PLUS_SIGN:"FROM_NUMBER_WITH_PLUS_SIGN", FROM_NUMBER_WITH_IDD:"FROM_NUMBER_WITH_IDD", FROM_NUMBER_WITHOUT_PLUS_SIGN:"FROM_NUMBER_WITHOUT_PLUS_SIGN", FROM_DEFAULT_COUNTRY:"FROM_DEFAULT_COUNTRY"]
    public var description: String {
        get {
            if let string = CountryCodeSource.strings[self] {
                return string
            } else {
                return "\(self.rawValue)"
            }
        }
    }
}

public class PhoneNumber:Equatable, Printable {
    public var countryCode = 0
    public var nationalNumber = 0
    public var extensionFormat = ""
    public var isItalianLeadingZero = false
    public var numberOfLeadingZeros = 1
    public var rawInput = ""
    public var countryCodeSource:CountryCodeSource?
    public var preferredDomesticCarrierCode:String?

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
        self.isItalianLeadingZero = value
        return self
    }
    public func setRawInput(value:String) -> PhoneNumber {
        self.rawInput = value
        return self
    }
    public func clear() {
        countryCode = 0
        nationalNumber = 0
        extensionFormat = ""
        isItalianLeadingZero = false
        numberOfLeadingZeros = 1
        rawInput = ""
        countryCodeSource = nil
        preferredDomesticCarrierCode = nil
    }
    public func mergeFrom(other:PhoneNumber) -> PhoneNumber {
        countryCode = other.countryCode != 0 ?other.countryCode:self.countryCode
        nationalNumber = other.nationalNumber != 0 ?other.nationalNumber:self.nationalNumber
        extensionFormat = other.extensionFormat != "" ? other.extensionFormat:self.extensionFormat
        isItalianLeadingZero = other.isItalianLeadingZero ? other.isItalianLeadingZero : self.isItalianLeadingZero
        numberOfLeadingZeros = other.numberOfLeadingZeros != 1 ? other.numberOfLeadingZeros:self.numberOfLeadingZeros
        rawInput = other.rawInput != "" ?other.rawInput:self.rawInput
        countryCodeSource = other.countryCodeSource != CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN ? other.countryCodeSource:self.countryCodeSource
        preferredDomesticCarrierCode = other.preferredDomesticCarrierCode != nil && other.preferredDomesticCarrierCode != "" ? other.preferredDomesticCarrierCode:self.preferredDomesticCarrierCode
        return self
    }
    public func setExtension(value:String) -> PhoneNumber {
        self.extensionFormat = value
        return self
    }
    public func clearRawInput() -> PhoneNumber {
        self.rawInput = ""
        return self
    }
    public func setPreferredDomesticCarrierCode(value:String) -> PhoneNumber {
        self.preferredDomesticCarrierCode = value
        return self
    }
    public func setNumberOfLeadingZeros(value:Int) -> PhoneNumber {
        self.numberOfLeadingZeros = value
        return self
    }
    public func getCountryCodeSource() -> CountryCodeSource? {
        return countryCodeSource;
    }
    public func getCountryCodeSourceOrDefault() -> CountryCodeSource {
        if let countryCodeSource = self.countryCodeSource {
            return countryCodeSource
        } else {
            return CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN
        }
    }
    public func setCountryCodeSource(value:CountryCodeSource) -> PhoneNumber {
        self.countryCodeSource = value
        return self
    }
    public func hasCountryCodeSource() -> Bool {
        return self.countryCodeSource != CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN
    }
    public func clearItalianLeadingZero() {
        self.isItalianLeadingZero = false
    }

    public var description: String {
        return "" +
        "countryCode : \(countryCode)\n" +
        "nationalNumber : \(nationalNumber)\n" +
        "extensionFormat : \(extensionFormat)\n" +
        "isItalianLeadingZero : \(isItalianLeadingZero)\n" +
        "numberOfLeadingZeros : \(numberOfLeadingZeros)\n" +
        "rawInput : \(rawInput)\n" +
        "countryCodeSource : \(countryCodeSource)\n" +
        "preferredDomesticCarrierCode : \(preferredDomesticCarrierCode)\n"
    }
}

public func == (lhs: PhoneNumber, rhs: PhoneNumber) -> Bool {
    let result = lhs.countryCode == rhs.countryCode &&
        lhs.nationalNumber == rhs.nationalNumber &&
        lhs.extensionFormat == rhs.extensionFormat &&
        lhs.isItalianLeadingZero == rhs.isItalianLeadingZero &&
        lhs.numberOfLeadingZeros == rhs.numberOfLeadingZeros &&
        lhs.rawInput == rhs.rawInput &&
        ((lhs.countryCodeSource == nil && rhs.countryCodeSource == nil) || lhs.countryCodeSource == rhs.countryCodeSource) &&
        lhs.preferredDomesticCarrierCode == rhs.preferredDomesticCarrierCode
    return result
}
