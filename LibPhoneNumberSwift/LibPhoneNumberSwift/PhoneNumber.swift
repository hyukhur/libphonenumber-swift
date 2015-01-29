//
//  PhoneNumber.swift
//  LibPhoneNumberSwift
//
//  Created by Hyuk Hur on 1/28/15.
//  Copyright (c) 2015 Hyuk Hur. All rights reserved.
//

import Foundation

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

}

public func == (lhs: PhoneNumber, rhs: PhoneNumber) -> Bool {
    return false
}
