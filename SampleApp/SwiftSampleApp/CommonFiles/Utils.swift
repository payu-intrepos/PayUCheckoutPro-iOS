//
//  Utils.swift
//  OnePayUSwiftSampleApp
//
//  Created by Umang Arya on 19/03/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

import UIKit
import CommonCrypto
import PayUCheckoutPro
import PayUCheckoutProBase
import PayUBizCoreSDK

class Utils: NSObject {
    
    class func sha512Hex( string: String) -> String {
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
        if let data = string.data(using: String.Encoding.utf8) {
            let value =  data as NSData
            CC_SHA512(value.bytes, CC_LONG(data.count), &digest)

        }
        var digestHex = ""
        for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }

        return digestHex
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
    
    class func txnId() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMddHHmmss"
        let txnID = "iOS" + formatter.string(from: Date())
        return txnID
    }
    
    class func JSONFrom(string: String) -> Any? {
        guard let data = string.data(using: .utf8) else { return nil}
        do {
            return try JSONSerialization.jsonObject(with: data, options: [])
        } catch {
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
