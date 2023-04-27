//
//  Utils.swift
//  OnePayUSwiftSampleApp
//
//  Created by Umang Arya on 19/03/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

import UIKit
import CommonCrypto
import PayUCheckoutProKit
import PayUCheckoutProBaseKit
import PayUBizCoreKit

class Utils: NSObject {
    
    // START: Remove from github app
    class func sha512Hex(string: String) -> String {
        PayUDontUseThisClass().getHash(string)
    }
    // END: Remove from github app
    
    class func hmacsha1(of string: String, secret: String) -> String {
        PayUDontUseThisClass.hmacsha1(string, secret: secret)
    }

    class func txnId() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMddHHmmss"
        let txnID = "iOS" + formatter.string(from: Date())
        return txnID
    }
    
    class func stringyfy(environment: Any?) -> String {
        guard let environment = environment as? Environment else {
            return ENVIRONMENT_PRODUCTION
        }
        switch environment {
        case .test:
            return ENVIRONMENT_TEST
        default:
            return ENVIRONMENT_PRODUCTION
        }
    }
    
    class func environment(environment: String) -> Environment {
        if environment == ENVIRONMENT_TEST {
            return  Environment.test
        } else {
            return  Environment.production
        }
    }
    
    class func JSONFrom(string: String) -> Any? {
        guard let data = string.data(using: .utf8) else { return nil}
        do {
            return try JSONSerialization.jsonObject(with: data, options: [])
        } catch {
            return nil
        }
    }
    
    class func paymentModeFrom(paymentType: String?, paymentOptionID: String?) -> PaymentMode? {
        var paymentMode: PaymentMode?
        if paymentType == "Cards".lowercased() {
            paymentMode = PaymentMode(paymentType: .ccdc)
        } else if paymentType == "NetBanking".lowercased() {
            paymentMode = PaymentMode(paymentType: .netBanking, paymentOptionID: paymentOptionID ?? "")
        } else if paymentType == "UPI".lowercased() {
            paymentMode = PaymentMode(paymentType: .upi, paymentOptionID: paymentOptionID ?? "")
        } else if paymentType == "Wallet".lowercased() {
            paymentMode = PaymentMode(paymentType: .wallet, paymentOptionID: paymentOptionID ?? "")
        } else if paymentType == "emi".lowercased() {
            paymentMode = PaymentMode(paymentType: .emi, paymentOptionID: paymentOptionID ?? "")
        }
        return paymentMode
    }
    
    class func paymentTypeFrom(paymentType: String?) -> PaymentType? {
        if (paymentType?.caseInsensitiveCompare("Cards") == .orderedSame) {
            return .ccdc
        } else if (paymentType?.caseInsensitiveCompare("NetBanking") == .orderedSame) {
            return .netBanking
        } else if (paymentType?.caseInsensitiveCompare("UPI") == .orderedSame) {
            return .upi
        } else if (paymentType?.caseInsensitiveCompare("Wallet") == .orderedSame) {
            return .wallet
        } else if (paymentType?.caseInsensitiveCompare("emi") == .orderedSame) {
            return .emi
        } else if (paymentType?.caseInsensitiveCompare("SavedCard") == .orderedSame) {
            return .savedCard
        } else if (paymentType?.caseInsensitiveCompare("NeftRtgs") == .orderedSame) {
            return .neftRtgs
        } else if (paymentType?.caseInsensitiveCompare("Sodexo") == .orderedSame) {
            return .sodexo
        } else {
            return nil
        }
    }
    
    class func hexStringToUIColor(hex: String) -> UIColor? {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        cString = String(cString.prefix(6))

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension Date{
    var dateString:String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: self)
    }
}
