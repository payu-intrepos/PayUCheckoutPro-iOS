//
//  ContentView.swift
//  PayUCheckoutProWithSwiftUI
//
//  Created by Amit Salaria on 20/02/23.
//

import SwiftUI
import PayUCheckoutProKit
import PayUCheckoutProBaseKit
import PayUParamsKit
import PayUBizCoreKit
import PayULoggerKit
import UIKit

let keySalt = [["3TnMpV", "g0nGFe03", Environment.production],
               ["gtKFFx", "<Please enter your salt here>", Environment.test]]

let indexKeySalt = 0
struct ContentView: View {
    
    @State var labelWidth: CGFloat? = nil
       @State var username = ""
       @State var password = ""
    
    let delegate = PayUCheckoutProDelegateClass()
 
  

    var body: some View {
        
        
        VStack{
            TextField("Merchant Key", text: .constant(""))
                .padding(.all)
                .keyboardType(.default)
            
            
            
            
            
            Button(action: {
                openCheckoutPro()
            }) {
                Text("Open CheckoutPro")
            }
        }
        .padding()
    }
    
    func openCheckoutPro() {
        let payUConfig = PayUCheckoutProConfig()
        payUConfig.merchantName = "Umang Enterprises";
//        payUConfig.paymentModesOrder = [self getPreferredPaymentMode];
        payUConfig.autoSelectOtp = true;
        payUConfig.merchantResponseTimeout = 8;

        let paymentParam = PayUPaymentParam(
            key: keySalt[indexKeySalt][0] as? String ?? "",
            transactionId: Utils.txnId(),
            amount: "1",
            productInfo: "new",
            firstName: "abc",
            email: "abc@email.com",
            phone: "9876543210",
            surl: "https://payu.herokuapp.com/ios_success",
            furl: "https://payu.herokuapp.com/ios_failure",
            environment: .production
        )
        
        paymentParam.userCredential = "umang:arya"
        paymentParam.userToken = "test"

        PayULog.shared.logLevel = .verbose
        PayUCheckoutPro.open(on: rootViewController!, paymentParam: paymentParam, config: payUConfig, delegate: delegate)
    }
     
    var currentKeyWindow: UIWindow? {
      UIApplication.shared.connectedScenes
        .filter { $0.activationState == .foregroundActive }
        .map { $0 as? UIWindowScene }
        .compactMap { $0 }
        .first?.windows
        .filter { $0.isKeyWindow }
        .first
    }

    var rootViewController: UIViewController? {
      currentKeyWindow?.rootViewController
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class PayUCheckoutProDelegateClass: PayUCheckoutProDelegate {
    func onError(_ error: Error?) {
        // handle error scenario
        //            showAlert(title: "Error", message: error?.localizedDescription ?? "")
        print("error\n",error ?? "")
    }
    
    func onPaymentSuccess(response: Any?) {
        // handle success scenario
        //            showAlert(title: "Success", message: "\(response ?? "")")
        print("response\n",response ?? "")
    }
    
    func onPaymentFailure(response: Any?) {
        // handle failure scenario
        //            showAlert(title: "Failure", message: "\(response ?? "")")
        print("response\n",response ?? "")
    }
    
    func onPaymentCancel(isTxnInitiated: Bool) {
        // handle txn cancelled scenario
        // isTxnInitiated == YES, means user cancelled the txn when on reaching bankPage
        // isTxnInitiated == NO, means user cancelled the txn before reaching the bankPage
        let completeResponse = "isTxnInitiated = \(isTxnInitiated)"
        //            showAlert(title: "Cancelled", message: "\(completeResponse)")
        print(completeResponse)
    }
    
    
    func generateHash(for param: DictOfString, onCompletion: @escaping PayUHashGenerationCompletion) {
        let commandName = (param[HashConstant.hashName] ?? "")
        let hashStringWithoutSalt = (param[HashConstant.hashString] ?? "")
        let postSalt = param[HashConstant.postSalt]
        // get hash for "commandName" from server
        // get hash for "hashStringWithoutSalt" from server
        
        // After fetching hash set its value in below variable "hashValue"
        var hashValue = ""
        if let hashType = param[HashConstant.hashType], hashType == HashConstant.V2 {
            hashValue = PayUDontUseThisClass.hmacSHA256(hashStringWithoutSalt, withKey: "g0nGFe03")
        } else if commandName == HashConstant.mcpLookup {
            hashValue = Utils.hmacsha1(of: hashStringWithoutSalt, secret: "secret_key")
        } else if let postSalt = postSalt {
            let hashString = hashStringWithoutSalt + "g0nGFe03" + postSalt
            hashValue = Utils.sha512Hex(string: hashString)
        } else {
            hashValue = Utils.sha512Hex(string: (hashStringWithoutSalt + "g0nGFe03"))
        }
        onCompletion([commandName : hashValue])
    }
    
}
