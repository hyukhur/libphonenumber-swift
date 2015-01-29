//
//  PhoneMetadata.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 1/27/15.
//  Copyright (c) 2015 Hyuk Hur. All rights reserved.
//

import Foundation

public class PhoneMetadata {

    public class NumberFormat {
        public func getPattern() -> String {
            // TODO: should be implemented
            return ""
        }
        public func getFormat() -> String {
            // TODO: should be implemented
            return ""
        }
        public func leadingDigitsPatternSize() -> Int {
            return 1
        }

        public func getLeadingDigitsPattern(index:Int) -> String {
            return ""
        }
    }

    public class PhoneNumberDesc {
        public func getNationalNumberPattern() -> String {
            // TODO: should be implemented
            return ""
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

    public class PhoneMetadata {

    }

    public class PhoneMetadataCollection {
        
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

    public func getNationalPrefixTransformRule() -> String {
        return ""
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
