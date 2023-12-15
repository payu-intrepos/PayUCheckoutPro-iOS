//
//  ContentView.swift
//  PayUCheckoutProWithSwiftUI
//
//  Created by Amit Salaria on 20/02/23.
//

import PayUBizCoreKit
import PayUCheckoutProBaseKit
import PayUCheckoutProKit
import PayULoggerKit
import PayUParamsKit
import SwiftUI
import UIKit

let keySalt = [["3TnMpV", "g0nGFe03", PayUParamsKit.Environment.production],
               ["gtKFFx", "4R38IvwiV57FwVpsgOvTXBdLE4tHUXFW", PayUParamsKit.Environment.test]]
let indexKeySalt = 1

struct ContentView: View {

    @State var labelWidth: CGFloat? = nil
    @State var key = keySalt[indexKeySalt][0] as? String ?? ""
    @State var salt = keySalt[indexKeySalt][1] as? String ?? ""
    @State var environment = Utils.stringyfy(environment: keySalt[indexKeySalt][2])
    @State var delegate: PayUCheckoutProDelegateClass!
    @State private var isDisplayed = false
    @State private var isNetBanking = false
    @State private var isCards = false
    @State private var isEMI = false
    @State private var isUPI = false
    @State private var isWallet = false
    @State var ccdc = ""

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Key")
                        .padding()
                    TextField("key", text: $key)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                }
                HStack {
                    Text("salt")
                        .padding()
                    TextField("salt", text: $salt)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                }
                HStack {
                    Text("env")
                        .padding()
                    TextField("environment", text: $environment)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                }
                Toggle("Enable Enforcement", isOn: $isDisplayed)
                    .onChange(of: isDisplayed) { value in
                        // action...
                        print(value)
                    }
                    .padding()
                    .frame(width: 300, height: 50)
                
                if isDisplayed == true {
                    
                    Toggle("Enforce NetBanking", isOn: $isNetBanking)
                        .onChange(of: isNetBanking) { value in
                            // action...
                            print(value)
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                    
                    Toggle("Enforce Cards", isOn: $isCards)
                        .onChange(of: isCards) { value in
                            // action...
                            print(value)
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                    
                    TextField("Credit/Debit", text: $ccdc)
                        .padding()
                        .frame(width: 250, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(10)
                    
                    Toggle("Enforce EMI", isOn: $isEMI)
                        .onChange(of: isEMI) { value in
                            // action...
                            print(value)
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                    
                    Toggle("Enforce UPI", isOn: $isUPI)
                        .onChange(of: isUPI) { value in
                            // action...
                            print(value)
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                    
                    Toggle("Enforce Wallet", isOn: $isWallet)
                        .onChange(of: isWallet) { value in
                            // action...
                            print(value)
                        }
                        .padding()
                        .frame(width: 300, height: 50)
                }
                
                NavigationLink(destination: ProductCardView(title: "Intorduction to Swift UI", description: "SwiftUI is a declarative programming framework for developing user interfaces for iOS and macOS applications. To see how it compares to existing framework, let's see how user interfaces are built before SwiftUI was introduced.", image: Image("books"), price: 100.00, peopleCount: 1, ingredientCount: 500, category: "Books"){
                    openCheckoutPro()
                }) {
                    Text("Purchase")
                }
                
                .foregroundColor(.white)
                .frame(width: 250, height: 50)
                .background(Color.blue)
                .cornerRadius(10)
                
            }
            .padding()
        }
        .navigationTitle("PayU")
    }

    func openCheckoutPro() {
        let payUConfig = PayUCheckoutProConfig()
        payUConfig.merchantName = "Umang Enterprises"
//        payUConfig.paymentModesOrder = [self getPreferredPaymentMode];
        if isDisplayed == true {
            payUConfig.enforcePaymentList = getEnforcePaymentModesList() // "CARD", "UPI", "WALLET", "EMI",
        }
        payUConfig.autoSelectOtp = true
        payUConfig.merchantResponseTimeout = 8

        let paymentParam = PayUPaymentParam(
            key: key,
            transactionId: Utils.txnId(),
            amount: "100",
            productInfo: "new",
            firstName: "abc",
            email: "abc@email.com",
            phone: "9876543210",
            surl: "https://payu.herokuapp.com/ios_success",
            furl: "https://payu.herokuapp.com/ios_failure",
            environment: Utils.environment(environment: environment)
        )

        paymentParam.userCredential = "umang:arya"
        paymentParam.userToken = "test"

        PayULog.shared.logLevel = .verbose
        delegate = PayUCheckoutProDelegateClass(salt: salt)
        PayUCheckoutPro.open(on: rootViewController!, paymentParam: paymentParam, config: payUConfig, delegate: delegate)
    }

    func getEnforcePaymentModesList() -> [[String: Any]]? {
        var enforcePaymentList = [[String: Any]]()

        var nbEnforcement = [String: Any]()
        nbEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.nb

        var ccdcEnforcement = [String: Any]()
        ccdcEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.card

//        if let cardType = ccdc, !cardType.isEmpty {
//            let cardType = cardType.uppercased() == PaymentParamConstant.cc ? PaymentParamConstant.cc : PaymentParamConstant.dc
//            ccdcEnforcement[PaymentParamConstant.cardType] = cardType
//        }

        var upiEnforcement = [String: Any]()
        upiEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.upi

        var walletEnforcement = [String: Any]()
        walletEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.wallet

        var emiEnforcement = [String: Any]()
        emiEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.emi

        var neftRtgsEnforcement = [String: Any]()
        neftRtgsEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.neftrtgs

        var sodexoEnforcement = [String: Any]()
        sodexoEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.sodexo

        var bnplEnforcement = [String: Any]()
        bnplEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.bnpl

        if isNetBanking == true {
            enforcePaymentList.append(nbEnforcement)
        }

        if isCards == true {
            enforcePaymentList.append(ccdcEnforcement)
        }

        if isUPI == true {
            enforcePaymentList.append(upiEnforcement)
        }

        if isWallet == true {
            enforcePaymentList.append(walletEnforcement)
        }

        if isEMI == true {
            enforcePaymentList.append(emiEnforcement)
        }

        return enforcePaymentList
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

    let salt: String

    init(salt: String) {
        self.salt = salt
    }

    func onError(_ error: Error?) {
        // handle error scenario
        //            showAlert(title: "Error", message: error?.localizedDescription ?? "")
        print("error\n", error ?? "")
    }

    func onPaymentSuccess(response: Any?) {
        // handle success scenario
        //            showAlert(title: "Success", message: "\(response ?? "")")
        print("response\n", response ?? "")
    }

    func onPaymentFailure(response: Any?) {
        // handle failure scenario
        //            showAlert(title: "Failure", message: "\(response ?? "")")
        print("response\n", response ?? "")
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
        if commandName == HashConstant.mcpLookup {
            hashValue = "<hmacsha1 hash for hashStringWithoutSalt and secret>"
        } else if let postSalt = postSalt {
            let hashString = hashStringWithoutSalt + salt + postSalt
            hashValue = "<hmacsha1 hash for hashStringWithoutSalt and secret>"
        } else {
            hashValue = "<hmacsha512 hash for hashStringWithoutSalt and salt>"
        }
        onCompletion([commandName: hashValue])
    }

}
