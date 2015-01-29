//
//  PhoneNumberUtilTest.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 12/31/14.
//  Copyright (c) 2014 Hyuk Hur. All rights reserved.
//

import Foundation
import XCTest
import LibPhoneNumberSwift

let ALPHA_NUMERIC_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(80074935247)
let AE_UAN:PhoneNumber = PhoneNumber().setCountryCode(971).setNationalNumber(600123456)
let AR_MOBILE:PhoneNumber = PhoneNumber().setCountryCode(54).setNationalNumber(91187654321)
let AR_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(54).setNationalNumber(1187654321)
let AU_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(61).setNationalNumber(236618300)
let BS_MOBILE:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(2423570000)
let BS_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(2423651234)
// Note that this is the same as the example number for DE in the metadata.
let DE_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(49).setNationalNumber(30123456)
let DE_SHORT_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(49).setNationalNumber(1234)
let GB_MOBILE:PhoneNumber = PhoneNumber().setCountryCode(44).setNationalNumber(7912345678)
let GB_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(44).setNationalNumber(2070313000)
let IT_MOBILE:PhoneNumber = PhoneNumber().setCountryCode(39).setNationalNumber(345678901)
let IT_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(39).setNationalNumber(236618300).setItalianLeadingZero(true);
let JP_STAR_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(81).setNationalNumber(2345);
// Numbers to test the formatting rules from Mexico.
let MX_MOBILE1:PhoneNumber = PhoneNumber().setCountryCode(52).setNationalNumber(12345678900)
let MX_MOBILE2:PhoneNumber = PhoneNumber().setCountryCode(52).setNationalNumber(15512345678)
let MX_NUMBER1:PhoneNumber = PhoneNumber().setCountryCode(52).setNationalNumber(3312345678)
let MX_NUMBER2:PhoneNumber = PhoneNumber().setCountryCode(52).setNationalNumber(8211234567)
let NZ_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(64).setNationalNumber(33316005)
let SG_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(65).setNationalNumber(65218000)
// A too-long and hence invalid US number.
let US_LONG_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(65025300001)
let US_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(6502530000)
let US_PREMIUM:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(9002530000)
// Too short, but still possible US numbers.
let US_LOCAL_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(2530000)
let US_SHORT_BY_ONE_NUMBER:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(650253000)
let US_TOLLFREE:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(8002530000)
let US_SPOOF:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(0)
let US_SPOOF_WITH_RAW_INPUT:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(0).setRawInput("000-000-0000");
let INTERNATIONAL_TOLL_FREE:PhoneNumber = PhoneNumber().setCountryCode(800).setNationalNumber(12345678)
// We set this to be the same length as numbers for the other non-geographical country prefix that
// we have in our test metadata. However, this is not considered valid because they differ in
// their country calling code.
let INTERNATIONAL_TOLL_FREE_TOO_LONG:PhoneNumber = PhoneNumber().setCountryCode(800).setNationalNumber(123456789)
let UNIVERSAL_PREMIUM_RATE:PhoneNumber = PhoneNumber().setCountryCode(979).setNationalNumber(123456789)
let UNKNOWN_COUNTRY_CODE_NO_RAW_INPUT:PhoneNumber = PhoneNumber().setCountryCode(2).setNationalNumber(12345)

class PhoneNumberUtil_SwiftTests: XCTestCase {
    lazy var phoneUtil:PhoneNumberUtil = self.driver

    var driver:PhoneNumberUtil {
        if let plist = NSURL(fileURLWithPath:"metadata/PhoneNumberMetadataForTesting.plist")? {
            return PhoneNumberUtil(URL:plist)
        }
        return PhoneNumberUtil()
    }

    func testGetSupportedRegions() {
        XCTAssertTrue(phoneUtil.getSupportedRegions().count > 1, "\(phoneUtil.getSupportedRegions().count)")
    }

    func testGetSupportedGlobalNetworkCallingCodes() {
        let globalNetworkCallingCodes:[Int] = phoneUtil.getSupportedGlobalNetworkCallingCodes()
        XCTAssertTrue(globalNetworkCallingCodes.count > 0, "\(globalNetworkCallingCodes.count)")
        globalNetworkCallingCodes.map({(callingCode:Int) -> Void in
            XCTAssertTrue(callingCode > 0, "")
            XCTAssertEqual(RegionCode.UN001, self.phoneUtil.getRegionCodeForCountryCode(callingCode), "")
        })
    }

    func testGetInstanceLoadBadMetadata() {
        XCTAssertNil(phoneUtil.getMetadataForRegion("No Such Region"), "")
        XCTAssertNil(phoneUtil.getMetadataForNonGeographicalRegion(-1), "")
    }

    func testMissingMetadataFileThrowsRuntimeException() {
        // Exception is changed to NSError
        var error:NSError?
        phoneUtil.loadMetadataFromFile(filePrefix:"no/such/file", regionCode: "XX", countryCallingCode: -1, metadataLoader: PhoneNumberUtil.DEFAULT_METADATA_LOADER, error: &error)
        XCTAssertNotNil(error, "expected error")
        XCTAssertTrue(error?.description.rangeOfString("no/such/file_XX") != nil, "Unexpected error")

        phoneUtil.loadMetadataFromFile(filePrefix:"no/such/file", regionCode:PhoneNumberUtil.REGION_CODE_FOR_NON_GEO_ENTITY, countryCallingCode:123, metadataLoader:PhoneNumberUtil.DEFAULT_METADATA_LOADER, error:&error)
        XCTAssertNotNil(error, "expected error")
        XCTAssertTrue(error?.description.rangeOfString("no/such/file_123") != nil, "Unexpected error")
    }

    func testGetInstanceLoadUSMetadata() {
        let metadata:PhoneMetadata = phoneUtil.getMetadataForRegion(RegionCode.US)
        XCTAssertEqual("US", metadata.getId())
        XCTAssertEqual(1, metadata.getCountryCode())
        XCTAssertEqual("011", metadata.getInternationalPrefix())
        XCTAssertTrue(metadata.hasNationalPrefix())
        XCTAssertEqual(2, metadata.numberFormatSize())
        XCTAssertEqual("(\\d{3})(\\d{3})(\\d{4})", metadata.getNumberFormat(1).getPattern(), "")
        XCTAssertEqual("$1 $2 $3", metadata.getNumberFormat(1).getFormat(), "")
        XCTAssertEqual("[13-689]\\d{9}|2[0-35-9]\\d{8}", metadata.getGeneralDesc().getNationalNumberPattern())
        XCTAssertEqual("\\d{7}(?:\\d{3})?", metadata.getGeneralDesc().getPossibleNumberPattern())
        XCTAssertTrue(metadata.getGeneralDesc().exactlySameAs(metadata.getFixedLine()))
        XCTAssertEqual("\\d{10}", metadata.getTollFree().getPossibleNumberPattern())
        XCTAssertEqual("900\\d{7}", metadata.getPremiumRate().getNationalNumberPattern())
        // No shared-cost data is available, so it should be initialised to "NA".
        XCTAssertEqual("NA", metadata.getSharedCost().getNationalNumberPattern())
        XCTAssertEqual("NA", metadata.getSharedCost().getPossibleNumberPattern())
    }

    func testGetInstanceLoadDEMetadata() {
        let metadata:PhoneMetadata = phoneUtil.getMetadataForRegion(RegionCode.DE)
        XCTAssertEqual("DE", metadata.getId())
        XCTAssertEqual(49, metadata.getCountryCode())
        XCTAssertEqual("00", metadata.getInternationalPrefix())
        XCTAssertEqual("0", metadata.getNationalPrefix())
        XCTAssertEqual(6, metadata.numberFormatSize())
        XCTAssertEqual(1, metadata.getNumberFormat(5).leadingDigitsPatternSize())
        XCTAssertEqual("900", metadata.getNumberFormat(5).getLeadingDigitsPattern(0))
        XCTAssertEqual("(\\d{3})(\\d{3,4})(\\d{4})", metadata.getNumberFormat(5).getPattern())
        XCTAssertEqual("$1 $2 $3", metadata.getNumberFormat(5).getFormat())
        XCTAssertEqual("(?:[24-6]\\d{2}|3[03-9]\\d|[789](?:[1-9]\\d|0[2-9]))\\d{1,8}", metadata.getFixedLine().getNationalNumberPattern())
        XCTAssertEqual("\\d{2,14}", metadata.getFixedLine().getPossibleNumberPattern())
        XCTAssertEqual("30123456", metadata.getFixedLine().getExampleNumber())
        XCTAssertEqual("\\d{10}", metadata.getTollFree().getPossibleNumberPattern())
        XCTAssertEqual("900([135]\\d{6}|9\\d{7})", metadata.getPremiumRate().getNationalNumberPattern())
    }

    func testGetInstanceLoadARMetadata() {
        let metadata:PhoneMetadata = phoneUtil.getMetadataForRegion(RegionCode.AR)
        XCTAssertEqual("AR", metadata.getId())
        XCTAssertEqual(54, metadata.getCountryCode())
        XCTAssertEqual("00", metadata.getInternationalPrefix())
        XCTAssertEqual("0", metadata.getNationalPrefix())
        XCTAssertEqual("0(?:(11|343|3715)15)?", metadata.getNationalPrefixForParsing())
        XCTAssertEqual("9$1", metadata.getNationalPrefixTransformRule())
        XCTAssertEqual("$2 15 $3-$4", metadata.getNumberFormat(2).getFormat())
        XCTAssertEqual("(9)(\\d{4})(\\d{2})(\\d{4})",

        metadata.getNumberFormat(3).getPattern())
        XCTAssertEqual("(9)(\\d{4})(\\d{2})(\\d{4})",

        metadata.getIntlNumberFormat(3).getPattern())
        XCTAssertEqual("$1 $2 $3 $4", metadata.getIntlNumberFormat(3).getFormat())
    }

    func testGetInstanceLoadInternationalTollFreeMetadata() {
        let metadata:PhoneMetadata = phoneUtil.getMetadataForNonGeographicalRegion(800)
        XCTAssertEqual("001", metadata.getId())
        XCTAssertEqual(800, metadata.getCountryCode())
        XCTAssertEqual("$1 $2", metadata.getNumberFormat(0).getFormat())
        XCTAssertEqual("(\\d{4})(\\d{4})", metadata.getNumberFormat(0).getPattern())
        XCTAssertEqual("12345678", metadata.getGeneralDesc().getExampleNumber())
        XCTAssertEqual("12345678", metadata.getTollFree().getExampleNumber())
    }

    func testIsNumberGeographical() {
        XCTAssertFalse(phoneUtil.isNumberGeographical(BS_MOBILE))  // Bahamas, mobile phone number.
        XCTAssertTrue(phoneUtil.isNumberGeographical(AU_NUMBER))  // Australian fixed line number.
        XCTAssertFalse(phoneUtil.isNumberGeographical(INTERNATIONAL_TOLL_FREE))  // International toll free number.
    }

    func testIsLeadingZeroPossible() {
        XCTAssertTrue(phoneUtil.isLeadingZeroPossible(39))  // Italy
        XCTAssertFalse(phoneUtil.isLeadingZeroPossible(1))  // USA
        XCTAssertTrue(phoneUtil.isLeadingZeroPossible(800))  // International toll free
        XCTAssertFalse(phoneUtil.isLeadingZeroPossible(979))  // International premium-rate
        XCTAssertFalse(phoneUtil.isLeadingZeroPossible(888))  // Not in metadata file, just default to false.
    }

    func testGetLengthOfGeographicalAreaCode() {
        // Google MTV, which has area code "650".
        XCTAssertEqual(3, phoneUtil.getLengthOfGeographicalAreaCode(US_NUMBER))

        // A North America toll-free number, which has no area code.
        XCTAssertEqual(0, phoneUtil.getLengthOfGeographicalAreaCode(US_TOLLFREE))

        // Google London, which has area code "20".
        XCTAssertEqual(2, phoneUtil.getLengthOfGeographicalAreaCode(GB_NUMBER))

        // A UK mobile phone, which has no area code.
        XCTAssertEqual(0, phoneUtil.getLengthOfGeographicalAreaCode(GB_MOBILE))

        // Google Buenos Aires, which has area code "11".
        XCTAssertEqual(2, phoneUtil.getLengthOfGeographicalAreaCode(AR_NUMBER))

        // Google Sydney, which has area code "2".
        XCTAssertEqual(1, phoneUtil.getLengthOfGeographicalAreaCode(AU_NUMBER))

        // Italian numbers - there is no national prefix, but it still has an area code.
        XCTAssertEqual(2, phoneUtil.getLengthOfGeographicalAreaCode(IT_NUMBER))

        // Google Singapore. Singapore has no area code and no national prefix.
        XCTAssertEqual(0, phoneUtil.getLengthOfGeographicalAreaCode(SG_NUMBER))

        // An invalid US number (1 digit shorter), which has no area code.
        XCTAssertEqual(0, phoneUtil.getLengthOfGeographicalAreaCode(US_SHORT_BY_ONE_NUMBER))

        // An international toll free number, which has no area code.
        XCTAssertEqual(0, phoneUtil.getLengthOfGeographicalAreaCode(INTERNATIONAL_TOLL_FREE))
    }

    func testGetLengthOfNationalDestinationCode() {
        // Google MTV, which has national destination code (NDC) "650".
        XCTAssertEqual(3, phoneUtil.getLengthOfNationalDestinationCode(US_NUMBER))

        // A North America toll-free number, which has NDC "800".
        XCTAssertEqual(3, phoneUtil.getLengthOfNationalDestinationCode(US_TOLLFREE))

        // Google London, which has NDC "20".
        XCTAssertEqual(2, phoneUtil.getLengthOfNationalDestinationCode(GB_NUMBER))

        // A UK mobile phone, which has NDC "7912".
        XCTAssertEqual(4, phoneUtil.getLengthOfNationalDestinationCode(GB_MOBILE))

        // Google Buenos Aires, which has NDC "11".
        XCTAssertEqual(2, phoneUtil.getLengthOfNationalDestinationCode(AR_NUMBER))

        // An Argentinian mobile which has NDC "911".
        XCTAssertEqual(3, phoneUtil.getLengthOfNationalDestinationCode(AR_MOBILE))

        // Google Sydney, which has NDC "2".
        XCTAssertEqual(1, phoneUtil.getLengthOfNationalDestinationCode(AU_NUMBER))

        // Google Singapore, which has NDC "6521".
        XCTAssertEqual(4, phoneUtil.getLengthOfNationalDestinationCode(SG_NUMBER))

        // An invalid US number (1 digit shorter), which has no NDC.
        XCTAssertEqual(0, phoneUtil.getLengthOfNationalDestinationCode(US_SHORT_BY_ONE_NUMBER))

        // A number containing an invalid country calling code, which shouldn't have any NDC.
        let number:PhoneNumber = PhoneNumber().setCountryCode(123).setNationalNumber(6502530000)
        XCTAssertEqual(0, phoneUtil.getLengthOfNationalDestinationCode(number))

        // An international toll free number, which has NDC "1234".
        XCTAssertEqual(4, phoneUtil.getLengthOfNationalDestinationCode(INTERNATIONAL_TOLL_FREE))
    }

    func testGetCountryMobileToken() {
        XCTAssertEqual("1", PhoneNumberUtil.getCountryMobileToken(phoneUtil.getCountryCodeForRegion(
            RegionCode.MX)))

        // Country calling code for Sweden, which has no mobile token.
        XCTAssertEqual("", PhoneNumberUtil.getCountryMobileToken(phoneUtil.getCountryCodeForRegion(
            RegionCode.SE)))
    }

    func testGetNationalSignificantNumber() {
        XCTAssertEqual("6502530000", phoneUtil.getNationalSignificantNumber(US_NUMBER))

        // An Italian mobile number.
        XCTAssertEqual("345678901", phoneUtil.getNationalSignificantNumber(IT_MOBILE))

        // An Italian fixed line number.
        XCTAssertEqual("0236618300", phoneUtil.getNationalSignificantNumber(IT_NUMBER))

        XCTAssertEqual("12345678", phoneUtil.getNationalSignificantNumber(INTERNATIONAL_TOLL_FREE))
    }

    func testGetExampleNumber() {
        XCTAssertEqual(DE_NUMBER, phoneUtil.getExampleNumber(RegionCode.DE))

        XCTAssertEqual(DE_NUMBER,
            phoneUtil.getExampleNumberForType(RegionCode.DE,
                phoneNumberType: PhoneNumberUtil.PhoneNumberType.FIXED_LINE))
        XCTAssertNil(phoneUtil.getExampleNumberForType(RegionCode.DE,phoneNumberType: PhoneNumberUtil.PhoneNumberType.MOBILE))
        // For the US, the example number is placed under general description, and hence should be used
        // for both fixed line and mobile, so neither of these should return null.
        XCTAssertNotNil(phoneUtil.getExampleNumberForType(RegionCode.US, phoneNumberType: PhoneNumberUtil.PhoneNumberType.FIXED_LINE))
        XCTAssertNotNil(phoneUtil.getExampleNumberForType(RegionCode.US, phoneNumberType: PhoneNumberUtil.PhoneNumberType.MOBILE))
        // CS is an invalid region, so we have no data for it.
        XCTAssertNil(phoneUtil.getExampleNumberForType(RegionCode.CS, phoneNumberType:PhoneNumberUtil.PhoneNumberType.MOBILE))
        // RegionCode 001 is reserved for supporting non-geographical country calling code. We don't
        // support getting an example number for it with this method.
        XCTAssertNil(phoneUtil.getExampleNumber(RegionCode.UN001))
    }

}

class PhoneNumberUtil_JavascriptTests: PhoneNumberUtil_SwiftTests {
    override var driver:PhoneNumberUtil {
        return PhoneNumberUtilJavascript.getInstance()
    }
}
