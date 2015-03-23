//
//  PhoneNumberUtil.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 12/31/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

import Foundation

/**
* INTERNATIONAL and NATIONAL formats are consistent with the definition in ITU-T Recommendation
* E123. For example, the number of the Google Switzerland office will be written as
* "+41 44 668 1800" in INTERNATIONAL format, and as "044 668 1800" in NATIONAL format.
* E164 format is as per INTERNATIONAL format but with no formatting applied, e.g.
* "+41446681800". RFC3966 is as per INTERNATIONAL format, but with all spaces and other
* separating symbols replaced with a hyphen, and with any phone number extension appended with
* ";ext=". It also will have a prefix of "tel:" added, e.g. "tel:+41-44-668-1800".
*
* Note: If you are considering storing the number in a neutral format, you are highly advised to
* use the PhoneNumber class.
*/
public enum PhoneNumberFormat:Int {
    case E164 = 0,
    INTERNATIONAL,
    NATIONAL,
    RFC3966
    static let strings = ["E164", "INTERNATIONAL", "NATIONAL", "RFC3966"]
    public func toString() -> String {
        return PhoneNumberFormat.strings[self.rawValue]
    }
}

public let ErrorDomain = "LibPhoneNumberErrorDomain"
public enum ErrorType:Int {
    case UNKOWN = -1
    case INVALID_COUNTRY_CODE = 0
    // This generally indicates the string passed in had less than 3 digits in it. More
    // specifically, the number failed to match the regular expression VALID_PHONE_NUMBER in
    // PhoneNumberUtil.java.
    case NOT_A_NUMBER
    // This indicates the string started with an international dialing prefix, but after this was
    // stripped from the number, had less digits than any valid phone number (including country
    // code) could have.
    case TOO_SHORT_AFTER_IDD
    // This indicates the string, after any country code has been stripped, had less digits than any
    // valid phone number could have.
    case TOO_SHORT_NSN
    // This indicates the string had more digits than any valid phone number could have.
    case TOO_LONG
    public static func parse(text:String) -> ErrorType {
        switch text {
        case "Invalid country calling code":
            return INVALID_COUNTRY_CODE
        case "The string supplied did not seem to be a phone number":
            return NOT_A_NUMBER
        case "Phone number too short after IDD":
            return TOO_SHORT_AFTER_IDD
        case "The string supplied is too short to be a phone number":
            return TOO_SHORT_NSN
        case "The string supplied is too long to be a phone number":
            return TOO_LONG
        default:
            return UNKOWN
        }
    }
}

/**
* Types of phone number matches. See detailed description beside the isNumberMatch() method.
*/
public enum MatchType:Int {
    case NOT_A_NUMBER = 0,
    NO_MATCH,
    SHORT_NSN_MATCH,
    NSN_MATCH,
    EXACT_MATCH
}

/**
* Possible outcomes when testing if a PhoneNumber is possible.
*/
public enum ValidationResult:Int {
    case IS_POSSIBLE = 0,
    INVALID_COUNTRY_CODE,
    TOO_SHORT,
    TOO_LONG
}

/**
* Type of phone numbers.
*/
public enum PhoneNumberType:Int, Equatable {
    case FIXED_LINE = 0,
    MOBILE,
    // In some regions (e.g. the USA), it is impossible to distinguish between fixed-line and
    // mobile numbers by looking at the phone number itself.
    FIXED_LINE_OR_MOBILE,
    // Freephone lines
    TOLL_FREE,
    PREMIUM_RATE,
    // The cost of this call is shared between the caller and the recipient, and is hence typically
    // less than PREMIUM_RATE calls. See // http://en.wikipedia.org/wiki/Shared_Cost_Service for
    // more information.
    SHARED_COST,
    // Voice over IP numbers. This includes TSoIP (Telephony Service over IP).
    VOIP,
    // A personal number is associated with a particular person, and may be routed to either a
    // MOBILE or FIXED_LINE number. Some more information can be found here:
    // http://en.wikipedia.org/wiki/Personal_Numbers
    PERSONAL_NUMBER,
    PAGER,
    // Used for "Universal Access Numbers" or "Company Numbers". They may be further routed to
    // specific offices, but allow one number to be used for a company.
    UAN,
    // Used for "Voice Mail Access Numbers".
    VOICEMAIL,
    // A phone number is of type UNKNOWN when it does not fit any of the known patterns for a
    // specific region.
    UNKNOWN = -1

    public func toString() -> String {
        switch self {
        case .FIXED_LINE:
            return "FIXED_LINE"
        case .MOBILE:
            return "MOBILE"
        case .FIXED_LINE_OR_MOBILE:
            return "FIXED_LINE_OR_MOBILE"
        case .TOLL_FREE:
            return "TOLL_FREE"
        case .PREMIUM_RATE:
            return "PREMIUM_RATE"
        case .SHARED_COST:
            return "SHARED_COST"
        case  .VOIP:
            return "VOIP"
        case .PERSONAL_NUMBER:
            return "PERSONAL_NUMBER"
        case .PAGER:
            return "PAGER"
        case .UAN:
            return "UAN"
        case .VOICEMAIL:
            return "VOICEMAIL"
        case .UNKNOWN:
            return "UNKNOWN"
        }
    }
}

public func == (lhs: PhoneNumberType, rhs: PhoneNumberType) -> Bool {
    let result = lhs.rawValue == rhs.rawValue
    return result
}

public class PhoneNumberUtil {
    public static let REGION_CODE_FOR_NON_GEO_ENTITY = "001"
    public static let NANPA_COUNTRY_CODE = 1

    public class var DEFAULT_METADATA_LOADER:MetadataLoader {
        // TODO: should be implemented
        get {
            return MetadataLoader()
        }
    }

    var metaData:Array<Dictionary<String, AnyObject>> = []
    let countryCodeToRegionCodeMap:[Int:[String]]
    var countryCodesForNonGeographicalRegion:Set<Int> = Set<Int>()
    var supportedRegions:[String] = []
    var nanpaRegions:[String] = []

    public init(URL:NSURL, countryCodeToRegionCodeMap:[Int:[String]]) {
        if let metaData = NSArray(contentsOfURL: URL) as? Array<Dictionary<String, AnyObject>> {
            self.metaData = metaData;
        }
        self.countryCodeToRegionCodeMap = countryCodeToRegionCodeMap
        for (key:Int, value:[String]) in countryCodeToRegionCodeMap {
            if (value.count == 1 && PhoneNumberUtil.REGION_CODE_FOR_NON_GEO_ENTITY == value.first ) {
                self.countryCodesForNonGeographicalRegion.insert(key)
            } else {
                self.supportedRegions += value;
            }
        }
        if let founded = find(self.supportedRegions, PhoneNumberUtil.REGION_CODE_FOR_NON_GEO_ENTITY) {
            self.supportedRegions.removeAtIndex(founded)
            NSLog("invalid metadata (country calling code was mapped to the non-geo entity as well as specific region(s))");
        }

        if let founded = countryCodeToRegionCodeMap[PhoneNumberUtil.NANPA_COUNTRY_CODE] {
            self.nanpaRegions += founded
        }
    }

    public func loadMetadataFromFile(#filePrefix:String, regionCode:String, countryCallingCode:Int, metadataLoader:MetadataLoader, error:NSErrorPointer) {
        // TODO: should be implemented
        error.memory = NSError(domain: "", code: -1, userInfo:[NSLocalizedDescriptionKey:""])
    }

    // MARK: - Public instance APIs
    public func getSupportedRegions() -> [String] {
        return metaData.reduce([], combine: { (var result:[String], each) -> [String] in
            result.append(each["id"] as! String)
            return result
        })
    }
    public func getSupportedGlobalNetworkCallingCodes() -> [Int] {
        // TODO: should be implemented
        return []
    }
    public func getRegionCodeForCountryCode(callingCode:Int) -> String {
        // TODO: should be implemented
        return ""
    }
    public func getCountryCodeForRegion(countryCode:String) -> Int{
        // TODO: should be implemented
        return -1
    }
    public func getMetadataForRegion(regionCode:String) -> PhoneMetadata? {
        // TODO: should be implemented
        return PhoneMetadata()
    }
    public func getMetadataForNonGeographicalRegion(countryCallingCode:Int) -> PhoneMetadata? {
        // TODO: should be implemented
        return PhoneMetadata()
    }
    public func isNumberGeographical(phoneNumber:PhoneNumber) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func isLeadingZeroPossible(countryCallingCode:Int) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func getLengthOfGeographicalAreaCode(phoneNumber:PhoneNumber) -> Int {
        // TODO: should be implemented
        return -1
    }
    public func getLengthOfNationalDestinationCode(phoneNumber:PhoneNumber) -> Int {
        // TODO: should be implemented
        return -1
    }
    public func getNationalSignificantNumber(phoneNumber:PhoneNumber) -> String {
        // TODO: should be implemented
        return ""
    }
    public func getExampleNumber(regionCode:String) -> PhoneNumber? {
        // TODO: should be implemented
        return PhoneNumber()
    }
    public func getExampleNumberForType(regionCode:String, phoneNumberType:PhoneNumberType) -> PhoneNumber? {
        // TODO: should be implemented
        return PhoneNumber()
    }
    public func getExampleNumberForNonGeoEntity(countryCallingCode:Int) -> PhoneNumber {
        // TODO: should be implemented
        return PhoneNumber()
    }
    public func format(number:PhoneNumber, numberFormat:PhoneNumberFormat) -> String {
        // TODO: should be implemented
        return ""
    }
    public func formatOutOfCountryCallingNumber(number:PhoneNumber, regionCallingFrom:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public func formatOutOfCountryKeepingAlphaChars(number:PhoneNumber, regionCallingFrom:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public func formatNationalNumberWithCarrierCode(number:PhoneNumber, carrierCode:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public func formatNationalNumberWithPreferredCarrierCode(number:PhoneNumber, fallbackCarrierCode:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public func formatNumberForMobileDialing(number:PhoneNumber, regionCallingFrom:String, withFormatting:Bool) -> String {
        // TODO: should be implemented
        return ""
    }
    public func formatByPattern(number:PhoneNumber, numberFormat:PhoneNumberFormat, userDefinedFormats:[NumberFormat]) -> String {
        // TODO: should be implemented
        return ""
    }
    public func parseAndKeepRawInput(numberToParse:String, defaultRegion:String, error:NSErrorPointer) -> PhoneNumber {
        // TODO: should be implemented
        error.memory = NSError(domain: "", code: -1, userInfo:[NSLocalizedDescriptionKey:""])
        return PhoneNumber()
    }
    public func formatInOriginalFormat(number:PhoneNumber, regionCallingFrom:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public func parse(numberToParse:String, defaultRegion:String, error:NSErrorPointer) -> PhoneNumber {
        // TODO: should be implemented
        error.memory = NSError(domain: "", code: -1, userInfo:[NSLocalizedDescriptionKey:""])
        return PhoneNumber()
    }
    public func getNumberType(number:PhoneNumber) -> PhoneNumberType {
        // TODO: should be implemented
        return PhoneNumberType.UNKNOWN
    }
    public func isValidNumber(number:PhoneNumber) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func isValidNumberForRegion(number:PhoneNumber, regionCode:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func getRegionCodeForNumber(number:PhoneNumber) -> String {
        // TODO: should be implemented
        return ""
    }
    public func getRegionCodesForCountryCode(countryCallingCode:Int) -> [String] {
        // TODO: should be implemented
        return [""]
    }
    public func getNddPrefixForRegion(regionCode:String, stripNonDigits:Bool) -> String {
        // TODO: should be implemented
        return ""
    }
    public func isNANPACountry(regionCode:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func isPossibleNumber(number:PhoneNumber) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func isPossibleNumber(number:String, regionDialingFrom:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func isPossibleNumberWithReason(number:PhoneNumber) -> ValidationResult {
        // TODO: should be implemented
        return ValidationResult.TOO_SHORT
    }
    public func truncateTooLongNumber(number:PhoneNumber) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func maybeStripNationalPrefixAndCarrierCode(number:String, metadata:PhoneMetadata, carrierCode:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func maybeStripInternationalPrefixAndNormalize(number:String, possibleIddPrefix:String) -> CountryCodeSource {
        // TODO: should be implemented
        return CountryCodeSource.FROM_DEFAULT_COUNTRY
    }
    public func maybeExtractCountryCode(number:String, defaultRegionMetadata:PhoneMetadata, nationalNumber:String, keepRawInput:Bool, phoneNumber:PhoneNumber, error:NSErrorPointer) -> Int {
        // TODO: should be implemented
        error.memory = NSError(domain: "", code: -1, userInfo:[NSLocalizedDescriptionKey:""])
        return -1
    }
    public func isNumberMatch(firstString:String, secondString:String) -> MatchType {
        // TODO: should be implemented
        return MatchType.NOT_A_NUMBER
    }
    public func isNumberMatch(firstNumber:PhoneNumber, secondString:String) -> MatchType {
        // TODO: should be implemented
        return MatchType.NOT_A_NUMBER
    }
    public func isNumberMatch(firstNumber:PhoneNumber, secondNumber:PhoneNumber) -> MatchType {
        // TODO: should be implemented
        return MatchType.NOT_A_NUMBER
    }
    public func canBeInternationallyDialled(number:PhoneNumber) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func isAlphaNumber(number:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public func isMobileNumberPortableRegion(regionCode:String) -> Bool {
        // TODO: should be implemented
        return false
    }

    // MARK: - Class APIs

    public class func getCountryMobileToken(countryCode:Int) -> String {
        // TODO: should be implemented
        return ""
    }
    public class func convertAlphaCharactersInNumber(input:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public class func normalize(phoneNumberString:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public class func normalizeDigitsOnly(inputNumber:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public class func normalizeDiallableCharsOnly(inputNumber:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public class func isViablePhoneNumber(number:String) -> Bool {
        // TODO: should be implemented
        return false
    }
    public class func extractPossibleNumber(number:String) -> String {
        // TODO: should be implemented
        return ""
    }
    public class func nsNumberMatch(firstNumberIn:PhoneNumber, secondNumberIn:PhoneNumber) -> MatchType {
        // TODO: should be implemented
        return MatchType.NO_MATCH
    }
}
