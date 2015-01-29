//
//  PhoneNumberUtil.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 12/31/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

import Foundation


public class PhoneNumberUtil {
    public enum PhoneNumberType {
        case FIXED_LINE,
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
        UNKNOWN
    }
    public class var REGION_CODE_FOR_NON_GEO_ENTITY:String {
        // TODO: should be implemented
        get {
            return "001"
        }
    }

    public class var DEFAULT_METADATA_LOADER:MetadataLoader {
        // TODO: should be implemented
        get {
            return MetadataLoader()
        }
    }

    var metaData:Array<Dictionary<String, AnyObject>>
    public init() {
        self.metaData = [Dictionary()]
    }

    public convenience init(URL:NSURL) {
        self.init()
        if let metaData = NSArray(contentsOfURL: URL)? as? Array<Dictionary<String, AnyObject>> {
            self.metaData = metaData;
        }
    }

    public func loadMetadataFromFile(#filePrefix:String, regionCode:String, countryCallingCode:Int, metadataLoader:MetadataLoader, error:NSErrorPointer) {
        // TODO: should be implemented
    }

    // MARK: - APIs

    public func getSupportedRegions() -> [String] {
        return metaData.reduce([], combine: { (var result:[String], each) -> [String] in
            result.append(each["id"] as String)
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
        return -1
    }
    public func getMetadataForRegion(regionCode:String) -> PhoneMetadata {
        // TODO: should be implemented
        return PhoneMetadata()
    }
    public func getMetadataForNonGeographicalRegion(countryCallingCode:Int) -> PhoneMetadata {
        // TODO: should be implemented
        return PhoneMetadata()
    }
    public func isNumberGeographical(phoneNumber:PhoneNumber) -> Bool {
        return false
    }
    public func isLeadingZeroPossible(countryCallingCode:Int) -> Bool {
        return false
    }
    public func getLengthOfGeographicalAreaCode(phoneNumber:PhoneNumber) -> Int {
        return -1
    }
    public func getLengthOfNationalDestinationCode(phoneNumber:PhoneNumber) -> Int {
        return -1
    }
    public func getNationalSignificantNumber(phoneNumber:PhoneNumber) -> String {
        return ""
    }
    public func getExampleNumber(regionCode:String) -> PhoneNumber {
        return PhoneNumber()
    }
    public func getExampleNumberForType(regionCode:String, phoneNumberType:PhoneNumberType) -> PhoneNumber {
        return PhoneNumber()
    }
    public func getExampleNumberForNonGeoEntity(countryCallingCode:Int) -> PhoneNumber {
        return PhoneNumber()
    }


    // MARK: - Class APIs

    public class func getCountryMobileToken(countryCode:Int) -> String {
        return ""
    }
    public class func convertAlphaCharactersInNumber(input:String) -> String {
        return ""
    }
    public class func normalize(phoneNumberString:String) -> String {
        return ""
    }
    public class func normalizeDigitsOnly(inputNumber:String) -> String {
        return ""
    }

}