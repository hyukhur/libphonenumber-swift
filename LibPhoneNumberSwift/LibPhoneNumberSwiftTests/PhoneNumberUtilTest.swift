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

func getCountryCodeToRegionCodeMap() -> [Int:[String]] {
    var countryCodeToRegionCodeMap:[Int:[String]] = [1:["US", "BB", "BS", "CA"]]
    countryCodeToRegionCodeMap[33] = ["FR"]
    countryCodeToRegionCodeMap[36] = ["HU"]
    countryCodeToRegionCodeMap[39] = ["IT"]
    countryCodeToRegionCodeMap[44] = ["GB", "GG"]
    countryCodeToRegionCodeMap[48] = ["PL"]
    countryCodeToRegionCodeMap[49] = ["DE"]
    countryCodeToRegionCodeMap[52] = ["MX"]
    countryCodeToRegionCodeMap[54] = ["AR"]
    countryCodeToRegionCodeMap[55] = ["BR"]
    countryCodeToRegionCodeMap[61] = ["AU","CC","CX"]
    countryCodeToRegionCodeMap[64] = ["NZ"]
    countryCodeToRegionCodeMap[65] = ["SG"]
    countryCodeToRegionCodeMap[81] = ["JP"]
    countryCodeToRegionCodeMap[82] = ["KR"]
    countryCodeToRegionCodeMap[86] = ["CN"]
    countryCodeToRegionCodeMap[244] = ["AO"]
    countryCodeToRegionCodeMap[262] = ["RE","YT"]
    countryCodeToRegionCodeMap[375] = ["BY"]
    countryCodeToRegionCodeMap[376] = ["AD"]
    countryCodeToRegionCodeMap[800] = ["001"]
    countryCodeToRegionCodeMap[971] = ["AE"]
    countryCodeToRegionCodeMap[979] = ["001"]

    return countryCodeToRegionCodeMap;
}


class PhoneNumberUtil_SwiftTests: XCTestCase {
    
    lazy var phoneUtil:PhoneNumberUtil = self.driver

//    var driver:PhoneNumberUtil {
//        let plist = NSURL(fileURLWithPath:"metadata/PhoneNumberMetadataForTesting.plist")!
//        return PhoneNumberUtil(URL:plist, countryCodeToRegionCodeMap: getCountryCodeToRegionCodeMap())
//    }
    var driver:PhoneNumberUtil {
        return PhoneNumberUtilJavascript()
    }

    override func setUp() {
        phoneUtil = self.driver
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

//    func testMissingMetadataFileThrowsRuntimeException() {
//        // Exception is changed to NSError
//        var error:NSError?
//        phoneUtil.loadMetadataFromFile(filePrefix:"no/such/file", regionCode: "XX", countryCallingCode: -1, metadataLoader: PhoneNumberUtil.DEFAULT_METADATA_LOADER, error: &error)
//        XCTAssertNotNil(error, "expected error")
//        XCTAssertTrue(error?.description.rangeOfString("no/such/file_XX") != nil, "Unexpected error")
//
//        phoneUtil.loadMetadataFromFile(filePrefix:"no/such/file", regionCode:PhoneNumberUtil.REGION_CODE_FOR_NON_GEO_ENTITY, countryCallingCode:123, metadataLoader:PhoneNumberUtil.DEFAULT_METADATA_LOADER, error:&error)
//        XCTAssertNotNil(error, "expected error")
//        XCTAssertTrue(error?.description.rangeOfString("no/such/file_123") != nil, "Unexpected error")
//    }

    func testGetInstanceLoadUSMetadata() {
        let metadata:PhoneMetadata = phoneUtil.getMetadataForRegion(RegionCode.US)!
        XCTAssertNotNil(metadata, "metadata load fail")
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
        let metadata:PhoneMetadata = phoneUtil.getMetadataForRegion(RegionCode.DE)!
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
        let metadata:PhoneMetadata = phoneUtil.getMetadataForRegion(RegionCode.AR)!
        XCTAssertEqual("AR", metadata.getId())
        XCTAssertEqual(54, metadata.getCountryCode())
        XCTAssertEqual("00", metadata.getInternationalPrefix())
        XCTAssertEqual("0", metadata.getNationalPrefix())
        XCTAssertEqual("0(?:(11|343|3715)15)?", metadata.getNationalPrefixForParsing())
        XCTAssertEqual("9$1", metadata.getNationalPrefixTransformRule())
        XCTAssertEqual("$2 15 $3-$4", metadata.getNumberFormat(2).getFormat())
        XCTAssertEqual("(9)(\\d{4})(\\d{2})(\\d{4})", metadata.getNumberFormat(3).getPattern())
        XCTAssertEqual("(9)(\\d{4})(\\d{2})(\\d{4})", metadata.getIntlNumberFormat(3).getPattern())
        XCTAssertEqual("$1 $2 $3 $4", metadata.getIntlNumberFormat(3).getFormat())
    }

    func testGetInstanceLoadInternationalTollFreeMetadata() {
        let metadata:PhoneMetadata = phoneUtil.getMetadataForNonGeographicalRegion(800)!
        XCTAssertEqual("001", metadata.getId())
        XCTAssertEqual(800, metadata.getCountryCode())
        XCTAssertEqual("$1 $2", metadata.getNumberFormat(0).getFormat())
        XCTAssertEqual("(\\d{4})(\\d{4})", metadata.getNumberFormat(0).getPattern())
        XCTAssertEqual("12345678", metadata.getGeneralDesc().getExampleNumber())
        XCTAssertEqual("12345678", metadata.getTollFree().getExampleNumber())
    }

    func testIsNumberGeographical() {
        XCTAssertFalse(phoneUtil.isNumberGeographical(BS_MOBILE))                   // Bahamas, mobile phone number.
        XCTAssertTrue(phoneUtil.isNumberGeographical(AU_NUMBER))                    // Australian fixed line number.
        XCTAssertFalse(phoneUtil.isNumberGeographical(INTERNATIONAL_TOLL_FREE))     // International toll free number.
    }

    func testIsLeadingZeroPossible() {
        XCTAssertTrue(phoneUtil.isLeadingZeroPossible(39))      // Italy
        XCTAssertFalse(phoneUtil.isLeadingZeroPossible(1))      // USA
        XCTAssertTrue(phoneUtil.isLeadingZeroPossible(800))     // International toll free
        XCTAssertFalse(phoneUtil.isLeadingZeroPossible(979))    // International premium-rate
        XCTAssertFalse(phoneUtil.isLeadingZeroPossible(888))    // Not in metadata file, just default to false.
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
        XCTAssertEqual("1", phoneUtil.dynamicType.getCountryMobileToken(phoneUtil.getCountryCodeForRegion(RegionCode.MX)))

        // Country calling code for Sweden, which has no mobile token.
        XCTAssertEqual("", phoneUtil.dynamicType.getCountryMobileToken(phoneUtil.getCountryCodeForRegion(RegionCode.SE)))
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
        XCTAssertEqual(DE_NUMBER, phoneUtil.getExampleNumber(RegionCode.DE)!)

        XCTAssertEqual(DE_NUMBER, phoneUtil.getExampleNumberForType(RegionCode.DE, phoneNumberType: PhoneNumberType.FIXED_LINE)!)
        XCTAssertNil(phoneUtil.getExampleNumberForType(RegionCode.DE,phoneNumberType: PhoneNumberType.MOBILE))
        // For the US, the example number is placed under general description, and hence should be used
        // for both fixed line and mobile, so neither of these should return null.
        XCTAssertNotNil(phoneUtil.getExampleNumberForType(RegionCode.US, phoneNumberType: PhoneNumberType.FIXED_LINE))
        XCTAssertNotNil(phoneUtil.getExampleNumberForType(RegionCode.US, phoneNumberType: PhoneNumberType.MOBILE))
        // CS is an invalid region, so we have no data for it.
        XCTAssertNil(phoneUtil.getExampleNumberForType(RegionCode.CS, phoneNumberType:PhoneNumberType.MOBILE))
        // RegionCode 001 is reserved for supporting non-geographical country calling code. We don't
        // support getting an example number for it with this method.
        XCTAssertNil(phoneUtil.getExampleNumber(RegionCode.UN001))
    }
//
//    func testGetExampleNumberForNonGeoEntity() {
//        XCTAssertEqual(INTERNATIONAL_TOLL_FREE, phoneUtil.getExampleNumberForNonGeoEntity(800))
//        XCTAssertEqual(UNIVERSAL_PREMIUM_RATE, phoneUtil.getExampleNumberForNonGeoEntity(979))
//    }
//
//    func testConvertAlphaCharactersInNumber() {
//        let input = "1800-ABC-DEF"
//        // Alpha chars are converted to digits everything else is left untouched.
//        let expectedOutput = "1800-222-333"
//        XCTAssertEqual(expectedOutput, PhoneNumberUtil.convertAlphaCharactersInNumber(input))
//    }
//
//    func testNormaliseRemovePunctuation() {
//        let inputNumber:String = "034-56&+#2\\u00AD34"
//        let expectedOutput:String = "03456234"
//        XCTAssertEqual(expectedOutput, PhoneNumberUtil.normalize(inputNumber), "Conversion did not correctly remove punctuation")
//    }
//
//    func testNormaliseReplaceAlphaCharacters() {
//        let inputNumber = "034-I-am-HUNGRY"
//        let expectedOutput = "034426486479"
//        XCTAssertEqual(expectedOutput, PhoneNumberUtil.normalize(inputNumber), "Conversion did not correctly replace alpha characters")
//    }
//
//    func testNormaliseOtherDigits() {
//        var inputNumber = "\\uFF125\\u0665"
//        var expectedOutput = "255"
//        XCTAssertEqual(expectedOutput, PhoneNumberUtil.normalize(inputNumber), "Conversion did not correctly replace non-latin digits")
//        // Eastern-Arabic digits.
//        inputNumber = "\\u06F52\\u06F0"
//        expectedOutput = "520"
//        XCTAssertEqual(expectedOutput, PhoneNumberUtil.normalize(inputNumber), "Conversion did not correctly replace non-latin digits")
//    }
//
//    func testNormaliseStripAlphaCharacters() {
//        let inputNumber = "034-56&+a#234"
//        let expectedOutput = "03456234"
//        XCTAssertEqual(expectedOutput, PhoneNumberUtil.normalizeDigitsOnly(inputNumber), "Conversion did not correctly remove alpha character")
//    }
//
//    func testNormaliseStripNonDiallableCharacters() {
//        let inputNumber = "03*4-56&+a#234"
//        let expectedOutput = "03*456+234"
//        XCTAssertEqual(expectedOutput, PhoneNumberUtil.normalizeDiallableCharsOnly(inputNumber), "Conversion did not correctly remove non-diallable characters")
//    }
//
//    func testFormatUSNumber() {
//        XCTAssertEqual("650 253 0000", phoneUtil.format(US_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+1 650 253 0000", phoneUtil.format(US_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//
//        XCTAssertEqual("800 253 0000", phoneUtil.format(US_TOLLFREE, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+1 800 253 0000", phoneUtil.format(US_TOLLFREE, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//
//        XCTAssertEqual("900 253 0000", phoneUtil.format(US_PREMIUM, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+1 900 253 0000", phoneUtil.format(US_PREMIUM, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("tel:+1-900-253-0000", phoneUtil.format(US_PREMIUM, numberFormat:PhoneNumberFormat.RFC3966))
//        // Numbers with all zeros in the national number part will be formatted by using the raw_input
//        // if that is available no matter which format is specified.
//        XCTAssertEqual("000-000-0000", phoneUtil.format(US_SPOOF_WITH_RAW_INPUT, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("0", phoneUtil.format(US_SPOOF, numberFormat:PhoneNumberFormat.NATIONAL))
//    }
//
//    func testFormatBSNumber() {
//        XCTAssertEqual("242 365 1234", phoneUtil.format(BS_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+1 242 365 1234", phoneUtil.format(BS_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//    }
//
//    func testFormatGBNumber() {
//        XCTAssertEqual("(020) 7031 3000", phoneUtil.format(GB_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+44 20 7031 3000", phoneUtil.format(GB_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//
//        XCTAssertEqual("(07912) 345 678", phoneUtil.format(GB_MOBILE, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+44 7912 345 678", phoneUtil.format(GB_MOBILE, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//    }
//
//    func testFormatDENumber() {
//        let deNumber:PhoneNumber = PhoneNumber()
//        deNumber.setCountryCode(49).setNationalNumber(301234)
//        XCTAssertEqual("030/1234", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+49 30/1234", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("tel:+49-30-1234", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.RFC3966))
//
//        deNumber.clear()
//        deNumber.setCountryCode(49).setNationalNumber(291123)
//        XCTAssertEqual("0291 123", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+49 291 123", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//
//        deNumber.clear()
//        deNumber.setCountryCode(49).setNationalNumber(29112345678)
//        XCTAssertEqual("0291 12345678", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+49 291 12345678", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//
//        deNumber.clear()
//        deNumber.setCountryCode(49).setNationalNumber(912312345)
//        XCTAssertEqual("09123 12345", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+49 9123 12345", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        deNumber.clear()
//        deNumber.setCountryCode(49).setNationalNumber(80212345)
//        XCTAssertEqual("08021 2345", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+49 8021 2345", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        // Note this number is correctly formatted without national prefix. Most of the numbers that
//        // are treated as invalid numbers by the library are short numbers, and they are usually not
//        // dialed with national prefix.
//        XCTAssertEqual("1234", phoneUtil.format(DE_SHORT_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+49 1234", phoneUtil.format(DE_SHORT_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//
//        deNumber.clear()
//        deNumber.setCountryCode(49).setNationalNumber(41341234)
//        XCTAssertEqual("04134 1234", phoneUtil.format(deNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//    }
//
//    func testFormatITNumber() {
//        XCTAssertEqual("02 3661 8300", phoneUtil.format(IT_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+39 02 3661 8300", phoneUtil.format(IT_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+390236618300", phoneUtil.format(IT_NUMBER, numberFormat:PhoneNumberFormat.E164))
//
//        XCTAssertEqual("345 678 901", phoneUtil.format(IT_MOBILE, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+39 345 678 901", phoneUtil.format(IT_MOBILE, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+39345678901", phoneUtil.format(IT_MOBILE, numberFormat:PhoneNumberFormat.E164))
//    }
//
//    func testFormatAUNumber() {
//        XCTAssertEqual("02 3661 8300", phoneUtil.format(AU_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+61 2 3661 8300", phoneUtil.format(AU_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+61236618300", phoneUtil.format(AU_NUMBER, numberFormat:PhoneNumberFormat.E164))
//
//        let auNumber:PhoneNumber = PhoneNumber().setCountryCode(61).setNationalNumber(1800123456)
//        XCTAssertEqual("1800 123 456", phoneUtil.format(auNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+61 1800 123 456", phoneUtil.format(auNumber, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+611800123456", phoneUtil.format(auNumber, numberFormat:PhoneNumberFormat.E164))
//    }
//
//    func testFormatARNumber() {
//        XCTAssertEqual("011 8765-4321", phoneUtil.format(AR_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+54 11 8765-4321", phoneUtil.format(AR_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+541187654321", phoneUtil.format(AR_NUMBER, numberFormat:PhoneNumberFormat.E164))
//
//        XCTAssertEqual("011 15 8765-4321", phoneUtil.format(AR_MOBILE, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+54 9 11 8765 4321", phoneUtil.format(AR_MOBILE, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+5491187654321", phoneUtil.format(AR_MOBILE, numberFormat:PhoneNumberFormat.E164))
//    }
//
//    func testFormatMXNumber() {
//        XCTAssertEqual("045 234 567 8900", phoneUtil.format(MX_MOBILE1, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+52 1 234 567 8900", phoneUtil.format(MX_MOBILE1, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+5212345678900", phoneUtil.format(MX_MOBILE1, numberFormat:PhoneNumberFormat.E164))
//
//        XCTAssertEqual("045 55 1234 5678", phoneUtil.format(MX_MOBILE2, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+52 1 55 1234 5678", phoneUtil.format(MX_MOBILE2, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+5215512345678", phoneUtil.format(MX_MOBILE2, numberFormat:PhoneNumberFormat.E164))
//
//        XCTAssertEqual("01 33 1234 5678", phoneUtil.format(MX_NUMBER1, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+52 33 1234 5678", phoneUtil.format(MX_NUMBER1, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+523312345678", phoneUtil.format(MX_NUMBER1, numberFormat:PhoneNumberFormat.E164))
//
//        XCTAssertEqual("01 821 123 4567", phoneUtil.format(MX_NUMBER2, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("+52 821 123 4567", phoneUtil.format(MX_NUMBER2, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+528211234567", phoneUtil.format(MX_NUMBER2, numberFormat:PhoneNumberFormat.E164))
//    }
//
//    func testFormatOutOfCountryCallingNumber() {
//        XCTAssertEqual("00 1 900 253 0000", phoneUtil.formatOutOfCountryCallingNumber(US_PREMIUM, regionCallingFrom:RegionCode.DE))
//
//        XCTAssertEqual("1 650 253 0000", phoneUtil.formatOutOfCountryCallingNumber(US_NUMBER, regionCallingFrom:RegionCode.BS))
//
//        XCTAssertEqual("00 1 650 253 0000", phoneUtil.formatOutOfCountryCallingNumber(US_NUMBER, regionCallingFrom:RegionCode.PL))
//
//        XCTAssertEqual("011 44 7912 345 678", phoneUtil.formatOutOfCountryCallingNumber(GB_MOBILE, regionCallingFrom:RegionCode.US))
//
//        XCTAssertEqual("00 49 1234", phoneUtil.formatOutOfCountryCallingNumber(DE_SHORT_NUMBER, regionCallingFrom:RegionCode.GB))
//        // Note this number is correctly formatted without national prefix. Most of the numbers that
//        // are treated as invalid numbers by the library are short numbers, and they are usually not
//        // dialed with national prefix.
//        XCTAssertEqual("1234", phoneUtil.formatOutOfCountryCallingNumber(DE_SHORT_NUMBER, regionCallingFrom:RegionCode.DE))
//
//        XCTAssertEqual("011 39 02 3661 8300", phoneUtil.formatOutOfCountryCallingNumber(IT_NUMBER, regionCallingFrom:RegionCode.US))
//        XCTAssertEqual("02 3661 8300", phoneUtil.formatOutOfCountryCallingNumber(IT_NUMBER, regionCallingFrom:RegionCode.IT))
//        XCTAssertEqual("+39 02 3661 8300", phoneUtil.formatOutOfCountryCallingNumber(IT_NUMBER, regionCallingFrom:RegionCode.SG))
//
//        XCTAssertEqual("6521 8000", phoneUtil.formatOutOfCountryCallingNumber(SG_NUMBER, regionCallingFrom:RegionCode.SG))
//
//        XCTAssertEqual("011 54 9 11 8765 4321", phoneUtil.formatOutOfCountryCallingNumber(AR_MOBILE, regionCallingFrom:RegionCode.US))
//        XCTAssertEqual("011 800 1234 5678", phoneUtil.formatOutOfCountryCallingNumber(INTERNATIONAL_TOLL_FREE, regionCallingFrom:RegionCode.US))
//
//        let arNumberWithExtn:PhoneNumber = PhoneNumber().mergeFrom(AR_MOBILE).setExtension("1234")
//        XCTAssertEqual("011 54 9 11 8765 4321 ext. 1234", phoneUtil.formatOutOfCountryCallingNumber(arNumberWithExtn, regionCallingFrom:RegionCode.US))
//        XCTAssertEqual("0011 54 9 11 8765 4321 ext. 1234", phoneUtil.formatOutOfCountryCallingNumber(arNumberWithExtn, regionCallingFrom:RegionCode.AU))
//        XCTAssertEqual("011 15 8765-4321 ext. 1234", phoneUtil.formatOutOfCountryCallingNumber(arNumberWithExtn, regionCallingFrom:RegionCode.AR))
//    }
//
//    func testFormatOutOfCountryWithInvalidRegion() {
//        // AQ/Antarctica isn't a valid region code for phone number formatting,
//        // so this falls back to intl formatting.
//        XCTAssertEqual("+1 650 253 0000", phoneUtil.formatOutOfCountryCallingNumber(US_NUMBER, regionCallingFrom:RegionCode.AQ))
//        // For region code 001, the out-of-country format always turns into the international format.
//        XCTAssertEqual("+1 650 253 0000", phoneUtil.formatOutOfCountryCallingNumber(US_NUMBER, regionCallingFrom:RegionCode.UN001))
//    }
//
//    func testFormatOutOfCountryWithPreferredIntlPrefix() {
//        // This should use 0011, since that is the preferred international prefix (both 0011 and 0012
//        // are accepted as possible international prefixes in our test metadta.)
//        XCTAssertEqual("0011 39 02 3661 8300", phoneUtil.formatOutOfCountryCallingNumber(IT_NUMBER, regionCallingFrom:RegionCode.AU))
//    }
//
//    func testFormatOutOfCountryKeepingAlphaChars() {
//        let alphaNumericNumber:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(8007493524).setRawInput("1800 six-flag")
//        XCTAssertEqual("0011 1 800 SIX-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.AU))
//
//        alphaNumericNumber.setRawInput("1-800-SIX-flag")
//        XCTAssertEqual("0011 1 800-SIX-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.AU))
//
//        alphaNumericNumber.setRawInput("Call us from UK: 00 1 800 SIX-flag")
//        XCTAssertEqual("0011 1 800 SIX-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.AU))
//
//        alphaNumericNumber.setRawInput("800 SIX-flag")
//        XCTAssertEqual("0011 1 800 SIX-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.AU))
//
//        // Formatting from within the NANPA region.
//        XCTAssertEqual("1 800 SIX-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.US))
//
//        XCTAssertEqual("1 800 SIX-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.BS))
//
//        // Testing that if the raw input doesn't exist, it is formatted using
//        // formatOutOfCountryCallingNumber.
//        alphaNumericNumber.clearRawInput()
//        XCTAssertEqual("00 1 800 749 3524", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.DE))
//
//        // Testing AU alpha number formatted from Australia.
//        alphaNumericNumber.setCountryCode(61).setNationalNumber(827493524).setRawInput("+61 82749-FLAG")
//        // This number should have the national prefix fixed.
//        XCTAssertEqual("082749-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.AU))
//
//        alphaNumericNumber.setRawInput("082749-FLAG")
//        XCTAssertEqual("082749-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.AU))
//
//        alphaNumericNumber.setNationalNumber(18007493524).setRawInput("1-800-SIX-flag")
//        // This number should not have the national prefix prefixed, in accordance with the override for
//        // this specific formatting rule.
//        XCTAssertEqual("1-800-SIX-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.AU))
//
//        // The metadata should not be permanently changed, since we copied it before modifying patterns.
//        // Here we check this.
//        alphaNumericNumber.setNationalNumber(1800749352)
//        XCTAssertEqual("1800 749 352", phoneUtil.formatOutOfCountryCallingNumber(alphaNumericNumber, regionCallingFrom:RegionCode.AU))
//
//        // Testing a region with multiple international prefixes.
//        XCTAssertEqual("+61 1-800-SIX-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.SG))
//        // Testing the case of calling from a non-supported region.
//        XCTAssertEqual("+61 1-800-SIX-FLAG", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.AQ))
//
//        // Testing the case with an invalid country calling code.
//        alphaNumericNumber.setCountryCode(0).setNationalNumber(18007493524).setRawInput("1-800-SIX-flag")
//        // Uses the raw input only.
//        XCTAssertEqual("1-800-SIX-flag", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.DE))
//
//        // Testing the case of an invalid alpha number.
//        alphaNumericNumber.setCountryCode(1).setNationalNumber(80749).setRawInput("180-SIX")
//        // No country-code stripping can be done.
//        XCTAssertEqual("00 1 180-SIX", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.DE))
//
//        // Testing the case of calling from a non-supported region.
//        alphaNumericNumber.setCountryCode(1).setNationalNumber(80749).setRawInput("180-SIX")
//        // No country-code stripping can be done since the number is invalid.
//        XCTAssertEqual("+1 180-SIX", phoneUtil.formatOutOfCountryKeepingAlphaChars(alphaNumericNumber, regionCallingFrom:RegionCode.AQ))
//    }
//
//    func testFormatWithCarrierCode() {
//        // We only support this for AR in our test metadata, and only for mobile numbers starting with
//        // certain values.
//        let arMobile:PhoneNumber = PhoneNumber().setCountryCode(54).setNationalNumber(92234654321)
//        XCTAssertEqual("02234 65-4321", phoneUtil.format(arMobile, numberFormat:PhoneNumberFormat.NATIONAL))
//        // Here we force 14 as the carrier code.
//        XCTAssertEqual("02234 14 65-4321", phoneUtil.formatNationalNumberWithCarrierCode(arMobile, carrierCode:"14"))
//        // Here we force the number to be shown with no carrier code.
//        XCTAssertEqual("02234 65-4321", phoneUtil.formatNationalNumberWithCarrierCode(arMobile, carrierCode:""))
//        // Here the international rule is used, so no carrier code should be present.
//        XCTAssertEqual("+5492234654321", phoneUtil.format(arMobile, numberFormat:PhoneNumberFormat.E164))
//        // We don't support this for the US so there should be no change.
//        XCTAssertEqual("650 253 0000", phoneUtil.formatNationalNumberWithCarrierCode(US_NUMBER, carrierCode:"15"))
//
//        // Invalid country code should just get the NSN.
//        XCTAssertEqual("12345", phoneUtil.formatNationalNumberWithCarrierCode(UNKNOWN_COUNTRY_CODE_NO_RAW_INPUT, carrierCode:"89"))
//    }
//
//    func testFormatWithPreferredCarrierCode() {
//        // We only support this for AR in our test metadata.
//        let arNumber:PhoneNumber = PhoneNumber()
//        arNumber.setCountryCode(54).setNationalNumber(91234125678)
//        // Test formatting with no preferred carrier code stored in the number itself.
//        XCTAssertEqual("01234 15 12-5678", phoneUtil.formatNationalNumberWithPreferredCarrierCode(arNumber, fallbackCarrierCode:"15"))
//        XCTAssertEqual("01234 12-5678", phoneUtil.formatNationalNumberWithPreferredCarrierCode(arNumber, fallbackCarrierCode:""))
//        // Test formatting with preferred carrier code present.
//        arNumber.setPreferredDomesticCarrierCode("19")
//        XCTAssertEqual("01234 12-5678", phoneUtil.format(arNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("01234 19 12-5678", phoneUtil.formatNationalNumberWithPreferredCarrierCode(arNumber, fallbackCarrierCode:"15"))
//        XCTAssertEqual("01234 19 12-5678", phoneUtil.formatNationalNumberWithPreferredCarrierCode(arNumber, fallbackCarrierCode:""))
//        // When the preferred_domestic_carrier_code is present (even when it contains an empty string),
//        // use it instead of the default carrier code passed in.
//        arNumber.setPreferredDomesticCarrierCode("")
//        XCTAssertEqual("01234 12-5678", phoneUtil.formatNationalNumberWithPreferredCarrierCode(arNumber, fallbackCarrierCode:"15"))
//        // We don't support this for the US so there should be no change.
//        let usNumber:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(4241231234).setPreferredDomesticCarrierCode("99")
//        XCTAssertEqual("424 123 1234", phoneUtil.format(usNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual("424 123 1234", phoneUtil.formatNationalNumberWithPreferredCarrierCode(usNumber, fallbackCarrierCode:"15"))
//    }
//
//    func testFormatNumberForMobileDialing() {
//        // Numbers are normally dialed in national format in-country, and international format from
//        // outside the country.
//        XCTAssertEqual("030123456", phoneUtil.formatNumberForMobileDialing(DE_NUMBER, regionCallingFrom:RegionCode.DE, withFormatting:false))
//        XCTAssertEqual("+4930123456", phoneUtil.formatNumberForMobileDialing(DE_NUMBER, regionCallingFrom:RegionCode.CH, withFormatting:false))
//        let deNumberWithExtn:PhoneNumber = PhoneNumber().mergeFrom(DE_NUMBER).setExtension("1234")
//        XCTAssertEqual("030123456", phoneUtil.formatNumberForMobileDialing(deNumberWithExtn, regionCallingFrom:RegionCode.DE, withFormatting:false))
//        XCTAssertEqual("+4930123456", phoneUtil.formatNumberForMobileDialing(deNumberWithExtn, regionCallingFrom:RegionCode.CH, withFormatting:false))
//
//        // US toll free numbers are marked as noInternationalDialling in the test metadata for testing
//        // purposes. For such numbers, we expect nothing to be returned when the region code is not the
//        // same one.
//        XCTAssertEqual("800 253 0000", phoneUtil.formatNumberForMobileDialing(US_TOLLFREE, regionCallingFrom:RegionCode.US, withFormatting:true /*  keep formatting */))
//        XCTAssertEqual("", phoneUtil.formatNumberForMobileDialing(US_TOLLFREE, regionCallingFrom:RegionCode.CN, withFormatting:true))
//        XCTAssertEqual("+1 650 253 0000", phoneUtil.formatNumberForMobileDialing(US_NUMBER, regionCallingFrom:RegionCode.US, withFormatting:true))
//        let usNumberWithExtn:PhoneNumber = PhoneNumber().mergeFrom(US_NUMBER).setExtension("1234")
//        XCTAssertEqual("+1 650 253 0000", phoneUtil.formatNumberForMobileDialing(usNumberWithExtn, regionCallingFrom:RegionCode.US, withFormatting:true))
//
//        XCTAssertEqual("8002530000", phoneUtil.formatNumberForMobileDialing(US_TOLLFREE, regionCallingFrom:RegionCode.US, withFormatting:false /* remove formatting */))
//        XCTAssertEqual("", phoneUtil.formatNumberForMobileDialing(US_TOLLFREE, regionCallingFrom:RegionCode.CN, withFormatting:false))
//        XCTAssertEqual("+16502530000", phoneUtil.formatNumberForMobileDialing(US_NUMBER, regionCallingFrom:RegionCode.US, withFormatting:false))
//        XCTAssertEqual("+16502530000", phoneUtil.formatNumberForMobileDialing(usNumberWithExtn, regionCallingFrom:RegionCode.US, withFormatting:false))
//
//        // An invalid US number, which is one digit too long.
//        XCTAssertEqual("+165025300001", phoneUtil.formatNumberForMobileDialing(US_LONG_NUMBER, regionCallingFrom:RegionCode.US, withFormatting:false))
//        XCTAssertEqual("+1 65025300001", phoneUtil.formatNumberForMobileDialing(US_LONG_NUMBER, regionCallingFrom:RegionCode.US, withFormatting:true))
//
//        // Star numbers. In real life they appear in Israel, but we have them in JP in our test
//        // metadata.
//        XCTAssertEqual("*2345", phoneUtil.formatNumberForMobileDialing(JP_STAR_NUMBER, regionCallingFrom:RegionCode.JP, withFormatting:false))
//        XCTAssertEqual("*2345", phoneUtil.formatNumberForMobileDialing(JP_STAR_NUMBER, regionCallingFrom:RegionCode.JP, withFormatting:true))
//
//        XCTAssertEqual("+80012345678", phoneUtil.formatNumberForMobileDialing(INTERNATIONAL_TOLL_FREE, regionCallingFrom:RegionCode.JP, withFormatting:false))
//        XCTAssertEqual("+800 1234 5678", phoneUtil.formatNumberForMobileDialing(INTERNATIONAL_TOLL_FREE, regionCallingFrom:RegionCode.JP, withFormatting:true))
//
//        // UAE numbers beginning with 600 (classified as UAN) need to be dialled without +971 locally.
//        XCTAssertEqual("+971600123456", phoneUtil.formatNumberForMobileDialing(AE_UAN, regionCallingFrom:RegionCode.JP, withFormatting:false))
//        XCTAssertEqual("600123456", phoneUtil.formatNumberForMobileDialing(AE_UAN, regionCallingFrom:RegionCode.AE, withFormatting:false))
//
//        XCTAssertEqual("+523312345678", phoneUtil.formatNumberForMobileDialing(MX_NUMBER1, regionCallingFrom:RegionCode.MX, withFormatting:false))
//        XCTAssertEqual("+523312345678", phoneUtil.formatNumberForMobileDialing(MX_NUMBER1, regionCallingFrom:RegionCode.US, withFormatting:false))
//
//        // Non-geographical numbers should always be dialed in international format.
//        XCTAssertEqual("+80012345678", phoneUtil.formatNumberForMobileDialing(INTERNATIONAL_TOLL_FREE, regionCallingFrom:RegionCode.US, withFormatting:false))
//        XCTAssertEqual("+80012345678", phoneUtil.formatNumberForMobileDialing(INTERNATIONAL_TOLL_FREE, regionCallingFrom:RegionCode.UN001, withFormatting:false))
//
//        // Test that a short number is formatted correctly for mobile dialing within the region,
//        // and is not diallable from outside the region.
//        let deShortNumber:PhoneNumber = PhoneNumber().setCountryCode(49).setNationalNumber(123)
//        XCTAssertEqual("123", phoneUtil.formatNumberForMobileDialing(deShortNumber, regionCallingFrom:RegionCode.DE, withFormatting:false))
//        XCTAssertEqual("", phoneUtil.formatNumberForMobileDialing(deShortNumber, regionCallingFrom:RegionCode.IT, withFormatting:false))
//
//        // Test the special logic for Hungary, where the national prefix must be added before dialing
//        // from a mobile phone for regular length numbers, but not for short numbers.
//        let huRegularNumber:PhoneNumber = PhoneNumber().setCountryCode(36).setNationalNumber(301234567)
//        XCTAssertEqual("06301234567", phoneUtil.formatNumberForMobileDialing(huRegularNumber, regionCallingFrom:RegionCode.HU, withFormatting:false))
//        XCTAssertEqual("+36301234567", phoneUtil.formatNumberForMobileDialing(huRegularNumber, regionCallingFrom:RegionCode.JP, withFormatting:false))
//        let huShortNumber:PhoneNumber = PhoneNumber().setCountryCode(36).setNationalNumber(104)
//        XCTAssertEqual("104", phoneUtil.formatNumberForMobileDialing(huShortNumber, regionCallingFrom:RegionCode.HU, withFormatting:false))
//        XCTAssertEqual("", phoneUtil.formatNumberForMobileDialing(huShortNumber, regionCallingFrom:RegionCode.JP, withFormatting:false))
//
//        // Test the special logic for NANPA countries, for which regular length phone numbers are always
//        // output in international format, but short numbers are in national format.
//        XCTAssertEqual("+16502530000", phoneUtil.formatNumberForMobileDialing(US_NUMBER, regionCallingFrom:RegionCode.US, withFormatting:false))
//        XCTAssertEqual("+16502530000", phoneUtil.formatNumberForMobileDialing(US_NUMBER, regionCallingFrom:RegionCode.CA, withFormatting:false))
//        XCTAssertEqual("+16502530000", phoneUtil.formatNumberForMobileDialing(US_NUMBER, regionCallingFrom:RegionCode.BR, withFormatting:false))
//        let usShortNumber:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(911)
//        XCTAssertEqual("911", phoneUtil.formatNumberForMobileDialing(usShortNumber, regionCallingFrom:RegionCode.US, withFormatting:false))
//        XCTAssertEqual("", phoneUtil.formatNumberForMobileDialing(usShortNumber, regionCallingFrom:RegionCode.CA, withFormatting:false))
//        XCTAssertEqual("", phoneUtil.formatNumberForMobileDialing(usShortNumber, regionCallingFrom:RegionCode.BR, withFormatting:false))
//
//        // Test that the Australian emergency number 000 is formatted correctly.
//        let auNumber:PhoneNumber = PhoneNumber().setCountryCode(61).setNationalNumber(0).setItalianLeadingZero(true).setNumberOfLeadingZeros(2)
//        XCTAssertEqual("000", phoneUtil.formatNumberForMobileDialing(auNumber, regionCallingFrom:RegionCode.AU, withFormatting:false))
//        XCTAssertEqual("", phoneUtil.formatNumberForMobileDialing(auNumber, regionCallingFrom:RegionCode.NZ, withFormatting:false))
//    }
//
//    func testFormatByPattern() {
//        let newNumFormat:NumberFormat = NumberFormat()
//        newNumFormat.setPattern("(\\d{3})(\\d{3})(\\d{4})")
//        newNumFormat.setFormat("($1) $2-$3")
//        var newNumberFormats:[NumberFormat] = []
//        newNumberFormats.append(newNumFormat)
//
//        XCTAssertEqual("(650) 253-0000", phoneUtil.formatByPattern(US_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL, userDefinedFormats:newNumberFormats))
//        XCTAssertEqual("+1 (650) 253-0000", phoneUtil.formatByPattern(US_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL, userDefinedFormats:newNumberFormats))
//        XCTAssertEqual("tel:+1-650-253-0000", phoneUtil.formatByPattern(US_NUMBER, numberFormat:PhoneNumberFormat.RFC3966, userDefinedFormats:newNumberFormats))
//
//        // $NP is set to '1' for the US. Here we check that for other NANPA countries the US rules are
//        // followed.
//        newNumFormat.setNationalPrefixFormattingRule("$NP ($FG)")
//        newNumFormat.setFormat("$1 $2-$3")
//        XCTAssertEqual("1 (242) 365-1234", phoneUtil.formatByPattern(BS_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL, userDefinedFormats:newNumberFormats))
//        XCTAssertEqual("+1 242 365-1234", phoneUtil.formatByPattern(BS_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL, userDefinedFormats:newNumberFormats))
//
//        newNumFormat.setPattern("(\\d{2})(\\d{5})(\\d{3})")
//        newNumFormat.setFormat("$1-$2 $3")
//        newNumberFormats[0] = newNumFormat
//
//        XCTAssertEqual("02-36618 300", phoneUtil.formatByPattern(IT_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL, userDefinedFormats:newNumberFormats))
//        XCTAssertEqual("+39 02-36618 300", phoneUtil.formatByPattern(IT_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL, userDefinedFormats:newNumberFormats))
//
//        newNumFormat.setNationalPrefixFormattingRule("$NP$FG")
//        newNumFormat.setPattern("(\\d{2})(\\d{4})(\\d{4})")
//        newNumFormat.setFormat("$1 $2 $3")
//        newNumberFormats[0] = newNumFormat
//        XCTAssertEqual("020 7031 3000", phoneUtil.formatByPattern(GB_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL, userDefinedFormats:newNumberFormats))
//
//        newNumFormat.setNationalPrefixFormattingRule("($NP$FG)")
//        XCTAssertEqual("(020) 7031 3000", phoneUtil.formatByPattern(GB_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL, userDefinedFormats:newNumberFormats))
//
//        newNumFormat.setNationalPrefixFormattingRule("")
//        XCTAssertEqual("20 7031 3000", phoneUtil.formatByPattern(GB_NUMBER, numberFormat:PhoneNumberFormat.NATIONAL, userDefinedFormats:newNumberFormats))
//
//        XCTAssertEqual("+44 20 7031 3000", phoneUtil.formatByPattern(GB_NUMBER, numberFormat:PhoneNumberFormat.INTERNATIONAL, userDefinedFormats:newNumberFormats))
//    }
//
//    func testFormatE164Number() {
//        XCTAssertEqual("+16502530000", phoneUtil.format(US_NUMBER, numberFormat:PhoneNumberFormat.E164))
//        XCTAssertEqual("+4930123456", phoneUtil.format(DE_NUMBER, numberFormat:PhoneNumberFormat.E164))
//        XCTAssertEqual("+80012345678", phoneUtil.format(INTERNATIONAL_TOLL_FREE, numberFormat:PhoneNumberFormat.E164))
//    }
//
//    func testFormatNumberWithExtension() {
//        let nzNumber:PhoneNumber = PhoneNumber().mergeFrom(NZ_NUMBER).setExtension("1234")
//        // Uses default extension prefix:
//        XCTAssertEqual("03-331 6005 ext. 1234", phoneUtil.format(nzNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        // Uses RFC 3966 syntax.
//        XCTAssertEqual("tel:+64-3-331-6005ext=1234", phoneUtil.format(nzNumber, numberFormat:PhoneNumberFormat.RFC3966))
//        // Extension prefix overridden in the territory information for the US:
//        let usNumberWithExtension:PhoneNumber = PhoneNumber().mergeFrom(US_NUMBER).setExtension("4567")
//        XCTAssertEqual("650 253 0000 extn. 4567", phoneUtil.format(usNumberWithExtension, numberFormat:PhoneNumberFormat.NATIONAL))
//    }
//
//    func testFormatInOriginalFormat() {
//        var error:NSError? = nil
//        let number1:PhoneNumber = phoneUtil.parseAndKeepRawInput("+442087654321", defaultRegion:RegionCode.GB, error:&error)
//        XCTAssertEqual("+44 20 8765 4321", phoneUtil.formatInOriginalFormat(number1, regionCallingFrom:RegionCode.GB))
//
//        let number2 = phoneUtil.parseAndKeepRawInput("02087654321", defaultRegion:RegionCode.GB, error:&error)
//        XCTAssertEqual("(020) 8765 4321", phoneUtil.formatInOriginalFormat(number2, regionCallingFrom:RegionCode.GB))
//
//        let number3 = phoneUtil.parseAndKeepRawInput("011442087654321", defaultRegion:RegionCode.US, error:&error)
//        XCTAssertEqual("011 44 20 8765 4321", phoneUtil.formatInOriginalFormat(number3, regionCallingFrom:RegionCode.US))
//
//        let number4 = phoneUtil.parseAndKeepRawInput("442087654321", defaultRegion:RegionCode.GB, error:&error)
//        XCTAssertEqual("44 20 8765 4321", phoneUtil.formatInOriginalFormat(number4, regionCallingFrom:RegionCode.GB))
//
//        let number5 = phoneUtil.parse("+442087654321", defaultRegion:RegionCode.GB, error:&error)
//        XCTAssertEqual("(020) 8765 4321", phoneUtil.formatInOriginalFormat(number5, regionCallingFrom:RegionCode.GB))
//
//        // Invalid numbers that we have a formatting pattern for should be formatted properly. Note area
//        // codes starting with 7 are intentionally excluded in the test metadata for testing purposes.
//        let number6 = phoneUtil.parseAndKeepRawInput("7345678901", defaultRegion:RegionCode.US, error:&error)
//        XCTAssertEqual("734 567 8901", phoneUtil.formatInOriginalFormat(number6, regionCallingFrom:RegionCode.US))
//
//        // US is not a leading zero country, and the presence of the leading zero leads us to format the
//        // number using raw_input.
//        let number7 = phoneUtil.parseAndKeepRawInput("0734567 8901", defaultRegion:RegionCode.US, error:&error)
//        XCTAssertEqual("0734567 8901", phoneUtil.formatInOriginalFormat(number7, regionCallingFrom:RegionCode.US))
//
//        // This number is valid, but we don't have a formatting pattern for it. Fall back to the raw
//        // input.
//        let number8 = phoneUtil.parseAndKeepRawInput("02-4567-8900", defaultRegion:RegionCode.KR, error:&error)
//        XCTAssertEqual("02-4567-8900", phoneUtil.formatInOriginalFormat(number8, regionCallingFrom:RegionCode.KR))
//
//        let number9 = phoneUtil.parseAndKeepRawInput("01180012345678", defaultRegion:RegionCode.US, error:&error)
//        XCTAssertEqual("011 800 1234 5678", phoneUtil.formatInOriginalFormat(number9, regionCallingFrom:RegionCode.US))
//
//        let number10 = phoneUtil.parseAndKeepRawInput("+80012345678", defaultRegion:RegionCode.KR, error:&error)
//        XCTAssertEqual("+800 1234 5678", phoneUtil.formatInOriginalFormat(number10, regionCallingFrom:RegionCode.KR))
//
//        // US local numbers are formatted correctly, as we have formatting patterns for them.
//        let localNumberUS = phoneUtil.parseAndKeepRawInput("2530000", defaultRegion:RegionCode.US, error:&error)
//        XCTAssertEqual("253 0000", phoneUtil.formatInOriginalFormat(localNumberUS, regionCallingFrom:RegionCode.US))
//
//        let numberWithNationalPrefixUS =
//        phoneUtil.parseAndKeepRawInput("18003456789", defaultRegion:RegionCode.US, error:&error)
//        XCTAssertEqual("1 800 345 6789", phoneUtil.formatInOriginalFormat(numberWithNationalPrefixUS, regionCallingFrom:RegionCode.US))
//
//        let numberWithoutNationalPrefixGB =
//        phoneUtil.parseAndKeepRawInput("2087654321", defaultRegion:RegionCode.GB, error:&error)
//        XCTAssertEqual("20 8765 4321", phoneUtil.formatInOriginalFormat(numberWithoutNationalPrefixGB, regionCallingFrom:RegionCode.GB))
//        // Make sure no metadata is modified as a result of the previous function call.
//        XCTAssertEqual("(020) 8765 4321", phoneUtil.formatInOriginalFormat(number5, regionCallingFrom:RegionCode.GB))
//
//        let numberWithNationalPrefixMX =
//        phoneUtil.parseAndKeepRawInput("013312345678", defaultRegion:RegionCode.MX, error:&error)
//        XCTAssertEqual("01 33 1234 5678", phoneUtil.formatInOriginalFormat(numberWithNationalPrefixMX, regionCallingFrom:RegionCode.MX))
//
//        let numberWithoutNationalPrefixMX =
//        phoneUtil.parseAndKeepRawInput("3312345678", defaultRegion:RegionCode.MX, error:&error)
//        XCTAssertEqual("33 1234 5678", phoneUtil.formatInOriginalFormat(numberWithoutNationalPrefixMX, regionCallingFrom:RegionCode.MX))
//
//        let italianFixedLineNumber =
//        phoneUtil.parseAndKeepRawInput("0212345678", defaultRegion:RegionCode.IT, error:&error)
//        XCTAssertEqual("02 1234 5678", phoneUtil.formatInOriginalFormat(italianFixedLineNumber, regionCallingFrom:RegionCode.IT))
//
//        let numberWithNationalPrefixJP =
//        phoneUtil.parseAndKeepRawInput("00777012", defaultRegion:RegionCode.JP, error:&error)
//        XCTAssertEqual("0077-7012", phoneUtil.formatInOriginalFormat(numberWithNationalPrefixJP, regionCallingFrom:RegionCode.JP))
//
//        let numberWithoutNationalPrefixJP =
//        phoneUtil.parseAndKeepRawInput("0777012", defaultRegion:RegionCode.JP, error:&error)
//        XCTAssertEqual("0777012", phoneUtil.formatInOriginalFormat(numberWithoutNationalPrefixJP, regionCallingFrom:RegionCode.JP))
//
//        let numberWithCarrierCodeBR =
//        phoneUtil.parseAndKeepRawInput("012 3121286979", defaultRegion:RegionCode.BR, error:&error)
//        XCTAssertEqual("012 3121286979", phoneUtil.formatInOriginalFormat(numberWithCarrierCodeBR, regionCallingFrom:RegionCode.BR))
//
//        // The default national prefix used in this case is 045. When a number with national prefix 044
//        // is entered, we return the raw input as we don't want to change the number entered.
//        let numberWithNationalPrefixMX1 =
//        phoneUtil.parseAndKeepRawInput("044(33)1234-5678", defaultRegion:RegionCode.MX, error:&error)
//        XCTAssertEqual("044(33)1234-5678", phoneUtil.formatInOriginalFormat(numberWithNationalPrefixMX1, regionCallingFrom:RegionCode.MX))
//
//        let numberWithNationalPrefixMX2 =
//        phoneUtil.parseAndKeepRawInput("045(33)1234-5678", defaultRegion:RegionCode.MX, error:&error)
//        XCTAssertEqual("045 33 1234 5678", phoneUtil.formatInOriginalFormat(numberWithNationalPrefixMX2, regionCallingFrom:RegionCode.MX))
//
//        // The default international prefix used in this case is 0011. When a number with international
//        // prefix 0012 is entered, we return the raw input as we don't want to change the number
//        // entered.
//        let outOfCountryNumberFromAU1 = phoneUtil.parseAndKeepRawInput("0012 16502530000", defaultRegion:RegionCode.AU, error:&error)
//        XCTAssertEqual("0012 16502530000", phoneUtil.formatInOriginalFormat(outOfCountryNumberFromAU1, regionCallingFrom:RegionCode.AU))
//
//        let outOfCountryNumberFromAU2 = phoneUtil.parseAndKeepRawInput("0011 16502530000", defaultRegion:RegionCode.AU, error:&error)
//        XCTAssertEqual("0011 1 650 253 0000", phoneUtil.formatInOriginalFormat(outOfCountryNumberFromAU2, regionCallingFrom:RegionCode.AU))
//
//        // Test the star sign is not removed from or added to the original input by this method.
//        let starNumber = phoneUtil.parseAndKeepRawInput("*1234", defaultRegion:RegionCode.JP, error:&error)
//        XCTAssertEqual("*1234", phoneUtil.formatInOriginalFormat(starNumber, regionCallingFrom:RegionCode.JP))
//        let numberWithoutStar = phoneUtil.parseAndKeepRawInput("1234", defaultRegion:RegionCode.JP, error:&error)
//        XCTAssertEqual("1234", phoneUtil.formatInOriginalFormat(numberWithoutStar, regionCallingFrom:RegionCode.JP))
//
//        // Test an invalid national number without raw input is just formatted as the national number.
//        XCTAssertEqual("650253000", phoneUtil.formatInOriginalFormat(US_SHORT_BY_ONE_NUMBER, regionCallingFrom:RegionCode.US))
//    }
//
//    func testIsPremiumRate() {
//        XCTAssertEqual(PhoneNumberType.PREMIUM_RATE, phoneUtil.getNumberType(US_PREMIUM))
//
//        let premiumRateNumber:PhoneNumber = PhoneNumber().setCountryCode(39).setNationalNumber(892123)
//        XCTAssertEqual(PhoneNumberType.PREMIUM_RATE, phoneUtil.getNumberType(premiumRateNumber))
//
//        premiumRateNumber.clear()
//        premiumRateNumber.setCountryCode(44).setNationalNumber(9187654321)
//        XCTAssertEqual(PhoneNumberType.PREMIUM_RATE, phoneUtil.getNumberType(premiumRateNumber))
//
//        premiumRateNumber.clear()
//        premiumRateNumber.setCountryCode(49).setNationalNumber(9001654321)
//        XCTAssertEqual(PhoneNumberType.PREMIUM_RATE, phoneUtil.getNumberType(premiumRateNumber))
//
//        premiumRateNumber.clear()
//        premiumRateNumber.setCountryCode(49).setNationalNumber(90091234567)
//        XCTAssertEqual(PhoneNumberType.PREMIUM_RATE, phoneUtil.getNumberType(premiumRateNumber))
//
//        XCTAssertEqual(PhoneNumberType.PREMIUM_RATE, phoneUtil.getNumberType(UNIVERSAL_PREMIUM_RATE))
//    }
//
//    func testIsTollFree() {
//        let tollFreeNumber:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(8881234567)
//        XCTAssertEqual(PhoneNumberType.TOLL_FREE, phoneUtil.getNumberType(tollFreeNumber))
//        tollFreeNumber.clear()
//
//        tollFreeNumber.setCountryCode(39).setNationalNumber(803123)
//        XCTAssertEqual(PhoneNumberType.TOLL_FREE, phoneUtil.getNumberType(tollFreeNumber))
//
//        tollFreeNumber.clear()
//        tollFreeNumber.setCountryCode(44).setNationalNumber(8012345678)
//        XCTAssertEqual(PhoneNumberType.TOLL_FREE, phoneUtil.getNumberType(tollFreeNumber))
//
//        tollFreeNumber.clear()
//        tollFreeNumber.setCountryCode(49).setNationalNumber(8001234567)
//        XCTAssertEqual(PhoneNumberType.TOLL_FREE, phoneUtil.getNumberType(tollFreeNumber))
//
//        XCTAssertEqual(PhoneNumberType.TOLL_FREE, phoneUtil.getNumberType(INTERNATIONAL_TOLL_FREE))
//    }
//
//    func testIsMobile() {
//        XCTAssertEqual(PhoneNumberType.MOBILE, phoneUtil.getNumberType(BS_MOBILE))
//        XCTAssertEqual(PhoneNumberType.MOBILE, phoneUtil.getNumberType(GB_MOBILE))
//        XCTAssertEqual(PhoneNumberType.MOBILE, phoneUtil.getNumberType(IT_MOBILE))
//        XCTAssertEqual(PhoneNumberType.MOBILE, phoneUtil.getNumberType(AR_MOBILE))
//
//        let mobileNumber:PhoneNumber = PhoneNumber().setCountryCode(49).setNationalNumber(15123456789)
//        XCTAssertEqual(PhoneNumberType.MOBILE, phoneUtil.getNumberType(mobileNumber))
//    }
//
//    func testIsFixedLine() {
//        XCTAssertEqual(PhoneNumberType.FIXED_LINE, phoneUtil.getNumberType(BS_NUMBER))
//        XCTAssertEqual(PhoneNumberType.FIXED_LINE, phoneUtil.getNumberType(IT_NUMBER))
//        XCTAssertEqual(PhoneNumberType.FIXED_LINE, phoneUtil.getNumberType(GB_NUMBER))
//        XCTAssertEqual(PhoneNumberType.FIXED_LINE, phoneUtil.getNumberType(DE_NUMBER))
//    }
//
//    func testIsFixedLineAndMobile() {
//        XCTAssertEqual(PhoneNumberType.FIXED_LINE_OR_MOBILE, phoneUtil.getNumberType(US_NUMBER))
//
//        let fixedLineAndMobileNumber:PhoneNumber = PhoneNumber().setCountryCode(54).setNationalNumber(1987654321)
//        XCTAssertEqual(PhoneNumberType.FIXED_LINE_OR_MOBILE, phoneUtil.getNumberType(fixedLineAndMobileNumber))
//    }
//
//    func testIsSharedCost() {
//        let gbNumber:PhoneNumber = PhoneNumber().setCountryCode(44).setNationalNumber(8431231234)
//        XCTAssertEqual(PhoneNumberType.SHARED_COST, phoneUtil.getNumberType(gbNumber))
//    }
//
//    func testIsVoip() {
//        let gbNumber:PhoneNumber = PhoneNumber().setCountryCode(44).setNationalNumber(5631231234)
//        XCTAssertEqual(PhoneNumberType.VOIP, phoneUtil.getNumberType(gbNumber))
//    }
//
//    func testIsPersonalNumber() {
//        let gbNumber:PhoneNumber = PhoneNumber().setCountryCode(44).setNationalNumber(7031231234)
//        XCTAssertEqual(PhoneNumberType.PERSONAL_NUMBER, phoneUtil.getNumberType(gbNumber))
//    }
//
//    func testIsUnknown() {
//        // Invalid numbers should be of type UNKNOWN.
//        XCTAssertEqual(PhoneNumberType.UNKNOWN, phoneUtil.getNumberType(US_LOCAL_NUMBER))
//    }
//
//    func testIsValidNumber() {
//        XCTAssertTrue(phoneUtil.isValidNumber(US_NUMBER))
//        XCTAssertTrue(phoneUtil.isValidNumber(IT_NUMBER))
//        XCTAssertTrue(phoneUtil.isValidNumber(GB_MOBILE))
//        XCTAssertTrue(phoneUtil.isValidNumber(INTERNATIONAL_TOLL_FREE))
//        XCTAssertTrue(phoneUtil.isValidNumber(UNIVERSAL_PREMIUM_RATE))
//
//        let nzNumber:PhoneNumber = PhoneNumber().setCountryCode(64).setNationalNumber(21387835)
//        XCTAssertTrue(phoneUtil.isValidNumber(nzNumber))
//    }
//
//    func testIsValidForRegion() {
//        // This number is valid for the Bahamas, but is not a valid US number.
//        XCTAssertTrue(phoneUtil.isValidNumber(BS_NUMBER))
//        XCTAssertTrue(phoneUtil.isValidNumberForRegion(BS_NUMBER, regionCode:RegionCode.BS))
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(BS_NUMBER, regionCode:RegionCode.US))
//        let bsInvalidNumber:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(2421232345)
//        // This number is no longer valid.
//        XCTAssertFalse(phoneUtil.isValidNumber(bsInvalidNumber))
//
//        // La Mayotte and Reunion use 'leadingDigits' to differentiate them.
//        let reNumber:PhoneNumber = PhoneNumber().setCountryCode(262).setNationalNumber(262123456)
//        XCTAssertTrue(phoneUtil.isValidNumber(reNumber))
//        XCTAssertTrue(phoneUtil.isValidNumberForRegion(reNumber, regionCode:RegionCode.RE))
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(reNumber, regionCode:RegionCode.YT))
//        // Now change the number to be a number for La Mayotte.
//        reNumber.setNationalNumber(269601234)
//        XCTAssertTrue(phoneUtil.isValidNumberForRegion(reNumber, regionCode:RegionCode.YT))
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(reNumber, regionCode:RegionCode.RE))
//        // This number is no longer valid for La Reunion.
//        reNumber.setNationalNumber(269123456)
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(reNumber, regionCode:RegionCode.YT))
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(reNumber, regionCode:RegionCode.RE))
//        XCTAssertFalse(phoneUtil.isValidNumber(reNumber))
//        // However, it should be recognised as from La Mayotte, since it is valid for this region.
//        XCTAssertEqual(RegionCode.YT, phoneUtil.getRegionCodeForNumber(reNumber))
//        // This number is valid in both places.
//        reNumber.setNationalNumber(800123456)
//        XCTAssertTrue(phoneUtil.isValidNumberForRegion(reNumber, regionCode:RegionCode.YT))
//        XCTAssertTrue(phoneUtil.isValidNumberForRegion(reNumber, regionCode:RegionCode.RE))
//        XCTAssertTrue(phoneUtil.isValidNumberForRegion(INTERNATIONAL_TOLL_FREE, regionCode:RegionCode.UN001))
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(INTERNATIONAL_TOLL_FREE, regionCode:RegionCode.US))
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(INTERNATIONAL_TOLL_FREE, regionCode:RegionCode.ZZ))
//
//        // Invalid country calling codes.
//        let invalidNumber:PhoneNumber = PhoneNumber().setCountryCode(3923).setNationalNumber(2366)
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(invalidNumber, regionCode:RegionCode.ZZ))
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(invalidNumber, regionCode:RegionCode.UN001))
//        invalidNumber.setCountryCode(0)
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(invalidNumber, regionCode:RegionCode.UN001))
//        XCTAssertFalse(phoneUtil.isValidNumberForRegion(invalidNumber, regionCode:RegionCode.ZZ))
//    }
//
//    func testIsNotValidNumber() {
//        XCTAssertFalse(phoneUtil.isValidNumber(US_LOCAL_NUMBER))
//
//        let invalidNumber:PhoneNumber = PhoneNumber().setCountryCode(39).setNationalNumber(23661830000).setItalianLeadingZero(true)
//        XCTAssertFalse(phoneUtil.isValidNumber(invalidNumber))
//
//        invalidNumber.clear()
//        invalidNumber.setCountryCode(44).setNationalNumber(791234567)
//        XCTAssertFalse(phoneUtil.isValidNumber(invalidNumber))
//
//        invalidNumber.clear()
//        invalidNumber.setCountryCode(49).setNationalNumber(1234)
//        XCTAssertFalse(phoneUtil.isValidNumber(invalidNumber))
//
//        invalidNumber.clear()
//        invalidNumber.setCountryCode(64).setNationalNumber(3316005)
//        XCTAssertFalse(phoneUtil.isValidNumber(invalidNumber))
//
//        invalidNumber.clear()
//        // Invalid country calling codes.
//        invalidNumber.setCountryCode(3923).setNationalNumber(2366)
//        XCTAssertFalse(phoneUtil.isValidNumber(invalidNumber))
//        invalidNumber.setCountryCode(0)
//        XCTAssertFalse(phoneUtil.isValidNumber(invalidNumber))
//
//        XCTAssertFalse(phoneUtil.isValidNumber(INTERNATIONAL_TOLL_FREE_TOO_LONG))
//    }
//
//    func testGetRegionCodeForCountryCode() {
//        XCTAssertEqual(RegionCode.US, phoneUtil.getRegionCodeForCountryCode(1))
//        XCTAssertEqual(RegionCode.GB, phoneUtil.getRegionCodeForCountryCode(44))
//        XCTAssertEqual(RegionCode.DE, phoneUtil.getRegionCodeForCountryCode(49))
//        XCTAssertEqual(RegionCode.UN001, phoneUtil.getRegionCodeForCountryCode(800))
//        XCTAssertEqual(RegionCode.UN001, phoneUtil.getRegionCodeForCountryCode(979))
//    }
//
//    func testGetRegionCodeForNumber() {
//        XCTAssertEqual(RegionCode.BS, phoneUtil.getRegionCodeForNumber(BS_NUMBER))
//        XCTAssertEqual(RegionCode.US, phoneUtil.getRegionCodeForNumber(US_NUMBER))
//        XCTAssertEqual(RegionCode.GB, phoneUtil.getRegionCodeForNumber(GB_MOBILE))
//        XCTAssertEqual(RegionCode.UN001, phoneUtil.getRegionCodeForNumber(INTERNATIONAL_TOLL_FREE))
//        XCTAssertEqual(RegionCode.UN001, phoneUtil.getRegionCodeForNumber(UNIVERSAL_PREMIUM_RATE))
//    }
//
//    func testGetRegionCodesForCountryCode() {
//        let regionCodesForNANPA:[String] = phoneUtil.getRegionCodesForCountryCode(1)
//        XCTAssertTrue(contains(regionCodesForNANPA, RegionCode.US))
//        XCTAssertTrue(contains(regionCodesForNANPA, RegionCode.BS))
//        XCTAssertTrue(contains(phoneUtil.getRegionCodesForCountryCode(44), RegionCode.GB))
//        XCTAssertTrue(contains(phoneUtil.getRegionCodesForCountryCode(49), RegionCode.DE))
//        XCTAssertTrue(contains(phoneUtil.getRegionCodesForCountryCode(800), RegionCode.UN001))
//        // Test with invalid country calling code.
//        XCTAssertTrue(phoneUtil.getRegionCodesForCountryCode(-1).isEmpty)
//    }
//
//    func testGetCountryCodeForRegion() {
//        XCTAssertEqual(1, phoneUtil.getCountryCodeForRegion(RegionCode.US))
//        XCTAssertEqual(64, phoneUtil.getCountryCodeForRegion(RegionCode.NZ))
//        //    XCTAssertEqual(0, phoneUtil.getCountryCodeForRegion(nil))
//        XCTAssertEqual(0, phoneUtil.getCountryCodeForRegion(RegionCode.ZZ))
//        XCTAssertEqual(0, phoneUtil.getCountryCodeForRegion(RegionCode.UN001))
//        // CS is already deprecated so the library doesn't support it.
//        XCTAssertEqual(0, phoneUtil.getCountryCodeForRegion(RegionCode.CS))
//    }
//
//    func testGetNationalDiallingPrefixForRegion() {
//        XCTAssertEqual("1", phoneUtil.getNddPrefixForRegion(RegionCode.US, stripNonDigits:false))
//        // Test non-main country to see it gets the national dialling prefix for the main country with
//        // that country calling code.
//        XCTAssertEqual("1", phoneUtil.getNddPrefixForRegion(RegionCode.BS, stripNonDigits:false))
//        XCTAssertEqual("0", phoneUtil.getNddPrefixForRegion(RegionCode.NZ, stripNonDigits:false))
//        // Test case with non digit in the national prefix.
//        XCTAssertEqual("0~0", phoneUtil.getNddPrefixForRegion(RegionCode.AO, stripNonDigits:false))
//        XCTAssertEqual("00", phoneUtil.getNddPrefixForRegion(RegionCode.AO, stripNonDigits:true))
//        // Test cases with invalid regions.
//        XCTAssertNil(phoneUtil.getNddPrefixForRegion("", stripNonDigits:false))
//        XCTAssertNil(phoneUtil.getNddPrefixForRegion(RegionCode.ZZ, stripNonDigits:false))
//        XCTAssertNil(phoneUtil.getNddPrefixForRegion(RegionCode.UN001, stripNonDigits:false))
//        // CS is already deprecated so the library doesn't support it.
//        XCTAssertNil(phoneUtil.getNddPrefixForRegion(RegionCode.CS, stripNonDigits:false))
//    }
//
//    func testIsNANPACountry() {
//        XCTAssertTrue(phoneUtil.isNANPACountry(RegionCode.US))
//        XCTAssertTrue(phoneUtil.isNANPACountry(RegionCode.BS))
//        XCTAssertFalse(phoneUtil.isNANPACountry(RegionCode.DE))
//        XCTAssertFalse(phoneUtil.isNANPACountry(RegionCode.ZZ))
//        XCTAssertFalse(phoneUtil.isNANPACountry(RegionCode.UN001))
//        //    XCTAssertFalse(phoneUtil.isNANPACountry(nil))
//    }
//
//    func testIsPossibleNumber() {
//        XCTAssertTrue(phoneUtil.isPossibleNumber(US_NUMBER))
//        XCTAssertTrue(phoneUtil.isPossibleNumber(US_LOCAL_NUMBER))
//        XCTAssertTrue(phoneUtil.isPossibleNumber(GB_NUMBER))
//        XCTAssertTrue(phoneUtil.isPossibleNumber(INTERNATIONAL_TOLL_FREE))
//
//        XCTAssertTrue(phoneUtil.isPossibleNumber("+1 650 253 0000", regionDialingFrom:RegionCode.US))
//        XCTAssertTrue(phoneUtil.isPossibleNumber("+1 650 GOO OGLE", regionDialingFrom:RegionCode.US))
//        XCTAssertTrue(phoneUtil.isPossibleNumber("(650) 253-0000", regionDialingFrom:RegionCode.US))
//        XCTAssertTrue(phoneUtil.isPossibleNumber("253-0000", regionDialingFrom:RegionCode.US))
//        XCTAssertTrue(phoneUtil.isPossibleNumber("+1 650 253 0000", regionDialingFrom:RegionCode.GB))
//        XCTAssertTrue(phoneUtil.isPossibleNumber("+44 20 7031 3000", regionDialingFrom:RegionCode.GB))
//        XCTAssertTrue(phoneUtil.isPossibleNumber("(020) 7031 3000", regionDialingFrom:RegionCode.GB))
//        XCTAssertTrue(phoneUtil.isPossibleNumber("7031 3000", regionDialingFrom:RegionCode.GB))
//        XCTAssertTrue(phoneUtil.isPossibleNumber("3331 6005", regionDialingFrom:RegionCode.NZ))
//        XCTAssertTrue(phoneUtil.isPossibleNumber("+800 1234 5678", regionDialingFrom:RegionCode.UN001))
//    }
//
//    func testIsPossibleNumberWithReason() {
//        // National numbers for country calling code +1 that are within 7 to 10 digits are possible.
//        XCTAssertEqual(ValidationResult.IS_POSSIBLE, phoneUtil.isPossibleNumberWithReason(US_NUMBER))
//
//        XCTAssertEqual(ValidationResult.IS_POSSIBLE, phoneUtil.isPossibleNumberWithReason(US_LOCAL_NUMBER))
//
//        XCTAssertEqual(ValidationResult.TOO_LONG, phoneUtil.isPossibleNumberWithReason(US_LONG_NUMBER))
//
//        let number:PhoneNumber = PhoneNumber().setCountryCode(0).setNationalNumber(2530000)
//        XCTAssertEqual(ValidationResult.INVALID_COUNTRY_CODE, phoneUtil.isPossibleNumberWithReason(number))
//
//        number.clear()
//        number.setCountryCode(1).setNationalNumber(253000)
//        XCTAssertEqual(ValidationResult.TOO_SHORT, phoneUtil.isPossibleNumberWithReason(number))
//
//        number.clear()
//        number.setCountryCode(65).setNationalNumber(1234567890)
//        XCTAssertEqual(ValidationResult.IS_POSSIBLE, phoneUtil.isPossibleNumberWithReason(number))
//
//        XCTAssertEqual(ValidationResult.TOO_LONG, phoneUtil.isPossibleNumberWithReason(INTERNATIONAL_TOLL_FREE_TOO_LONG))
//    }
//
//    func testIsNotPossibleNumber() {
//        XCTAssertFalse(phoneUtil.isPossibleNumber(US_LONG_NUMBER))
//        XCTAssertFalse(phoneUtil.isPossibleNumber(INTERNATIONAL_TOLL_FREE_TOO_LONG))
//
//        let number:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(253000)
//        XCTAssertFalse(phoneUtil.isPossibleNumber(number))
//
//        number.clear()
//        number.setCountryCode(44).setNationalNumber(300)
//        XCTAssertFalse(phoneUtil.isPossibleNumber(number))
//        XCTAssertFalse(phoneUtil.isPossibleNumber("+1 650 253 00000", regionDialingFrom:RegionCode.US))
//        XCTAssertFalse(phoneUtil.isPossibleNumber("(650) 253-00000", regionDialingFrom:RegionCode.US))
//        XCTAssertFalse(phoneUtil.isPossibleNumber("I want a Pizza", regionDialingFrom:RegionCode.US))
//        XCTAssertFalse(phoneUtil.isPossibleNumber("253-000", regionDialingFrom:RegionCode.US))
//        XCTAssertFalse(phoneUtil.isPossibleNumber("1 3000", regionDialingFrom:RegionCode.GB))
//        XCTAssertFalse(phoneUtil.isPossibleNumber("+44 300", regionDialingFrom:RegionCode.GB))
//        XCTAssertFalse(phoneUtil.isPossibleNumber("+800 1234 5678 9", regionDialingFrom:RegionCode.UN001))
//    }
//
//    func testTruncateTooLongNumber() {
//        // GB number 080 1234 5678, but entered with 4 extra digits at the end.
//        let tooLongNumber:PhoneNumber = PhoneNumber().setCountryCode(44).setNationalNumber(80123456780123)
//        let validNumber:PhoneNumber = PhoneNumber().setCountryCode(44).setNationalNumber(8012345678)
//        XCTAssertTrue(phoneUtil.truncateTooLongNumber(tooLongNumber))
//        XCTAssertEqual(validNumber, tooLongNumber)
//
//        // IT number 022 3456 7890, but entered with 3 extra digits at the end.
//        tooLongNumber.clear()
//        tooLongNumber.setCountryCode(39).setNationalNumber(2234567890123).setItalianLeadingZero(true)
//        validNumber.clear()
//        validNumber.setCountryCode(39).setNationalNumber(2234567890).setItalianLeadingZero(true)
//        XCTAssertTrue(phoneUtil.truncateTooLongNumber(tooLongNumber))
//        XCTAssertEqual(validNumber, tooLongNumber)
//
//        // US number 650-253-0000, but entered with one additional digit at the end.
//        tooLongNumber.clear()
//        tooLongNumber.mergeFrom(US_LONG_NUMBER)
//        XCTAssertTrue(phoneUtil.truncateTooLongNumber(tooLongNumber))
//        XCTAssertEqual(US_NUMBER, tooLongNumber)
//
//        tooLongNumber.clear()
//        tooLongNumber.mergeFrom(INTERNATIONAL_TOLL_FREE_TOO_LONG)
//        XCTAssertTrue(phoneUtil.truncateTooLongNumber(tooLongNumber))
//        XCTAssertEqual(INTERNATIONAL_TOLL_FREE, tooLongNumber)
//
//        // Tests what happens when a valid number is passed in.
//        let validNumberCopy:PhoneNumber = PhoneNumber().mergeFrom(validNumber)
//        XCTAssertTrue(phoneUtil.truncateTooLongNumber(validNumber))
//        // Tests the number is not modified.
//        XCTAssertEqual(validNumberCopy, validNumber)
//
//        // Tests what happens when a number with invalid prefix is passed in.
//        // The test metadata says US numbers cannot have prefix 240.
//        let numberWithInvalidPrefix:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(2401234567)
//        let invalidNumberCopy:PhoneNumber = PhoneNumber().mergeFrom(numberWithInvalidPrefix)
//        XCTAssertFalse(phoneUtil.truncateTooLongNumber(numberWithInvalidPrefix))
//        // Tests the number is not modified.
//        XCTAssertEqual(invalidNumberCopy, numberWithInvalidPrefix)
//
//        // Tests what happens when a too short number is passed in.
//        let tooShortNumber:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(1234)
//        let tooShortNumberCopy:PhoneNumber = PhoneNumber().mergeFrom(tooShortNumber)
//        XCTAssertFalse(phoneUtil.truncateTooLongNumber(tooShortNumber))
//        // Tests the number is not modified.
//        XCTAssertEqual(tooShortNumberCopy, tooShortNumber)
//    }
//
//    func testIsViablePhoneNumber() {
//        XCTAssertFalse(PhoneNumberUtil.isViablePhoneNumber("1"))
//        // Only one or two digits before strange non-possible punctuation.
//        XCTAssertFalse(PhoneNumberUtil.isViablePhoneNumber("1+1+1"))
//        XCTAssertFalse(PhoneNumberUtil.isViablePhoneNumber("80+0"))
//        // Two digits is viable.
//        XCTAssertTrue(PhoneNumberUtil.isViablePhoneNumber("00"))
//        XCTAssertTrue(PhoneNumberUtil.isViablePhoneNumber("111"))
//        // Alpha numbers.
//        XCTAssertTrue(PhoneNumberUtil.isViablePhoneNumber("0800-4-pizza"))
//        XCTAssertTrue(PhoneNumberUtil.isViablePhoneNumber("0800-4-PIZZA"))
//        // We need at least three digits before any alpha characters.
//        XCTAssertFalse(PhoneNumberUtil.isViablePhoneNumber("08-PIZZA"))
//        XCTAssertFalse(PhoneNumberUtil.isViablePhoneNumber("8-PIZZA"))
//        XCTAssertFalse(PhoneNumberUtil.isViablePhoneNumber("12. March"))
//    }
//
//    func testIsViablePhoneNumberNonAscii() {
//        // Only one or two digits before possible punctuation followed by more digits.
//        XCTAssertTrue(PhoneNumberUtil.isViablePhoneNumber("1\\u300034"))
//        XCTAssertFalse(PhoneNumberUtil.isViablePhoneNumber("1\\u30003+4"))
//        // Unicode variants of possible starting character and other allowed punctuation/digits.
//        XCTAssertTrue(PhoneNumberUtil.isViablePhoneNumber("\\uFF081\\uFF09\\u30003456789"))
//        // Testing a leading + is okay.
//        XCTAssertTrue(PhoneNumberUtil.isViablePhoneNumber("+1\\uFF09\\u30003456789"))
//    }
//
//    func testExtractPossibleNumber() {
//        // Removes preceding funky punctuation and letters but leaves the rest untouched.
//        XCTAssertEqual("0800-345-600", PhoneNumberUtil.extractPossibleNumber("Tel:0800-345-600"))
//        XCTAssertEqual("0800 FOR PIZZA", PhoneNumberUtil.extractPossibleNumber("Tel:0800 FOR PIZZA"))
//        // Should not remove plus sign
//        XCTAssertEqual("+800-345-600", PhoneNumberUtil.extractPossibleNumber("Tel:+800-345-600"))
//        // Should recognise wide digits as possible start values.
//        XCTAssertEqual("\\uFF10\\uFF12\\uFF13", PhoneNumberUtil.extractPossibleNumber("\\uFF10\\uFF12\\uFF13"))
//        // Dashes are not possible start values and should be removed.
//        XCTAssertEqual("\\uFF11\\uFF12\\uFF13", PhoneNumberUtil.extractPossibleNumber("Num-\\uFF11\\uFF12\\uFF13"))
//        // If not possible number present, return empty string.
//        XCTAssertEqual("", PhoneNumberUtil.extractPossibleNumber("Num-.."))
//        // Leading brackets are stripped - these are not used when parsing.
//        XCTAssertEqual("650) 253-0000", PhoneNumberUtil.extractPossibleNumber("(650) 253-0000"))
//
//        // Trailing non-alpha-numeric characters should be removed.
//        XCTAssertEqual("650) 253-0000", PhoneNumberUtil.extractPossibleNumber("(650) 253-0000.- ."))
//        XCTAssertEqual("650) 253-0000", PhoneNumberUtil.extractPossibleNumber("(650) 253-0000."))
//        // This case has a trailing RTL char.
//        XCTAssertEqual("650) 253-0000", PhoneNumberUtil.extractPossibleNumber("(650) 253-0000\\u200F"))
//    }
//
//    func testMaybeStripNationalPrefix() {
//        let metadata:PhoneMetadata = PhoneMetadata()
//        metadata.setNationalPrefixForParsing("34")
//        metadata.setGeneralDesc(PhoneNumberDesc().setNationalNumberPattern("\\d{4,8}"))
//        var numberToStrip = "34356778"
//        var strippedNumber = "356778"
//        XCTAssertTrue(phoneUtil.maybeStripNationalPrefixAndCarrierCode(numberToStrip, metadata:metadata, carrierCode:""))
//        XCTAssertEqual("Should have had national prefix stripped.", strippedNumber, numberToStrip)
//        // Retry stripping - now the number should not start with the national prefix, so no more
//        // stripping should occur.
//        XCTAssertFalse(phoneUtil.maybeStripNationalPrefixAndCarrierCode(numberToStrip, metadata:metadata, carrierCode:""))
//        XCTAssertEqual("Should have had no change - no national prefix present.", strippedNumber, numberToStrip)
//        // Some countries have no national prefix. Repeat test with none specified.
//        metadata.setNationalPrefixForParsing("")
//        XCTAssertFalse(phoneUtil.maybeStripNationalPrefixAndCarrierCode(numberToStrip, metadata:metadata, carrierCode:""))
//        XCTAssertEqual("Should not strip anything with empty national prefix.", strippedNumber, numberToStrip)
//        // If the resultant number doesn't match the national rule, it shouldn't be stripped.
//        metadata.setNationalPrefixForParsing("3")
//        numberToStrip = "3123"
//        strippedNumber = "3123"
//        XCTAssertFalse(phoneUtil.maybeStripNationalPrefixAndCarrierCode(numberToStrip, metadata:metadata, carrierCode:""))
//        XCTAssertEqual("Should have had no change - after stripping, it wouldn't have matched " + "the national rule.", strippedNumber, numberToStrip)
//        // Test extracting carrier selection code.
//        metadata.setNationalPrefixForParsing("0(81)?")
//        numberToStrip = "08122123456"
//        strippedNumber = "22123456"
//        var carrierCode = ""
//        XCTAssertTrue(phoneUtil.maybeStripNationalPrefixAndCarrierCode(numberToStrip, metadata:metadata, carrierCode:carrierCode))
//        XCTAssertEqual("81", carrierCode)
//        XCTAssertEqual("Should have had national prefix and carrier code stripped.", strippedNumber, numberToStrip)
//        // If there was a transform rule, check it was applied.
//        metadata.setNationalPrefixTransformRule("5$15")
//        // Note that a capturing group is present here.
//        metadata.setNationalPrefixForParsing("0(\\d{2})")
//        numberToStrip = "031123"
//        let transformedNumber = "5315123"
//        XCTAssertTrue(phoneUtil.maybeStripNationalPrefixAndCarrierCode(numberToStrip, metadata:metadata, carrierCode:""))
//        XCTAssertEqual("Should transform the 031 to a 5315.", transformedNumber, numberToStrip)
//    }
//
//    func testMaybeStripInternationalPrefix() {
//        let internationalPrefix = "00[39]"
//        var numberToStrip = "0034567700-3898003"
//        // Note the dash is removed as part of the normalization.
//        var strippedNumber = "45677003898003"
//        XCTAssertEqual(CountryCodeSource.FROM_NUMBER_WITH_IDD, phoneUtil.maybeStripInternationalPrefixAndNormalize(numberToStrip, possibleIddPrefix:internationalPrefix))
//        XCTAssertEqual(strippedNumber, numberToStrip, "The number supplied was not stripped of its international prefix.")
//        // Now the number no longer starts with an IDD prefix, so it should now report
//        // FROM_DEFAULT_COUNTRY.
//        XCTAssertEqual(CountryCodeSource.FROM_DEFAULT_COUNTRY, phoneUtil.maybeStripInternationalPrefixAndNormalize(numberToStrip, possibleIddPrefix:internationalPrefix))
//
//        numberToStrip = "00945677003898003"
//        XCTAssertEqual(CountryCodeSource.FROM_NUMBER_WITH_IDD, phoneUtil.maybeStripInternationalPrefixAndNormalize(numberToStrip, possibleIddPrefix:internationalPrefix))
//        XCTAssertEqual(strippedNumber, numberToStrip, "The number supplied was not stripped of its international prefix.")
//        // Test it works when the international prefix is broken up by spaces.
//        numberToStrip = "00 9 45677003898003"
//        XCTAssertEqual(CountryCodeSource.FROM_NUMBER_WITH_IDD, phoneUtil.maybeStripInternationalPrefixAndNormalize(numberToStrip, possibleIddPrefix:internationalPrefix))
//        XCTAssertEqual(strippedNumber, numberToStrip, "The number supplied was not stripped of its international prefix.")
//        // Now the number no longer starts with an IDD prefix, so it should now report
//        // FROM_DEFAULT_COUNTRY.
//        XCTAssertEqual(CountryCodeSource.FROM_DEFAULT_COUNTRY, phoneUtil.maybeStripInternationalPrefixAndNormalize(numberToStrip, possibleIddPrefix:internationalPrefix))
//
//        // Test the + symbol is also recognised and stripped.
//        numberToStrip = "+45677003898003"
//        strippedNumber = "45677003898003"
//        XCTAssertEqual(CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN, phoneUtil.maybeStripInternationalPrefixAndNormalize(numberToStrip, possibleIddPrefix:internationalPrefix))
//        XCTAssertEqual(strippedNumber, numberToStrip, "The number supplied was not stripped of the plus symbol.")
//
//        // If the number afterwards is a zero, we should not strip this - no country calling code begins
//        // with 0.
//        numberToStrip = "0090112-3123"
//        strippedNumber = "00901123123"
//        XCTAssertEqual(CountryCodeSource.FROM_DEFAULT_COUNTRY, phoneUtil.maybeStripInternationalPrefixAndNormalize(numberToStrip, possibleIddPrefix:internationalPrefix))
//        XCTAssertEqual(strippedNumber, numberToStrip, "The number supplied had a 0 after the match so shouldn't be stripped.")
//        // Here the 0 is separated by a space from the IDD.
//        numberToStrip = "009 0-112-3123"
//        XCTAssertEqual(CountryCodeSource.FROM_DEFAULT_COUNTRY, phoneUtil.maybeStripInternationalPrefixAndNormalize(numberToStrip, possibleIddPrefix:internationalPrefix))
//    }
//
//    func testMaybeExtractCountryCode() {
//        var error:NSError?
//
//        let number:PhoneNumber = PhoneNumber()
//        let metadata:PhoneMetadata = phoneUtil.getMetadataForRegion(RegionCode.US)
//        // Note that for the US, the IDD is 011.
//        var phoneNumber = "011112-3456789"
//        var strippedNumber = "123456789"
//        var countryCallingCode = 1
//        var numberToFill = ""
//        XCTAssertEqual(countryCallingCode, phoneUtil.maybeExtractCountryCode(phoneNumber, defaultRegionMetadata:metadata, nationalNumber:numberToFill, keepRawInput:true, phoneNumber:number, error:&error), "Did not extract country calling code \(countryCallingCode) correctly.")
//        XCTAssertEqual(CountryCodeSource.FROM_NUMBER_WITH_IDD, number.getCountryCodeSource(), "Did not figure out CountryCodeSource correctly")
//        // Should strip and normalize national significant number.
//        XCTAssertEqual(strippedNumber, numberToFill, "Did not strip off the country calling code correctly.")
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//        number.clear()
//
//        phoneNumber = "+6423456789"
//        countryCallingCode = 64
//        XCTAssertEqual(countryCallingCode, phoneUtil.maybeExtractCountryCode(phoneNumber, defaultRegionMetadata:metadata, nationalNumber:numberToFill, keepRawInput:true, phoneNumber:number, error:&error), "Did not extract country calling code \(countryCallingCode) correctly.")
//        XCTAssertEqual(CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN, number.getCountryCodeSource(), "Did not figure out CountryCodeSource correctly")
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//        number.clear()
//
//        phoneNumber = "+80012345678"
//        countryCallingCode = 800
//        XCTAssertEqual(countryCallingCode, phoneUtil.maybeExtractCountryCode(phoneNumber, defaultRegionMetadata:metadata, nationalNumber:numberToFill, keepRawInput:true, phoneNumber:number, error:&error), "Did not extract country calling code \(countryCallingCode) correctly.")
//        XCTAssertEqual(CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN, number.getCountryCodeSource(), "Did not figure out CountryCodeSource correctly")
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//        number.clear()
//
//        phoneNumber = "2345-6789"
//        XCTAssertEqual(0, phoneUtil.maybeExtractCountryCode(phoneNumber, defaultRegionMetadata:metadata, nationalNumber:numberToFill, keepRawInput:true, phoneNumber:number, error:&error), "Should not have extracted a country calling code - no international prefix present.")
//        XCTAssertEqual(CountryCodeSource.FROM_DEFAULT_COUNTRY, number.getCountryCodeSource(), "Did not figure out CountryCodeSource correctly")
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//        number.clear()
//
//        phoneNumber = "0119991123456789"
//        phoneUtil.maybeExtractCountryCode(phoneNumber, defaultRegionMetadata:metadata, nationalNumber:numberToFill, keepRawInput:true, phoneNumber:number, error:&error)
//        XCTAssertTrue(/*ErrorType.INVALID_COUNTRY_CODE */ 0 == error?.code, "Wrong error type stored in exception.")
//        number.clear()
//
//        phoneNumber = "(1 610) 619 4466"
//        countryCallingCode = 1
//        XCTAssertEqual(countryCallingCode, phoneUtil.maybeExtractCountryCode(phoneNumber, defaultRegionMetadata:metadata, nationalNumber:numberToFill, keepRawInput:true, phoneNumber:number, error:&error), "Should have extracted the country calling code of the region passed in")
//        XCTAssertEqual(CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN, number.getCountryCodeSource(), "Did not figure out CountryCodeSource correctly")
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//        number.clear()
//
//        phoneNumber = "(1 610) 619 4466"
//        countryCallingCode = 1
//        XCTAssertEqual(countryCallingCode, phoneUtil.maybeExtractCountryCode(phoneNumber, defaultRegionMetadata:metadata, nationalNumber:numberToFill, keepRawInput:false, phoneNumber:number, error:&error), "Should have extracted the country calling code of the region passed in")
//        XCTAssertFalse(number.hasCountryCodeSource(), "Should not contain CountryCodeSource.")
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//        number.clear()
//
//        phoneNumber = "(1 610) 619 446"
//        XCTAssertEqual(0, phoneUtil.maybeExtractCountryCode(phoneNumber, defaultRegionMetadata:metadata, nationalNumber:numberToFill, keepRawInput:false, phoneNumber:number, error:&error), "Should not have extracted a country calling code - invalid number after extraction of uncertain country calling code.")
//        XCTAssertFalse(number.hasCountryCodeSource(), "Should not contain CountryCodeSource.")
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//        number.clear()
//
//        phoneNumber = "(1 610) 619"
//        XCTAssertEqual(0, phoneUtil.maybeExtractCountryCode(phoneNumber, defaultRegionMetadata:metadata, nationalNumber:numberToFill, keepRawInput:true, phoneNumber:number, error:&error), "Should not have extracted a country calling code - too short number both before and after extraction of uncertain country calling code.")
//        XCTAssertEqual(CountryCodeSource.FROM_DEFAULT_COUNTRY, number.getCountryCodeSource(), "Did not figure out CountryCodeSource correctly")
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseNationalNumber() {
//        var error:NSError?
//        // National prefix attached.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("033316005", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("33316005", defaultRegion:RegionCode.NZ, error:&error))
//        // National prefix attached and some formatting present.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("03-331 6005", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("03 331 6005", defaultRegion:RegionCode.NZ, error:&error))
//        // Test parsing RFC3966 format with a phone context.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("tel:03-331-6005phone-context=+64", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("tel:331-6005phone-context=+64-3", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("tel:331-6005phone-context=+64-3", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("My number is tel:03-331-6005phone-context=+64", defaultRegion:RegionCode.NZ, error:&error))
//        // Test parsing RFC3966 format with optional user-defined parameters. The parameters will appear
//        // after the context if present.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("tel:03-331-6005phone-context=+64a=%A1", defaultRegion:RegionCode.NZ, error:&error))
//        // Test parsing RFC3966 with an ISDN subaddress.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("tel:03-331-6005isub=12345phone-context=+64", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("tel:+64-3-331-6005isub=12345", defaultRegion:RegionCode.NZ, error:&error))
//        // Test parsing RFC3966 with "tel:" missing.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("03-331-6005phone-context=+64", defaultRegion:RegionCode.NZ, error:&error))
//        // Testing international prefixes.
//        // Should strip country calling code.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("0064 3 331 6005", defaultRegion:RegionCode.NZ, error:&error))
//        // Try again, but this time we have an international number with Region Code US. It should
//        // recognise the country calling code and parse accordingly.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("01164 3 331 6005", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("+64 3 331 6005", defaultRegion:RegionCode.US, error:&error))
//        // We should ignore the leading plus here, since it is not followed by a valid country code but
//        // instead is followed by the IDD for the US.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("+01164 3 331 6005", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("+0064 3 331 6005", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("+ 00 64 3 331 6005", defaultRegion:RegionCode.NZ, error:&error))
//
//        XCTAssertEqual(US_LOCAL_NUMBER, phoneUtil.parse("tel:253-0000phone-context=www.google.com", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(US_LOCAL_NUMBER, phoneUtil.parse("tel:253-0000isub=12345phone-context=www.google.com", defaultRegion:RegionCode.US, error:&error))
//        // This is invalid because no "+" sign is present as part of phone-context. The phone context
//        // is simply ignored in this case just as if it contains a domain.
//        XCTAssertEqual(US_LOCAL_NUMBER, phoneUtil.parse("tel:2530000isub=12345phone-context=1-650", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(US_LOCAL_NUMBER, phoneUtil.parse("tel:2530000isub=12345phone-context=1234.com", defaultRegion:RegionCode.US, error:&error))
//
//        let nzNumber:PhoneNumber = PhoneNumber().setCountryCode(64).setNationalNumber(64123456)
//        XCTAssertEqual(nzNumber, phoneUtil.parse("64(0)64123456", defaultRegion:RegionCode.NZ, error:&error))
//        // Check that using a "/" is fine in a phone number.
//        XCTAssertEqual(DE_NUMBER, phoneUtil.parse("301/23456", defaultRegion:RegionCode.DE, error:&error))
//
//        let usNumber:PhoneNumber = PhoneNumber()
//        // Check it doesn't use the '1' as a country calling code when parsing if the phone number was
//        // already possible.
//        usNumber.setCountryCode(1).setNationalNumber(1234567890)
//        XCTAssertEqual(usNumber, phoneUtil.parse("123-456-7890", defaultRegion:RegionCode.US, error:&error))
//
//        // Test star numbers. Although this is not strictly valid, we would like to make sure we can
//        // parse the output we produce when formatting the number.
//        XCTAssertEqual(JP_STAR_NUMBER, phoneUtil.parse("+81 *2345", defaultRegion:RegionCode.JP, error:&error))
//
//        let shortNumber:PhoneNumber = PhoneNumber().setCountryCode(64).setNationalNumber(12)
//        XCTAssertEqual(shortNumber, phoneUtil.parse("12", defaultRegion:RegionCode.NZ, error:&error))
//    }
//
//    func testParseNumberWithAlphaCharacters() {
//        var error:NSError?
//        // Test case with alpha characters.
//        let tollfreeNumber:PhoneNumber = PhoneNumber().setCountryCode(64).setNationalNumber(800332005)
//        XCTAssertEqual(tollfreeNumber, phoneUtil.parse("0800 DDA 005", defaultRegion:RegionCode.NZ, error:&error))
//        let premiumNumber:PhoneNumber = PhoneNumber().setCountryCode(64).setNationalNumber(9003326005)
//        XCTAssertEqual(premiumNumber, phoneUtil.parse("0900 DDA 6005", defaultRegion:RegionCode.NZ, error:&error))
//        // Not enough alpha characters for them to be considered intentional, so they are stripped.
//        XCTAssertEqual(premiumNumber, phoneUtil.parse("0900 332 6005a", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(premiumNumber, phoneUtil.parse("0900 332 600a5", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(premiumNumber, phoneUtil.parse("0900 332 600A5", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(premiumNumber, phoneUtil.parse("0900 a332 600A5", defaultRegion:RegionCode.NZ, error:&error))
//
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseMaliciousInput() {
//        var error:NSError?
//        // Lots of leading + signs before the possible number.
//        var maliciousNumber = "6000"
//        for (var i = 0 ; i < 6000 ; i++) {
//            maliciousNumber + "+"
//        }
//        maliciousNumber + "12222-33-244 extensioB 343+"
//        phoneUtil.parse(maliciousNumber, defaultRegion:RegionCode.US, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + maliciousNumber)
//        XCTAssertEqual(error!.code, ErrorType.TOO_LONG.rawValue,"Wrong error type stored in exception.")
//
//        var maliciousNumberWithAlmostExt = "6000"
//        for (var i = 0 ; i < 350 ; i++) {
//            maliciousNumberWithAlmostExt + "200"
//        }
//        maliciousNumberWithAlmostExt + " extensiOB 345"
//        phoneUtil.parse(maliciousNumberWithAlmostExt, defaultRegion:RegionCode.US, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + maliciousNumberWithAlmostExt)
//        XCTAssertEqual(error!.code, ErrorType.TOO_LONG.rawValue, "Wrong error type stored in exception.")
//    }
//
//    func testParseWithInternationalPrefixes() {
//        var error:NSError?
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse("+1 (650) 253-0000", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(INTERNATIONAL_TOLL_FREE, phoneUtil.parse("011 800 1234 5678", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse("1-650-253-0000", defaultRegion:RegionCode.US, error:&error))
//        // Calling the US number from Singapore by using different service providers
//        // 1st test: calling using SingTel IDD service (IDD is 001)
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse("0011-650-253-0000", defaultRegion:RegionCode.SG, error:&error))
//        // 2nd test: calling using StarHub IDD service (IDD is 008)
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse("0081-650-253-0000", defaultRegion:RegionCode.SG, error:&error))
//        // 3rd test: calling using SingTel V019 service (IDD is 019)
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse("0191-650-253-0000", defaultRegion:RegionCode.SG, error:&error))
//        // Calling the US number from Poland
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse("0~01-650-253-0000", defaultRegion:RegionCode.PL, error:&error))
//        // Using "++" at the start.
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse("++1 (650) 253-0000", defaultRegion:RegionCode.PL, error:&error))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseNonAscii(){
//        var error:NSError?
//        // Using a full-width plus sign.
//        let nonAscii_FF0B1 = "\\uFF0B1 (650) 253-0000"
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse(nonAscii_FF0B1, defaultRegion:RegionCode.SG, error:&error))
//        // Using a soft hyphen U+00AD.
//        let nonAscii_00AD = "1 (650) 253\\u00AD-0000"
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse(nonAscii_FF0B1, defaultRegion:RegionCode.US, error:&error))
//        // The whole number, including punctuation, is here represented in full-width form.
//        let nonAscii_Unicode = "\\uFF0B\\uFF11\\u3000\\uFF08\\uFF16\\uFF15\\uFF10\\uFF09\\u3000\\uFF12\\uFF15\\uFF13\\uFF0D\\uFF10\\uFF10\\uFF10\\uFF10"
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse(nonAscii_FF0B1, defaultRegion:RegionCode.SG, error:&error))
//        // Using U+30FC dash instead.
//        let nonAscii_30FC = "\\uFF0B\\uFF11\\u3000\\uFF08\\uFF16\\uFF15\\uFF10\\uFF09\\u3000\\uFF12\\uFF15\\uFF13\\u30FC\\uFF10\\uFF10\\uFF10\\uFF10"
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse(nonAscii_30FC, defaultRegion:RegionCode.SG, error:&error))
//
//        // Using a very strange decimal digit range (Mongolian digits).
//        let nonAscii_Mongolian = "\\u1811 \\u1816\\u1815\\u1810 \\u1812\\u1815\\u1813 \\u1810\\u1810\\u1810\\u1810"
//        XCTAssertEqual(US_NUMBER, phoneUtil.parse(nonAscii_Mongolian, defaultRegion:RegionCode.US, error:&error))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseWithLeadingZero() {
//        var error:NSError?
//        XCTAssertEqual(IT_NUMBER, phoneUtil.parse("+39 02-36618 300", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(IT_NUMBER, phoneUtil.parse("02-36618 300", defaultRegion:RegionCode.IT, error:&error))
//
//        XCTAssertEqual(IT_MOBILE, phoneUtil.parse("345 678 901", defaultRegion:RegionCode.IT, error:&error))
//
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseNationalNumberArgentina() {
//        var error:NSError?
//        // Test parsing mobile numbers of Argentina.
//        let arNumber:PhoneNumber = PhoneNumber().setCountryCode(54).setNationalNumber(93435551212)
//        XCTAssertEqual(arNumber, phoneUtil.parse("+54 9 343 555 1212", defaultRegion:RegionCode.AR, error:&error))
//        XCTAssertEqual(arNumber, phoneUtil.parse("0343 15 555 1212", defaultRegion:RegionCode.AR, error:&error))
//
//        arNumber.clear()
//        arNumber.setCountryCode(54).setNationalNumber(93715654320)
//        XCTAssertEqual(arNumber, phoneUtil.parse("+54 9 3715 65 4320", defaultRegion:RegionCode.AR, error:&error))
//        XCTAssertEqual(arNumber, phoneUtil.parse("03715 15 65 4320", defaultRegion:RegionCode.AR, error:&error))
//        XCTAssertEqual(AR_MOBILE, phoneUtil.parse("911 876 54321", defaultRegion:RegionCode.AR, error:&error))
//
//        // Test parsing fixed-line numbers of Argentina.
//        XCTAssertEqual(AR_NUMBER, phoneUtil.parse("+54 11 8765 4321", defaultRegion:RegionCode.AR, error:&error))
//        XCTAssertEqual(AR_NUMBER, phoneUtil.parse("011 8765 4321", defaultRegion:RegionCode.AR, error:&error))
//
//        arNumber.clear()
//        arNumber.setCountryCode(54).setNationalNumber(3715654321)
//        XCTAssertEqual(arNumber, phoneUtil.parse("+54 3715 65 4321", defaultRegion:RegionCode.AR, error:&error))
//        XCTAssertEqual(arNumber, phoneUtil.parse("03715 65 4321", defaultRegion:RegionCode.AR, error:&error))
//
//        arNumber.clear()
//        arNumber.setCountryCode(54).setNationalNumber(2312340000)
//        XCTAssertEqual(arNumber, phoneUtil.parse("+54 23 1234 0000", defaultRegion:RegionCode.AR, error:&error))
//        XCTAssertEqual(arNumber, phoneUtil.parse("023 1234 0000", defaultRegion:RegionCode.AR, error:&error))
//
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseWithXInNumber() {
//        var error:NSError?
//        // Test that having an 'x' in the phone number at the start is ok and that it just gets removed.
//        XCTAssertEqual(AR_NUMBER, phoneUtil.parse("01187654321", defaultRegion:RegionCode.AR, error:&error))
//        XCTAssertEqual(AR_NUMBER, phoneUtil.parse("(0) 1187654321", defaultRegion:RegionCode.AR, error:&error))
//        XCTAssertEqual(AR_NUMBER, phoneUtil.parse("0 1187654321", defaultRegion:RegionCode.AR, error:&error))
//        XCTAssertEqual(AR_NUMBER, phoneUtil.parse("(0xx) 1187654321", defaultRegion:RegionCode.AR, error:&error))
//        let arFromUs:PhoneNumber = PhoneNumber().setCountryCode(54).setNationalNumber(81429712)
//        // This test is intentionally constructed such that the number of digit after xx is larger than
//        // 7, so that the number won't be mistakenly treated as an extension, as we allow extensions up
//        // to 7 digits. This assumption is okay for now as all the countries where a carrier selection
//        // code is written in the form of xx have a national significant number of length larger than 7.
//        XCTAssertEqual(arFromUs, phoneUtil.parse("011xx5481429712", defaultRegion:RegionCode.US, error:&error))
//
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseNumbersMexico() {
//        var error:NSError?
//        // Test parsing fixed-line numbers of Mexico.
//        let mxNumber:PhoneNumber = PhoneNumber().setCountryCode(52).setNationalNumber(4499780001)
//        XCTAssertEqual(mxNumber, phoneUtil.parse("+52 (449)978-0001", defaultRegion:RegionCode.MX, error:&error))
//        XCTAssertEqual(mxNumber, phoneUtil.parse("01 (449)978-0001", defaultRegion:RegionCode.MX, error:&error))
//        XCTAssertEqual(mxNumber, phoneUtil.parse("(449)978-0001", defaultRegion:RegionCode.MX, error:&error))
//
//        // Test parsing mobile numbers of Mexico.
//        mxNumber.clear()
//        mxNumber.setCountryCode(52).setNationalNumber(13312345678)
//        XCTAssertEqual(mxNumber, phoneUtil.parse("+52 1 33 1234-5678", defaultRegion:RegionCode.MX, error:&error))
//        XCTAssertEqual(mxNumber, phoneUtil.parse("044 (33) 1234-5678", defaultRegion:RegionCode.MX, error:&error))
//        XCTAssertEqual(mxNumber, phoneUtil.parse("045 33 1234-5678", defaultRegion:RegionCode.MX, error:&error))
//
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testFailedParseOnInvalidNumbers() {
//        var error:NSError?
//        var sentencePhoneNumber = "This is not a phone number"
//        phoneUtil.parse(sentencePhoneNumber, defaultRegion:RegionCode.NZ, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + sentencePhoneNumber)
//        XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue, "Wrong error type stored in exception.")
//
//        sentencePhoneNumber = "1 Still not a number"
//        phoneUtil.parse(sentencePhoneNumber, defaultRegion:RegionCode.NZ, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + sentencePhoneNumber)
//        XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue, "Wrong error type stored in exception.")
//
//        sentencePhoneNumber = "1 MICROSOFT"
//        phoneUtil.parse(sentencePhoneNumber, defaultRegion:RegionCode.NZ, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + sentencePhoneNumber)
//        XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue,"Wrong error type stored in exception.")
//
//        sentencePhoneNumber = "12 MICROSOFT"
//        phoneUtil.parse(sentencePhoneNumber, defaultRegion:RegionCode.NZ, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + sentencePhoneNumber)
//        XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue,"Wrong error type stored in exception.")
//
//        var tooLongPhoneNumber = "01495 72553301873 810104"
//        phoneUtil.parse(tooLongPhoneNumber, defaultRegion:RegionCode.GB, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + tooLongPhoneNumber)
//        XCTAssertEqual(error!.code,  ErrorType.TOO_LONG.rawValue, "Wrong error type stored in exception.")
//
//        var plusMinusPhoneNumber = "+---"
//        phoneUtil.parse(plusMinusPhoneNumber, defaultRegion:RegionCode.DE, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + plusMinusPhoneNumber)
//        XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue,"Wrong error type stored in exception.")
//
//        var plusStar = "+***"
//        phoneUtil.parse(plusStar, defaultRegion:RegionCode.DE, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + plusStar)
//        XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue,"Wrong error type stored in exception.")
//
//        var plusStarPhoneNumber = "+*******91"
//        phoneUtil.parse(plusStarPhoneNumber, defaultRegion:RegionCode.DE, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + plusStarPhoneNumber)
//        XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue, "Wrong error type stored in exception.")
//
//        var tooShortPhoneNumber = "+49 0"
//        phoneUtil.parse(tooShortPhoneNumber, defaultRegion:RegionCode.DE, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception " + tooShortPhoneNumber)
//        XCTAssertEqual(error!.code,  ErrorType.TOO_SHORT_NSN.rawValue, "Wrong error type stored in exception.")
//
//        var invalidCountryCode = "+210 3456 56789"
//        phoneUtil.parse(invalidCountryCode, defaultRegion:RegionCode.NZ, error:&error)
//        XCTAssertNotNil(error, "This is not a recognised region code: should fail: " + invalidCountryCode)
//        XCTAssertEqual(error!.code,  ErrorType.INVALID_COUNTRY_CODE.rawValue, "Wrong error type stored in exception.")
//
//        var plusAndIddAndInvalidCountryCode = "+ 00 210 3 331 6005"
//        phoneUtil.parse(plusAndIddAndInvalidCountryCode, defaultRegion:RegionCode.NZ, error:&error)
//        XCTAssertNotNil(error, "This should not parse without throwing an exception.")
//        XCTAssertEqual(error!.code,  ErrorType.INVALID_COUNTRY_CODE.rawValue, "Wrong error type stored in exception.")
//
//        var someNumber = "123 456 7890"
//        phoneUtil.parse(someNumber, defaultRegion:RegionCode.ZZ, error:&error)
//        XCTAssertNotNil(error, "'Unknown' region code not allowed: should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.INVALID_COUNTRY_CODE.rawValue, "Wrong error type stored in exception.")
//
//        someNumber = "123 456 7890"
//        phoneUtil.parse(someNumber, defaultRegion:RegionCode.CS, error:&error)
//        XCTAssertNotNil(error, "Deprecated region code not allowed: should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.INVALID_COUNTRY_CODE.rawValue, "Wrong error type stored in exception.")
//
//        someNumber = "123 456 7890"
//        phoneUtil.parse(someNumber, defaultRegion:"", error:&error)
//        XCTAssertNotNil(error, "Null region code not allowed: should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.INVALID_COUNTRY_CODE.rawValue, "Wrong error type stored in exception.")
//
//        someNumber = "0044------"
//        phoneUtil.parse(someNumber, defaultRegion:RegionCode.GB, error:&error)
//        XCTAssertNotNil(error, "No number provided, only region code: should fail")
//        XCTAssertEqual(error!.code,  ErrorType.TOO_SHORT_AFTER_IDD.rawValue, "Wrong error type stored in exception.")
//
//        someNumber = "0044"
//        phoneUtil.parse(someNumber, defaultRegion:RegionCode.GB, error:&error)
//        XCTAssertNotNil(error, "No number provided, only region code: should fail")
//        XCTAssertEqual(error!.code,  ErrorType.TOO_SHORT_AFTER_IDD.rawValue, "Wrong error type stored in exception.")
//
//        someNumber = "011"
//        phoneUtil.parse(someNumber, defaultRegion:RegionCode.US, error:&error)
//        XCTAssertNotNil(error, "Only IDD provided - should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.TOO_SHORT_AFTER_IDD.rawValue, "Wrong error type stored in exception.")
//
//        someNumber = "0119"
//        phoneUtil.parse(someNumber, defaultRegion:RegionCode.US, error:&error)
//        XCTAssertNotNil(error, "Only IDD provided and then 9 - should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.TOO_SHORT_AFTER_IDD.rawValue, "Wrong error type stored in exception.")
//
//        var emptyNumber = ""
//        // Invalid region.
//        phoneUtil.parse(emptyNumber, defaultRegion:RegionCode.ZZ, error:&error)
//        XCTAssertNotNil(error, "Empty error!.code, - should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue, "Wrong error type stored in exception.")
//        emptyNumber = ""
//        // Invalid region.
//        phoneUtil.parse(emptyNumber, defaultRegion:RegionCode.US, error:&error)
//        XCTAssertNotNil(error, "Empty error!.code, - should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue, "Wrong error type stored in exception.")
//
//// TODO: is nil checking somthing?
////            var nullNumber = nil
////            // Invalid region.
////            phoneUtil.parse(nullNumber, defaultRegion:RegionCode.ZZ, error:&error)
////            XCTAssertNotNil(error, "Null string - should fail.")
////            XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue, "Wrong error type stored in exception.")
////
////            nullNumber = nil
////            phoneUtil.parse(nullNumber, defaultRegion:RegionCode.US, error:&error)
////            XCTAssertNotNil(error, "Null string - should fail.")
////            XCTAssertEqual(error!.code,  ErrorType.NOT_A_NUMBER.rawValue, "Wrong error type stored in exception.")
////            XCTAssertNotNil(error, "Null string - but should not throw a null pointer exception.")
//
//        var domainRfcPhoneContext = "tel:555-1234phone-context=www.google.com"
//        phoneUtil.parse(domainRfcPhoneContext, defaultRegion:RegionCode.ZZ, error:&error)
//        XCTAssertNotNil(error, "'Unknown' region code not allowed: should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.INVALID_COUNTRY_CODE.rawValue, "Wrong error type stored in exception.")
//
//        // This is invalid because no "+" sign is present as part of phone-context. This should not
//        // succeed in being parsed.
//        var invalidRfcPhoneContext = "tel:555-1234phone-context=1-331"
//        phoneUtil.parse(invalidRfcPhoneContext, defaultRegion:RegionCode.ZZ, error:&error)
//        XCTAssertNotNil(error, "'Unknown' region code not allowed: should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.INVALID_COUNTRY_CODE.rawValue, "Wrong error type stored in exception.")
//    }
//
//    func testParseNumbersWithPlusWithNoRegion() {
//        var error:NSError?
//        // RegionCode.ZZ is allowed only if the number starts with a '+' - then the country calling code
//        // can be calculated.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("+64 3 331 6005", defaultRegion:RegionCode.ZZ, error:&error))
//        // Test with full-width plus.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("\\uFF0B64 3 331 6005", defaultRegion:RegionCode.ZZ, error:&error))
//        // Test with normal plus but leading characters that need to be stripped.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("Tel: +64 3 331 6005", defaultRegion:RegionCode.ZZ, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("+64 3 331 6005", defaultRegion:"", error:&error))
//        XCTAssertEqual(INTERNATIONAL_TOLL_FREE, phoneUtil.parse("+800 1234 5678", defaultRegion:"", error:&error))
//        XCTAssertEqual(UNIVERSAL_PREMIUM_RATE, phoneUtil.parse("+979 123 456 789", defaultRegion:"", error:&error))
//
//        // Test parsing RFC3966 format with a phone context.
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("tel:03-331-6005phone-context=+64", defaultRegion:RegionCode.ZZ, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("  tel:03-331-6005phone-context=+64", defaultRegion:RegionCode.ZZ, error:&error))
//        XCTAssertEqual(NZ_NUMBER, phoneUtil.parse("tel:03-331-6005isub=12345phone-context=+64", defaultRegion:RegionCode.ZZ, error:&error))
//
//        // It is important that we set the carrier code to an empty string, since we used
//        // ParseAndKeepRawInput and no carrier code was found.
//        let nzNumberWithRawInput:PhoneNumber = PhoneNumber().mergeFrom(NZ_NUMBER).setRawInput("+64 3 331 6005").setCountryCodeSource(CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN).setPreferredDomesticCarrierCode("")
//        XCTAssertEqual(nzNumberWithRawInput, phoneUtil.parseAndKeepRawInput("+64 3 331 6005", defaultRegion:RegionCode.ZZ, error:&error))
//        // Null is also allowed for the region code in these cases.
//        XCTAssertEqual(nzNumberWithRawInput, phoneUtil.parseAndKeepRawInput("+64 3 331 6005", defaultRegion:"", error:&error))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseNumberTooShortIfNationalPrefixStripped() {
//        var error:NSError?
//        // Test that a number whose first digits happen to coincide with the national prefix does not
//        // get them stripped if doing so would result in a number too short to be a possible (regular
//        // length) phone number for that region.
//        let byNumber:PhoneNumber = PhoneNumber().setCountryCode(375).setNationalNumber(8123)
//        XCTAssertEqual(byNumber, phoneUtil.parse("8123", defaultRegion:RegionCode.BY, error:&error))
//        byNumber.setNationalNumber(81234)
//        XCTAssertEqual(byNumber, phoneUtil.parse("81234", defaultRegion:RegionCode.BY, error:&error))
//
//        // The prefix doesn't get stripped, since the input is a viable 6-digit number, whereas the
//        // result of stripping is only 5 digits.
//        byNumber.setNationalNumber(812345)
//        XCTAssertEqual(byNumber, phoneUtil.parse("812345", defaultRegion:RegionCode.BY, error:&error))
//
//        // The prefix gets stripped, since only 6-digit numbers are possible.
//        byNumber.setNationalNumber(123456)
//        XCTAssertEqual(byNumber, phoneUtil.parse("8123456", defaultRegion:RegionCode.BY, error:&error))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//
//    }
//
//    func testParseExtensions() {
//        var error:NSError?
//        let nzNumber:PhoneNumber = PhoneNumber().setCountryCode(64).setNationalNumber(33316005).setExtension("3456")
//        XCTAssertEqual(nzNumber, phoneUtil.parse("03 331 6005 ext 3456", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(nzNumber, phoneUtil.parse("03-3316005x3456", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(nzNumber, phoneUtil.parse("03-3316005 int.3456", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(nzNumber, phoneUtil.parse("03 3316005 #3456", defaultRegion:RegionCode.NZ, error:&error))
//        // Test the following do not extract extensions:
//        XCTAssertEqual(ALPHA_NUMERIC_NUMBER, phoneUtil.parse("1800 six-flags", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(ALPHA_NUMERIC_NUMBER, phoneUtil.parse("1800 SIX FLAGS", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(ALPHA_NUMERIC_NUMBER, phoneUtil.parse("0~0 1800 7493 5247", defaultRegion:RegionCode.PL, error:&error))
//        XCTAssertEqual(ALPHA_NUMERIC_NUMBER, phoneUtil.parse("(1800) 7493.5247", defaultRegion:RegionCode.US, error:&error))
//        // Check that the last instance of an extension token is matched.
//        let extnNumber:PhoneNumber = PhoneNumber().mergeFrom(ALPHA_NUMERIC_NUMBER).setExtension("1234")
//        XCTAssertEqual(extnNumber, phoneUtil.parse("0~0 1800 7493 5247 ~1234", defaultRegion:RegionCode.PL, error:&error))
//        // Verifying bug-fix where the last digit of a number was previously omitted if it was a 0 when
//        // extracting the extension. Also verifying a few different cases of extensions.
//        let ukNumber:PhoneNumber = PhoneNumber().setCountryCode(44).setNationalNumber(2034567890).setExtension("456")
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+44 2034567890x456", defaultRegion:RegionCode.NZ, error:&error))
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+44 2034567890x456", defaultRegion:RegionCode.GB, error:&error))
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+44 2034567890 x456", defaultRegion:RegionCode.GB, error:&error))
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+44 2034567890 X456", defaultRegion:RegionCode.GB, error:&error))
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+44 2034567890 X 456", defaultRegion:RegionCode.GB, error:&error))
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+44 2034567890 X  456", defaultRegion:RegionCode.GB, error:&error))
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+44 2034567890 x 456  ", defaultRegion:RegionCode.GB, error:&error))
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+44 2034567890  X 456", defaultRegion:RegionCode.GB, error:&error))
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+44-2034567890ext=456", defaultRegion:RegionCode.GB, error:&error))
//        XCTAssertEqual(ukNumber, phoneUtil.parse("tel:2034567890ext=456phone-context=+44", defaultRegion:RegionCode.ZZ, error:&error))
//        // Full-width extension, "extn" only.
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+442034567890\\uFF45\\uFF58\\uFF54\\uFF4E456", defaultRegion:RegionCode.GB, error:&error))
//        // "xtn" only.
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+442034567890\\uFF58\\uFF54\\uFF4E456", defaultRegion:RegionCode.GB, error:&error))
//        // "xt" only.
//        XCTAssertEqual(ukNumber, phoneUtil.parse("+442034567890\\uFF58\\uFF54456", defaultRegion:RegionCode.GB, error:&error))
//
//        let usWithExtension:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(8009013355).setExtension("7246433")
//        XCTAssertEqual(usWithExtension, phoneUtil.parse("(800) 901-3355 x 7246433", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(usWithExtension, phoneUtil.parse("(800) 901-3355 , ext 7246433", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(usWithExtension, phoneUtil.parse("(800) 901-3355 ,extension 7246433", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(usWithExtension, phoneUtil.parse("(800) 901-3355 ,extensi\\u00F3n 7246433", defaultRegion:RegionCode.US, error:&error))
//        // Repeat with the small letter o with acute accent created by combining characters.
//        XCTAssertEqual(usWithExtension, phoneUtil.parse("(800) 901-3355 ,extensio\\u0301n 7246433", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(usWithExtension, phoneUtil.parse("(800) 901-3355 , 7246433", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(usWithExtension, phoneUtil.parse("(800) 901-3355 ext: 7246433", defaultRegion:RegionCode.US, error:&error))
//
//        // Test that if a number has two extensions specified, we ignore the second.
//        let usWithTwoExtensionsNumber:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(2121231234).setExtension("508")
//        XCTAssertEqual(usWithTwoExtensionsNumber, phoneUtil.parse("(212)123-1234 x508/x1234", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(usWithTwoExtensionsNumber, phoneUtil.parse("(212)123-1234 x508/ x1234", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertEqual(usWithTwoExtensionsNumber, phoneUtil.parse("(212)123-1234 x508\\x1234", defaultRegion:RegionCode.US, error:&error))
//
//        // Test parsing numbers in the form (645) 123-1234-910# works, where the last 3 digits before
//        // the # are an extension.
//        usWithExtension.clear()
//        usWithExtension.setCountryCode(1).setNationalNumber(6451231234).setExtension("910")
//        XCTAssertEqual(usWithExtension, phoneUtil.parse("+1 (645) 123 1234-910#", defaultRegion:RegionCode.US, error:&error))
//        // Retry with the same number in a slightly different format.
//        XCTAssertEqual(usWithExtension, phoneUtil.parse("+1 (645) 123 1234 ext. 910#", defaultRegion:RegionCode.US, error:&error))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseAndKeepRaw() {
//        var error:NSError?
//        let alphaNumericNumber:PhoneNumber = PhoneNumber().mergeFrom(ALPHA_NUMERIC_NUMBER).setRawInput("800 six-flags").setCountryCodeSource(CountryCodeSource.FROM_DEFAULT_COUNTRY).setPreferredDomesticCarrierCode("")
//        XCTAssertEqual(alphaNumericNumber, phoneUtil.parseAndKeepRawInput("800 six-flags", defaultRegion:RegionCode.US, error:&error))
//
//        let shorterAlphaNumber:PhoneNumber = PhoneNumber().setCountryCode(1).setNationalNumber(8007493524).setRawInput("1800 six-flag").setCountryCodeSource(CountryCodeSource.FROM_NUMBER_WITHOUT_PLUS_SIGN).setPreferredDomesticCarrierCode("")
//        XCTAssertEqual(shorterAlphaNumber, phoneUtil.parseAndKeepRawInput("1800 six-flag", defaultRegion:RegionCode.US, error:&error))
//
//        shorterAlphaNumber.setRawInput("+1800 six-flag").setCountryCodeSource(CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN)
//        XCTAssertEqual(shorterAlphaNumber, phoneUtil.parseAndKeepRawInput("+1800 six-flag", defaultRegion:RegionCode.NZ, error:&error))
//
//        shorterAlphaNumber.setRawInput("001800 six-flag").setCountryCodeSource(CountryCodeSource.FROM_NUMBER_WITH_IDD)
//        XCTAssertEqual(shorterAlphaNumber, phoneUtil.parseAndKeepRawInput("001800 six-flag", defaultRegion:RegionCode.NZ, error:&error))
//
//        // Invalid region code supplied.
//        phoneUtil.parseAndKeepRawInput("123 456 7890", defaultRegion:RegionCode.CS, error:&error)
//        XCTAssertNotNil(error, "Deprecated region code not allowed: should fail.")
//        XCTAssertEqual(error!.code,  ErrorType.INVALID_COUNTRY_CODE.rawValue, "Wrong error type stored in exception.")
//
//        let koreanNumber:PhoneNumber = PhoneNumber()
//        koreanNumber.setCountryCode(82).setNationalNumber(22123456).setRawInput("08122123456").setCountryCodeSource(CountryCodeSource.FROM_DEFAULT_COUNTRY).setPreferredDomesticCarrierCode("81")
//        XCTAssertEqual(koreanNumber, phoneUtil.parseAndKeepRawInput("08122123456", defaultRegion:RegionCode.KR, error:&error))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testParseItalianLeadingZeros() {
//        var error:NSError?
//        // Test the number "011".
//        let oneZero:PhoneNumber = PhoneNumber().setCountryCode(61).setNationalNumber(11).setItalianLeadingZero(true)
//        XCTAssertEqual(oneZero, phoneUtil.parse("011", defaultRegion:RegionCode.AU, error:&error))
//
//        // Test the number "001".
//        let twoZeros:PhoneNumber = PhoneNumber().setCountryCode(61).setNationalNumber(1).setItalianLeadingZero(true)
//            .setNumberOfLeadingZeros(2)
//        XCTAssertEqual(twoZeros, phoneUtil.parse("001", defaultRegion:RegionCode.AU, error:&error))
//
//        // Test the number "000". This number has 2 leading zeros.
//        let stillTwoZeros:PhoneNumber = PhoneNumber().setCountryCode(61).setNationalNumber(0).setItalianLeadingZero(true).setNumberOfLeadingZeros(2)
//        XCTAssertEqual(stillTwoZeros, phoneUtil.parse("000", defaultRegion:RegionCode.AU, error:&error))
//
//        // Test the number "0000". This number has 3 leading zeros.
//        let threeZeros:PhoneNumber = PhoneNumber().setCountryCode(61).setNationalNumber(0).setItalianLeadingZero(true).setNumberOfLeadingZeros(3)
//        XCTAssertEqual(threeZeros, phoneUtil.parse("0000", defaultRegion:RegionCode.AU, error:&error))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testCountryWithNoNumberDesc() {
//        var error:NSError?
//        // Andorra is a country where we don't have PhoneNumberDesc info in the metadata.
//        let adNumber:PhoneNumber = PhoneNumber().setCountryCode(376).setNationalNumber(12345)
//        XCTAssertEqual("+376 12345", phoneUtil.format(adNumber, numberFormat:PhoneNumberFormat.INTERNATIONAL))
//        XCTAssertEqual("+37612345", phoneUtil.format(adNumber, numberFormat:PhoneNumberFormat.E164))
//        XCTAssertEqual("12345", phoneUtil.format(adNumber, numberFormat:PhoneNumberFormat.NATIONAL))
//        XCTAssertEqual(PhoneNumberType.UNKNOWN, phoneUtil.getNumberType(adNumber))
//        XCTAssertFalse(phoneUtil.isValidNumber(adNumber))
//
//        // Test dialing a US number from within Andorra.
//        XCTAssertEqual("00 1 650 253 0000", phoneUtil.formatOutOfCountryCallingNumber(US_NUMBER, regionCallingFrom:RegionCode.AD))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testUnknownCountryCallingCode() {
//        XCTAssertFalse(phoneUtil.isValidNumber(UNKNOWN_COUNTRY_CODE_NO_RAW_INPUT))
//        // It's not very well defined as to what the E164 representation for a number with an invalid
//        // country calling code is, but just prefixing the country code and national number is about
//        // the best we can do.
//        XCTAssertEqual("+212345", phoneUtil.format(UNKNOWN_COUNTRY_CODE_NO_RAW_INPUT, numberFormat:PhoneNumberFormat.E164))
//    }
//
//    func testIsNumberMatchMatches() {
//        var error:NSError?
//        // Test simple matches where formatting is different, or leading zeros, or country calling code
//        // has been specified.
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch("+64 3 331 6005", secondString:"+64 03 331 6005"))
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch("+800 1234 5678", secondString:"+80012345678"))
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch("+64 03 331-6005", secondString:"+64 03331 6005"))
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch("+643 331-6005", secondString:"+64033316005"))
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch("+643 331-6005", secondString:"+6433316005"))
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"+6433316005"))
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"tel:+64-3-331-6005isub=123"))
//        // Test alpha numbers.
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch("+1800 siX-Flags", secondString:"+1 800 7493 5247"))
//        // Test numbers with extensions.
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005 extn 1234", secondString: "+6433316005#1234"))
//        // Test proto buffers.
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch(NZ_NUMBER, secondString:"+6403 331 6005"))
//
//        let nzNumber:PhoneNumber = PhoneNumber().mergeFrom(NZ_NUMBER).setExtension("3456")
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch(nzNumber, secondString:"+643 331 6005 ext 3456"))
//        // Check empty extensions are ignored.
//        nzNumber.setExtension("")
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch(nzNumber, secondString:"+6403 331 6005"))
//        // Check variant with two proto buffers.
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch(nzNumber, secondNumber:NZ_NUMBER), "Number \(nzNumber) did not match \(NZ_NUMBER)")
//
//        // Check raw_input, country_code_source and preferred_domestic_carrier_code are ignored.
//        let brNumberOne:PhoneNumber = PhoneNumber()
//        let brNumberTwo:PhoneNumber = PhoneNumber()
//        brNumberOne.setCountryCode(55).setNationalNumber(3121286979).setCountryCodeSource(CountryCodeSource.FROM_NUMBER_WITH_PLUS_SIGN).setPreferredDomesticCarrierCode("12").setRawInput("012 3121286979")
//        brNumberTwo.setCountryCode(55).setNationalNumber(3121286979).setCountryCodeSource(CountryCodeSource.FROM_DEFAULT_COUNTRY).setPreferredDomesticCarrierCode("14").setRawInput("143121286979")
//        XCTAssertEqual(MatchType.EXACT_MATCH, phoneUtil.isNumberMatch(brNumberOne, secondNumber:brNumberTwo))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testIsNumberMatchNonMatches() {
//        var error:NSError?
//        // Non-matches.
//        XCTAssertEqual(MatchType.NO_MATCH, phoneUtil
//            .isNumberMatch("03 331 6005", secondString: "03 331 6006"))
//        XCTAssertEqual(MatchType.NO_MATCH, phoneUtil.isNumberMatch("+800 1234 5678", secondString:"+1 800 1234 5678"))
//        // Different country calling code, partial number match.
//        XCTAssertEqual(MatchType.NO_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"+16433316005"))
//        // Different country calling code, same number.
//        XCTAssertEqual(MatchType.NO_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"+6133316005"))
//        // Extension different, all else the same.
//        XCTAssertEqual(MatchType.NO_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005 extn 1234", secondString:"0116433316005#1235"))
//        XCTAssertEqual(MatchType.NO_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005 extn 1234", secondString:"tel:+64-3-331-6005ext=1235"))
//        // NSN matches, but extension is different - not the same number.
//        XCTAssertEqual(MatchType.NO_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005 ext.1235", secondString:"3 331 6005#1234"))
//
//        // Invalid numbers that can't be parsed.
//        XCTAssertEqual(MatchType.NOT_A_NUMBER, phoneUtil.isNumberMatch("4", secondString:"3 331 6043"))
//        XCTAssertEqual(MatchType.NOT_A_NUMBER, phoneUtil.isNumberMatch("+43", secondString:"+64 3 331 6005"))
//        XCTAssertEqual(MatchType.NOT_A_NUMBER, phoneUtil.isNumberMatch("+43", secondString:"64 3 331 6005"))
//        XCTAssertEqual(MatchType.NOT_A_NUMBER, phoneUtil.isNumberMatch("Dog", secondString:"64 3 331 6005"))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testIsNumberMatchNsnMatches() {
//        var error:NSError?
//        // NSN matches.
//        XCTAssertEqual(MatchType.NSN_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"03 331 6005"))
//        XCTAssertEqual(MatchType.NSN_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"tel:03-331-6005isub=1234phone-context=abc.nz"))
//        XCTAssertEqual(MatchType.NSN_MATCH, phoneUtil.isNumberMatch(NZ_NUMBER, secondString:"03 331 6005"))
//        // Here the second number possibly starts with the country calling code for New Zealand,
//        // although we are unsure.
//        let unchangedNzNumber:PhoneNumber = PhoneNumber().mergeFrom(NZ_NUMBER)
//        XCTAssertEqual(MatchType.NSN_MATCH, phoneUtil.isNumberMatch(unchangedNzNumber, secondString:"(64-3) 331 6005"))
//        // Check the phone number proto was not edited during the method call.
//        XCTAssertEqual(NZ_NUMBER, unchangedNzNumber)
//
//        // Here, the 1 might be a national prefix, if we compare it to the US number, so the resultant
//        // match is an NSN match.
//        XCTAssertEqual(MatchType.NSN_MATCH, phoneUtil.isNumberMatch(US_NUMBER, secondString:"1-650-253-0000"))
//        XCTAssertEqual(MatchType.NSN_MATCH, phoneUtil.isNumberMatch(US_NUMBER, secondString:"6502530000"))
//        XCTAssertEqual(MatchType.NSN_MATCH, phoneUtil.isNumberMatch("+1 650-253 0000", secondString:"1 650 253 0000"))
//        XCTAssertEqual(MatchType.NSN_MATCH, phoneUtil.isNumberMatch("1 650-253 0000", secondString:"1 650 253 0000"))
//        XCTAssertEqual(MatchType.NSN_MATCH, phoneUtil.isNumberMatch("1 650-253 0000", secondString:"+1 650 253 0000"))
//        // For this case, the match will be a short NSN match, because we cannot assume that the 1 might
//        // be a national prefix, so don't remove it when parsing.
//        let randomNumber:PhoneNumber = PhoneNumber()
//        randomNumber.setCountryCode(41).setNationalNumber(6502530000)
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch(randomNumber, secondString:"1-650-253-0000"))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testIsNumberMatchShortNsnMatches() {
//        var error:NSError?
//        // Short NSN matches with the country not specified for either one or both numbers.
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"331 6005"))
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"tel:331-6005phone-context=abc.nz"))
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"tel:331-6005isub=1234phone-context=abc.nz"))
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"tel:331-6005isub=1234phone-context=abc.nza=%A1"))
//        // We did not know that the "0" was a national prefix since neither number has a country code,
//        // so this is considered a SHORT_NSN_MATCH.
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("3 331-6005", secondString:"03 331 6005"))
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("3 331-6005", secondString:"331 6005"))
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("3 331-6005", secondString:"tel:331-6005phone-context=abc.nz"))
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("3 331-6005", secondString:"+64 331 6005"))
//        // Short NSN match with the country specified.
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("03 331-6005", secondString:"331 6005"))
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("1 234 345 6789", secondString:"345 6789"))
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("+1 (234) 345 6789", secondString:"345 6789"))
//        // NSN matches, country calling code omitted for one number, extension missing for one.
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch("+64 3 331-6005", secondString:"3 331 6005#1234"))
//        // One has Italian leading zero, one does not.
//        let italianNumberOne:PhoneNumber = PhoneNumber().setCountryCode(39).setNationalNumber(1234).setItalianLeadingZero(true)
//        let italianNumberTwo:PhoneNumber = PhoneNumber().setCountryCode(39).setNationalNumber(1234)
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch(italianNumberOne, secondNumber:italianNumberTwo))
//        // One has an extension, the other has an extension of "".
//        italianNumberOne.setExtension("1234").clearItalianLeadingZero()
//        italianNumberTwo.setExtension("")
//        XCTAssertEqual(MatchType.SHORT_NSN_MATCH, phoneUtil.isNumberMatch(italianNumberOne, secondNumber:italianNumberTwo))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//
//    func testCanBeInternationallyDialled() {
//        var error:NSError?
//        // We have no-international-dialling rules for the US in our test metadata that say that
//        // toll-free numbers cannot be dialled internationally.
//        XCTAssertFalse(phoneUtil.canBeInternationallyDialled(US_TOLLFREE))
//        
//        // Normal US numbers can be internationally dialled.
//        XCTAssertTrue(phoneUtil.canBeInternationallyDialled(US_NUMBER))
//        
//        // Invalid number.
//        XCTAssertTrue(phoneUtil.canBeInternationallyDialled(US_LOCAL_NUMBER))
//        
//        // We have no data for NZ - should return true.
//        XCTAssertTrue(phoneUtil.canBeInternationallyDialled(NZ_NUMBER))
//        XCTAssertTrue(phoneUtil.canBeInternationallyDialled(INTERNATIONAL_TOLL_FREE))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//    
//    func testIsAlphaNumber() {
//        var error:NSError?
//        XCTAssertTrue(phoneUtil.isAlphaNumber("1800 six-flags"))
//        XCTAssertTrue(phoneUtil.isAlphaNumber("1800 six-flags ext. 1234"))
//        XCTAssertTrue(phoneUtil.isAlphaNumber("+800 six-flags"))
//        XCTAssertTrue(phoneUtil.isAlphaNumber("180 six-flags"))
//        XCTAssertFalse(phoneUtil.isAlphaNumber("1800 123-1234"))
//        XCTAssertFalse(phoneUtil.isAlphaNumber("1 six-flags"))
//        XCTAssertFalse(phoneUtil.isAlphaNumber("18 six-flags"))
//        XCTAssertFalse(phoneUtil.isAlphaNumber("1800 123-1234 extension: 1234"))
//        XCTAssertFalse(phoneUtil.isAlphaNumber("+800 1234-1234"))
//        XCTAssertNil(error, "Should not have thrown an exception: \(error)")
//    }
//    
//    func testIsMobileNumberPortableRegion() {
//        XCTAssertTrue(phoneUtil.isMobileNumberPortableRegion(RegionCode.US))
//        XCTAssertTrue(phoneUtil.isMobileNumberPortableRegion(RegionCode.GB))
//        XCTAssertFalse(phoneUtil.isMobileNumberPortableRegion(RegionCode.AE))
//        XCTAssertFalse(phoneUtil.isMobileNumberPortableRegion(RegionCode.BS))
//    }
}

//class PhoneNumberUtil_JavascriptTests: PhoneNumberUtil_SwiftTests {
//    override var driver:PhoneNumberUtil {
//        return PhoneNumberUtilJavascript.getInstance()
//    }
//}
