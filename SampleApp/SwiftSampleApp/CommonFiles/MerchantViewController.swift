//
//  MerchantViewController.swift
//  CheckoutProSwiftSampleApp
//
//  Created by Umang Arya on 14/07/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

import UIKit
import PayUCheckoutProKit
import PayUCheckoutProBaseKit
import PayUParamsKit
import PayUBizCoreKit
import PayUCommonUI

class MerchantViewController: UIViewController {
    // MARK: - Outlets -
    @IBOutlet weak var keyTextField: UITextField!
    @IBOutlet weak var saltTextField: UITextField!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var productInfoTextField: UITextField!
    @IBOutlet weak var surlTextField: UITextField!
    @IBOutlet weak var furlTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var environmentTextField: UITextField!
    @IBOutlet weak var splitPayTF: UITextField!
    @IBOutlet weak var userCredentialTextField: UITextField!
    @IBOutlet weak var txnIDTextField: UITextField!
    @IBOutlet weak var merchantAccessKeyTextField: UITextField!
    @IBOutlet weak var merchantSecretKeyTextField: UITextField!
    @IBOutlet weak var preferredUpiAppsTextField: UITextField!
    @IBOutlet weak var showMerchantLogoSwitch: UISwitch!

    @IBOutlet weak var splitPayStackView: UIStackView!
    //SI
    @IBOutlet weak var siSwitch: UISwitch!
    @IBOutlet weak var billingIntervalTf: UITextField!
    @IBOutlet weak var siEndDateTf: UITextField!
    @IBOutlet weak var siStartDateTf: UITextField!
    @IBOutlet weak var recurringPeriodTf: UITextField!
    @IBOutlet weak var recurringAmountTf: UITextField!
    @IBOutlet weak var remarksTextField: UITextField!
    @IBOutlet weak var freeTrialSwitch: UISwitch!
    
    // Customization
    @IBOutlet weak var primaryColorTextField: UITextField!
    @IBOutlet weak var secondaryColorTextField: UITextField!
    @IBOutlet weak var merchantNameTextField: UITextField!
    @IBOutlet weak var logoNameTextField: UITextField!
    @IBOutlet weak var showCancelDialogOnCheckoutScreenSwitch: UISwitch!
    @IBOutlet weak var showCancelDialogOnPaymentScreenSwitch: UISwitch!
    @IBOutlet weak var splitPaySwitch: UISwitch!
    @IBOutlet weak var enableNativeOTPSwitch: UISwitch!
    @IBOutlet weak var enableSavedCardSwitch: UISwitch!
    @IBOutlet weak var orderDetailTextView: UITextView!
    @IBOutlet weak var l1OptionTextView: UITextView!
    @IBOutlet weak var skuOfferDetailTextView: UITextView!
    @IBOutlet weak var customNotesDetailTextView: UITextView!
    
    // CB Configuration
    @IBOutlet weak var autoOTPSelectSwitch: UISwitch!
    @IBOutlet weak var userTokenTextField: UITextField!
    @IBOutlet weak var merchantResponseTimeoutTextField: UITextField!
    @IBOutlet weak var autoOTPSubmitSwitch: UISwitch!
    
    // Sodexo Card Configuration
    @IBOutlet weak var sodexoCardSourceIdTextField: UITextField!
    @IBOutlet weak var sodexoCardBalanceAPITimeoutTextField: UITextField!
    
    // Enforcement
    @IBOutlet weak var enforceCardsSwitch: UISwitch!
    @IBOutlet weak var enforceNBSwitch: UISwitch!
    @IBOutlet weak var enforceWalletSwitch: UISwitch!
    @IBOutlet weak var enforceEMISwitch: UISwitch!
    @IBOutlet weak var enforceUPISwitch: UISwitch!
    @IBOutlet weak var enforceSodexoSwitch: UISwitch!
    @IBOutlet weak var enforceNeftRtgsSwitch: UISwitch!
    @IBOutlet weak var enforceBNPLSwitch: UISwitch!
    @IBOutlet weak var enforceCardTypeTextField: UITextField!
    @IBOutlet weak var subventionAmountTextField: UITextField!
    @IBOutlet weak var enableEnforcementSwitch: UISwitch!
    @IBOutlet weak var enforcementSwitchesStackView: UIStackView!
    // User Cancellation View
    @IBOutlet weak var showUserCancellationDialogueSwitch: UISwitch!
    // Font
    @IBOutlet weak var useCustomFontSwitch: UISwitch!
    @IBOutlet weak var customFontSwitchesStackView: UIStackView!
    @IBOutlet weak var customFontSwitch1: UISwitch!
    @IBOutlet weak var customFontSwitch2: UISwitch!
    //CF
    @IBOutlet weak var addtionalChargeTextField: UITextField!
    @IBOutlet weak var perAdditionalChargeTextField: UITextField!
    @IBOutlet weak var cfSwitch: UISwitch!
    //TPV
    @IBOutlet weak var tpvSwitch: UISwitch!
    @IBOutlet weak var tpvAccountNumberField: UITextField!
    @IBOutlet weak var tpvIfscCodes: UITextField!
    // MARK: - Variables -

    let keySalt = [
        ["3TnMpV", "<Please enter your salt here>", Environment.production],
        ["gtKFFx", "<Please enter your salt here>", Environment.test]
    ]

    let indexKeySalt = 0
    var amount: String = "1"
    var subventionAmount: String = "10000"

    var productInfo: String = "Nokia"
    var surl: String = "https://cbjs.payu.in/sdk/success"
    var furl: String = "https://cbjs.payu.in/sdk/failure"
    var firstName: String = "Umang"
    var email: String = "umang@arya.com"
    var phoneNumber: String = "9811924582"
    var userCredential: String = "amit:salaria"
    var primaryColor: String = "#25272C"
    var secondaryColor: String = "#ffffff"
    var merchantName: String = "PayU"
    var logoName: String = "Logo"
    var showCancelDialogOnCheckoutScreen: Bool = true
    var showCancelDialogOnPaymentScreen: Bool = true
    var orderDetail: String = "[{\"GST\":\"5%\"},{\"Delivery Date\":\"25 Dec\"},{\"Status\":\"In Progress\"}]"
    var l1Option: String = "[{\"NetBanking\":\"\"},{\"BNPL\":\"LAZYPAY\"},{\"EMI\":\"\"},{\"UPI\":\"TEZ\"},{\"Wallet\":\"PHONEPE\"}]"
    var customNotes: String = "[{\"Hi, This is a custom note for payment modes.\":[]},{\"Hi, This is a custom note for payment options.\":[\"Cards\",\"NetBanking\",\"upi\",\"Wallet\",\"Sodexo\",\"NeftRtgs\",\"EMI\",\"SavedCard\"]}]"
    var splitPayRequest: String = "{\"type\":\"absolute\",\"splitInfo\":{\"imAJ7I\":{\"aggregatorSubTxnId\":\"Testchild123\",\"aggregatorSubAmt\":\"5\"},\"qOoYIv\":{\"aggregatorSubTxnId\":\"Testchild098\",\"aggregatorSubAmt\":\"5\"}}}"
    var autoOTPSelect: Bool = true
    var userToken: String = "anshul_bajpai_token"
    var merchantResponseTimeout: String = "1"
    var sodexoResponseTimeout: String = "4"
    var recurringAmount = "1"
    var recurringPeriod: PayUBillingCycle = .monthly
    var siStartDate:Date = Date()
    var siEndDate:Date = Date()
    var billingInterval = "1"
    var isFreeTrial = false
    var remarksText: String? = nil
    var datePicker : UIDatePicker!
    let toolBar = UIToolbar()
    var merchantAccessKey: String = "E5ABOXOWAAZNXB6JEF5Z"
    let merchantSecretKey = "e425e539233044146a2d185a346978794afd7c66"
    let sodexoSourceId = "src_5521693f-56b6-4102-8af7-cf716610f04a"
    let walletURN = "1000001"
    var selectFontFamily: String = ""
    let skuOfferDetail = "{\"items\":2,\"sku_details\":[{\"sku_id\":\"Boat123\",\"sku_name\":\"Protein 1\",\"amount_per_sku\":\"10000\",\"quantity\":1,\"offer_key\":[]},{\"sku_id\":\"1112\",\"sku_name\":\"Protein 2\",\"amount_per_sku\":\"5000\",\"quantity\":1,\"offer_key\":[]}]}"

    @IBOutlet weak var nextButton: UIButton!
    // MARK: - View Controller Lifecycle Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
        setUpValuesInTextFields()
        updateButtonColor()
        dismissKeyboardOnTapOutsideTextField()
        setUpDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txnIDTextField.text = Utils.txnId()
        self.registerKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unRegisterKeyboardNotification()
    }
    
    public func load(data: String) {
        
    }
    
    func setUpDatePicker(){
        // DatePicker
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: view.frame.size.width, height: 200))
        self.datePicker?.backgroundColor = UIColor.white
        self.datePicker?.datePickerMode = UIDatePicker.Mode.date
        datePicker?.center = view.center
        if #available(iOS 13.4, *) {
            datePicker?.preferredDatePickerStyle = .wheels
        }
        // ToolBar
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.cancelClick))
        toolBar.setItems([cancelButton, spaceButton], animated: true)
        toolBar.isUserInteractionEnabled = true
        siStartDateTf?.inputAccessoryView = toolBar
        siEndDateTf?.inputAccessoryView = toolBar
        //add datepicker to textField
        siStartDateTf?.inputView = datePicker
        siEndDateTf?.inputView = datePicker
        self.toolBar.isHidden = false
        //Default current date
        siStartDateTf?.text =  Date().dateString
        siEndDateTf?.text =  Date().dateString
        self.datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .valueChanged)
    }
    
    
    @objc func cancelClick () {
        self.siStartDateTf.resignFirstResponder()
        self.siEndDateTf.resignFirstResponder()
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        if siStartDateTf.isFirstResponder{
            self.siStartDateTf.text = sender.date.dateString
            self.siStartDate = sender.date
        }
        else if siEndDateTf.isFirstResponder{
            self.siEndDateTf.text = sender.date.dateString
            self.siEndDate = sender.date
        }
    }
    
    @IBAction func enableSplitPay(_ sender: UISwitch) {
        splitPayStackView.isHidden = !sender.isOn
    }
    
    @IBAction func billingCycleBtnAxn(_ sender: Any) {
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for billingCycle in PayUBillingCycle.allCases{
            sheet.addAction(UIAlertAction(title: PPKUtils.billingCycleToString(billingCycle), style: .default, handler: { (action) in
                self.recurringPeriod = billingCycle
                self.recurringPeriodTf.text = action.title
            }))
        }
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let popoverController = sheet.popoverPresentationController {
            popoverController.sourceView = self.view
            if UIDevice.current.userInterfaceIdiom == .pad {
                popoverController.sourceRect = CGRect.init(x:self.view.bounds.midX-150, y:self.view.bounds.midY-100,width:0,height:0)
            }
        }
        self.present(sheet, animated: true, completion: nil)
    }
    
}

// MARK: - Private Methods -
extension MerchantViewController {
    private func updateButtonColor() {
        nextButton.backgroundColor = Utils.hexStringToUIColor(hex: primaryColorTextField.text ?? "")
        nextButton.setTitleColor(Utils.hexStringToUIColor(hex: secondaryColorTextField.text ?? ""), for: .normal)
    }
    private func setupTextFields() {
        primaryColorTextField.addTarget(self, action: #selector(primaryColorTextFieldTapped), for: .allEvents)
        secondaryColorTextField.addTarget(self, action: #selector(secondaryColorTextFieldTapped), for: .allEvents)
    }
    
    private func setUpValuesInTextFields() {
        keyTextField.text = keySalt[indexKeySalt][0] as? String
        saltTextField.text = keySalt[indexKeySalt][1] as? String
        amountTextField.text = amount
        productInfoTextField.text = productInfo
        surlTextField.text = surl
        furlTextField.text = furl
        firstNameTextField.text = firstName
        emailTextField.text = email
        phoneTextField.text = phoneNumber
        environmentTextField.text = Utils.stringyfy(environment: keySalt[indexKeySalt][2] as? Environment)
        userCredentialTextField.text = userCredential
        primaryColorTextField.text = primaryColor
        secondaryColorTextField.text = secondaryColor
        merchantNameTextField.text = merchantName
        logoNameTextField.text = logoName
        showCancelDialogOnCheckoutScreenSwitch.isOn = showCancelDialogOnCheckoutScreen
        showCancelDialogOnPaymentScreenSwitch.isOn = showCancelDialogOnPaymentScreen
        orderDetailTextView.text = orderDetail
        l1OptionTextView.text = l1Option
        skuOfferDetailTextView.text = skuOfferDetail
        customNotesDetailTextView.text = customNotes
        autoOTPSelectSwitch.isOn = autoOTPSelect
        userTokenTextField.text = userToken
        merchantResponseTimeoutTextField.text = merchantResponseTimeout
        sodexoCardBalanceAPITimeoutTextField.text = sodexoResponseTimeout
        recurringAmountTf.text = recurringAmount
        recurringPeriodTf.text = PPKUtils.billingCycleToString(recurringPeriod)
        billingIntervalTf.text = billingInterval
        remarksTextField.text = remarksText
        freeTrialSwitch.isOn = isFreeTrial
        primaryColorTextFieldTapped()
        secondaryColorTextFieldTapped()
        merchantAccessKeyTextField.text = merchantAccessKey
        merchantSecretKeyTextField.text = merchantSecretKey
        sodexoCardSourceIdTextField.text = sodexoSourceId
        splitPayTF.text = splitPayRequest
        subventionAmountTextField.text = subventionAmount
    }
    
    private func getPaymentParam() -> PayUPaymentParam{
        var key  = keyTextField.text ?? ""
        if let intKey = Int(key), intKey >= 0 , intKey < keySalt.count {
            key = keySalt[intKey][0] as? String ?? ""
            saltTextField.text = keySalt[intKey][1] as? String
            environmentTextField.text = Utils.stringyfy(environment: keySalt[intKey][2] as? Environment)
        }
        let paymentParam = PayUPaymentParam(key: key,
                                            transactionId: txnIDTextField.text ?? "",
                                            amount: amountTextField.text ?? "",
                                            productInfo:  productInfo,
                                            firstName: firstNameTextField.text ?? "",
                                            email: emailTextField.text ?? "",
                                            phone: phoneTextField.text ?? "",
                                            surl: surlTextField.text ?? "",
                                            furl: furlTextField.text ?? "",
                                            environment: Utils.environment(environment: environmentTextField.text ?? ""))
        if let recurringAmount = self.recurringAmountTf.text,
           let frequency = billingIntervalTf.text,
           let frequencyInt = Int(frequency),
           siSwitch.isOn{
            let siInfo = PayUSIParams(billingAmount: recurringAmount,
                                      paymentStartDate: self.siStartDate,
                                      paymentEndDate: self.siEndDate,
                                      billingCycle: recurringPeriod,
                                      billingInterval: NSNumber(value: frequencyInt))
            siInfo.remarks = remarksTextField.text?.isEmpty ?? true ? nil : remarksTextField.text
            siInfo.isFreeTrial = freeTrialSwitch.isOn
            
            siInfo.billingLimit = "ON"
            siInfo.billingRule = "MAX"
            
            paymentParam.siParam = siInfo
        }
        if splitPaySwitch.isOn {
            paymentParam.splitPaymentDetails = splitPayTF.text
        }
        paymentParam.userCredential = userCredentialTextField.text
        paymentParam.enableNativeOTP = self.enableNativeOTPSwitch.isOn
        paymentParam.additionalParam[PaymentParamConstant.udf1] = "udf11"
        paymentParam.additionalParam[PaymentParamConstant.udf2] = "udf22"
        paymentParam.additionalParam[PaymentParamConstant.udf3] = "udf33"
        paymentParam.additionalParam[PaymentParamConstant.udf4] = "udf44"
        paymentParam.additionalParam[PaymentParamConstant.udf5] = "udf55"
        paymentParam.additionalParam[PaymentParamConstant.merchantAccessKey] = merchantAccessKeyTextField.text ?? ""
        paymentParam.userToken = userTokenTextField.text
        
        paymentParam.additionalParam[PaymentParamConstant.sourceId] = sodexoCardSourceIdTextField.text
        paymentParam.additionalParam[PaymentParamConstant.walletURN] = walletURN
        paymentParam.subventionAmount = subventionAmountTextField.text

        // For TPV
        if tpvSwitch.isOn {
            let accountNumbers : [Substring] = tpvAccountNumberField?.text?.split(separator: ",") ?? []
            let ifscCodes: [Substring] = (tpvIfscCodes?.text?.split(separator: ",")) ?? []
            
            var payuBeneficieryDetailsList = [PayUBeneficiaryParams]()
            
            if !ifscCodes.isEmpty {
                for (index, data) in ifscCodes.enumerated() {
                    var accountNum = ""
                    if accountNumbers.indices.contains(index) {
                        accountNum = String(accountNumbers[index])
                    }
                    let ifscCode = String(ifscCodes[index])
                    
                    let beneficiaryDetails1 = PayUBeneficiaryParams(
                        beneficiaryAccountNumber: accountNum,
                        beneficiaryIFSC: ifscCode)
                    
                    payuBeneficieryDetailsList.append(beneficiaryDetails1)
                }
            } else {
                for (index, data) in accountNumbers.enumerated() {
                    var ifscCode = ""
                    if ifscCodes.indices.contains(index) {
                        ifscCode = String(ifscCodes[index])
                    }
                    let accountNum = String(accountNumbers[index])
                    
                    let beneficiaryDetails1 = PayUBeneficiaryParams(
                        beneficiaryAccountNumber: accountNum,
                        beneficiaryIFSC: ifscCode)
                    
                    payuBeneficieryDetailsList.append(beneficiaryDetails1)
                }
            }
            paymentParam.payuBeneficieryDetails = payuBeneficieryDetailsList
        }
//        var payuBeneficieryDetailsList = [PayUBeneficiaryParams]()
//        let beneficiaryDetails1 = PayUBeneficiaryParams(beneficiaryAccountNumber: "12345678900",
//                                                       beneficiaryIFSC: "UTIB1234")
//        let beneficiaryDetails2 = PayUBeneficiaryParams(beneficiaryAccountNumber: "12345678901",
//                                                       beneficiaryIFSC: "HDFC1234")
//        payuBeneficieryDetailsList.append(beneficiaryDetails1)
//        payuBeneficieryDetailsList.append(beneficiaryDetails2)
//        paymentParam.payuBeneficieryDetails = payuBeneficieryDetailsList
        
        if cfSwitch.isOn {
            paymentParam.additionalCharges = addtionalChargeTextField.text ?? ""
            paymentParam.percentageAdditionalCharges = perAdditionalChargeTextField.text ?? ""
        }
//        paymentParam.additionalCharges = "SBIB:20,NB:10,cash:30,CC:15,UPI:25"
//        paymentParam.percentageAdditionalCharges = "DC:20,NB:15,SBIB:20,INTENT:20"
        
        return paymentParam
    }
    
    private func getPaymentParamDict() -> [String: Any]{
        var key  = keyTextField.text ?? ""
        if let intKey = Int(key), intKey >= 0 , intKey < keySalt.count {
            key = keySalt[intKey][0] as? String ?? ""
            saltTextField.text = keySalt[intKey][1] as? String
            environmentTextField.text = Utils.stringyfy(environment: keySalt[intKey][2] as? Environment)
        }
    
        var params: [String: Any] = [:]
        var paymentParamDict: [String: Any] = [:]
        
        paymentParamDict["key"] = key
        paymentParamDict["transactionId"] = txnIDTextField.text ?? ""
        paymentParamDict["amount"] = amountTextField.text ?? ""
        paymentParamDict["productInfo"] = productInfo
        paymentParamDict["firstName"] = firstNameTextField.text ?? ""
        paymentParamDict["email"] = emailTextField.text ?? ""
        paymentParamDict["phone"] = phoneTextField.text ?? ""
        paymentParamDict["ios_surl"] = surlTextField.text ?? ""
        paymentParamDict["ios_furl"] = furlTextField.text ?? ""
        paymentParamDict["environment"] = "1"
        
        if let recurringAmount = self.recurringAmountTf.text,
           let frequency = billingIntervalTf.text,
           let frequencyInt = Int(frequency),
           siSwitch.isOn{
            var siInfoDict: [String: Any] = [:]
            
            siInfoDict["billingAmount"] = recurringAmount
            siInfoDict["paymentStartDate"] = self.siStartDate
            siInfoDict["paymentEndDate"] = self.siEndDate
            siInfoDict["billingCycle"] = recurringPeriod
            siInfoDict["billingInterval"] = NSNumber(value: frequencyInt)
            siInfoDict["remarks"] = remarksTextField.text?.isEmpty ?? true ? nil : remarksTextField.text
            siInfoDict["isFreeTrial"] = freeTrialSwitch.isOn
            siInfoDict["billingLimit"] = "ON"
            siInfoDict["billingRule"] = "MAX"
         
            
            paymentParamDict["payUSIParams"] =  siInfoDict
        }
        
        if splitPaySwitch.isOn {
            paymentParamDict["splitPaymentDetails"] = splitPayTF.text
        }
        paymentParamDict["userCredential"] = userCredentialTextField.text
        paymentParamDict["enableNativeOTP"] = self.enableNativeOTPSwitch.isOn
        paymentParamDict["udf1"] = "udf11"
        paymentParamDict["udf2"] = "udf22"
        paymentParamDict["udf3"] = "udf33"
        paymentParamDict["udf4"] = "udf44"
        paymentParamDict["udf5"] = "udf55"
        paymentParamDict["merchantAccessKey"] = merchantAccessKeyTextField.text ?? ""
        paymentParamDict["userToken"] = userTokenTextField.text
        paymentParamDict["sourceId"] = sodexoCardSourceIdTextField.text
        paymentParamDict["walletUrn"] = walletURN
        paymentParamDict["subventionAmount"] = subventionAmountTextField.text
 
        // For TPV
        var payuBeneficieryDetailsList = [[String: Any]]()
        let beneficiaryDetails1 = ["beneficiaryAccount":"12345678900","beneficiaryIfsc":"UTIB1234"]
        let beneficiaryDetails2 = ["beneficiaryAccount":"12345678901","beneficiaryIfsc":"HDFC1234"]
        payuBeneficieryDetailsList.append(beneficiaryDetails1)
        payuBeneficieryDetailsList.append(beneficiaryDetails2)
        
        paymentParamDict["beneficiaryDetails"] = payuBeneficieryDetailsList
        
        params["payUPaymentParams"] = paymentParamDict
        return params
    }
    
    @IBAction open func enableEnforcementSwitch(_ sender: UISwitch) {
        enforcementSwitchesStackView.isHidden = !sender.isOn
        view.layoutIfNeeded()
    }
    
    @IBAction open func customFontSwitch(_ sender: UISwitch) {
        switch sender.tag {
        case 1:
            selectFontFamily = "JosefinSans"
            customFontSwitch2.isOn = false
        case 2:
            selectFontFamily = "DancingScript"
            customFontSwitch1.isOn = false
        default:
            selectFontFamily = "InvalidFontName"
            customFontSwitch1.isOn = false
            customFontSwitch2.isOn = false
            customFontSwitchesStackView.isHidden = !customFontSwitchesStackView.isHidden
        }
        view.layoutIfNeeded()
    }

    private func addCheckoutProConfigurations(config: PayUCheckoutProConfig) {
        config.merchantName = merchantNameTextField.text
        config.merchantLogo = UIImage(named: logoNameTextField.text ?? "")
        config.showMerchantLogo = showMerchantLogoSwitch.isOn
        config.paymentModesOrder = getPreferredPaymentMode()
        config.cartDetails = cartDetails()
        // If you want to set both color
//        if let primary = Utils.hexStringToUIColor(hex: primaryColorTextField.text ?? ""), let secondary = Utils.hexStringToUIColor(hex: secondaryColorTextField.text ?? "") {
//            config.customiseUI(primaryColor: primary, secondaryColor: secondary)
//        }
        // Mandatory Color
        if let primaryColorText = primaryColorTextField.text, !primaryColorText.isEmpty,
           let primaryColor = Utils.hexStringToUIColor(hex: primaryColorText) {
            config.setPrimaryColor(primaryColor)
        }
        // Optional Color
        if let secondaryColorText = secondaryColorTextField.text, !secondaryColorText.isEmpty,
           let secondaryColor = Utils.hexStringToUIColor(hex: secondaryColorText) {
            config.setSecondaryColor(secondaryColor)
        }
        config.showExitConfirmationOnPaymentScreen = showCancelDialogOnPaymentScreenSwitch.isOn
        config.showExitConfirmationOnCheckoutScreen = showCancelDialogOnCheckoutScreenSwitch.isOn
        
        // CB Configurations
        config.autoSelectOtp = autoOTPSelectSwitch.isOn
        config.autoSubmitOtp = autoOTPSubmitSwitch.isOn
        if let merchantResponseTimeoutStr = merchantResponseTimeoutTextField.text,
           let merchantResponseTimeout = TimeInterval(merchantResponseTimeoutStr) {
            config.merchantResponseTimeout = merchantResponseTimeout
        }
        
        // Sodexo Configurations
        if let sodexoCardBalanceAPITimeoutStr = sodexoCardBalanceAPITimeoutTextField.text,
           let sodexoCardBalanceAPITimeout = TimeInterval(sodexoCardBalanceAPITimeoutStr) {
            config.sodexoCardBalanceAPITimeout = sodexoCardBalanceAPITimeout
        }
        
        // Custom Notes Configurations
        config.customNotes = getCustomNotes()
        
        // Custom Notes Configurations
        if enableEnforcementSwitch.isOn {
            config.enforcePaymentList = getEnforcePaymentModesList()
        }
        
        // User Cancellation Feedback Configurations
        //config.showUserCancellationDialogue = showUserCancellationDialogueSwitch.isOn

        // Language
        config.merchantLanguage = .english
        
        // Font Family
        if !selectFontFamily.isEmpty {
            config.fontfamily = PayUFontFamily(
                regular: "\(selectFontFamily)-Regular",
                medium: "\(selectFontFamily)-Medium",
                semibold: "\(selectFontFamily)-SemiBold",
                bold: "\(selectFontFamily)-Bold"
            )
        }
        config.enableSavedCard = enableSavedCardSwitch.isOn
        config.upiAppsOrder = preferredUpiAppsTextField.text ?? ""
    }
    
    func getEnforcePaymentModesList() -> [[String: Any]]? {
        var enforcePaymentList = [[String: Any]]()
        
        var nbEnforcement = [String: Any]()
        nbEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.nb
        
        var ccdcEnforcement = [String: Any]()
        ccdcEnforcement[PaymentParamConstant.paymentType] = PaymentParamConstant.card
        
        if let cardType = enforceCardTypeTextField.text, !cardType.isEmpty {
            let cardType = cardType.uppercased() == PaymentParamConstant.cc ? PaymentParamConstant.cc : PaymentParamConstant.dc
            ccdcEnforcement[PaymentParamConstant.cardType] = cardType
        }
        
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
        
        if enforceNBSwitch.isOn {
            enforcePaymentList.append(nbEnforcement)
        }
        
        if enforceCardsSwitch.isOn {
            enforcePaymentList.append(ccdcEnforcement)
        }
        
        if enforceUPISwitch.isOn {
            enforcePaymentList.append(upiEnforcement)
        }
        
        if enforceWalletSwitch.isOn {
            enforcePaymentList.append(walletEnforcement)
        }
        
        if enforceEMISwitch.isOn {
            enforcePaymentList.append(emiEnforcement)
        }
        
        if enforceNeftRtgsSwitch.isOn {
            enforcePaymentList.append(neftRtgsEnforcement)
        }
        
        if enforceSodexoSwitch.isOn {
            enforcePaymentList.append(sodexoEnforcement)
        }
        
        if enforceBNPLSwitch.isOn {
            enforcePaymentList.append(bnplEnforcement)
        }
        
        return enforcePaymentList
    }
    
    func getCustomNotes() -> [PayUCustomNote]? {
        if let notesJSON = Utils.JSONFrom(string: customNotesDetailTextView.text) as? [[String: Any]] {
            var customNotes = [PayUCustomNote]()
            for json in notesJSON {
                for (key, value) in json {
                    if let paymentModes = (value as? [String])?.compactMap({ Utils.paymentTypeFrom(paymentType: $0)}) {
                        let customNote = PayUCustomNote()
                        customNote.note = key
                        customNote.noteCategories =  paymentModes
                        customNotes.append(customNote)
                    }
                }
            }
            return customNotes
        }
        return nil
    }
    
    func getPreferredPaymentMode() -> [PaymentMode]? {
        if let preferredPaymentModesJSON = Utils.JSONFrom(string: l1OptionTextView.text) as? [[String : String]] {
            var preferredPaymentModes: [PaymentMode] = []
            for eachPreferredPaymentMode in preferredPaymentModesJSON {
                if let paymentMode = Utils.paymentModeFrom(paymentType: eachPreferredPaymentMode.keys.first?.lowercased(), paymentOptionID: eachPreferredPaymentMode.values.first) {
                    preferredPaymentModes.append(paymentMode)
                }
            }
            return preferredPaymentModes
        }
        return nil
    }
    
    func cartDetails() -> [[String: String]]? {
        if let cartDetails = Utils.JSONFrom(string: orderDetailTextView.text) as? [[String : String]] {
            return cartDetails
        }
        return nil
    }
    
}

// MARK: - PayUCheckoutPro Delegate Methods -
extension MerchantViewController: PayUCheckoutProDelegate {
    func onError(_ error: Error?) {
        // handle error scenario
        navigationController?.popToViewController(self, animated: true)
        showAlert(title: "Error", message: error?.localizedDescription ?? "")
    }
    
    func onPaymentSuccess(response: Any?) {
        // handle success scenario
        navigationController?.popToViewController(self, animated: true)
        showAlert(title: "Success", message: "\(response ?? "")")
        print("response\n",response ?? "")
    }
    
    func onPaymentFailure(response: Any?) {
        // handle failure scenario
        navigationController?.popToViewController(self, animated: true)
        showAlert(title: "Failure", message: "\(response ?? "")")
        print("response\n",response ?? "")
    }
    
    func onPaymentCancel(isTxnInitiated: Bool) {
        // handle txn cancelled scenario
        // isTxnInitiated == YES, means user cancelled the txn when on reaching bankPage
        // isTxnInitiated == NO, means user cancelled the txn before reaching the bankPage
        navigationController?.popToViewController(self, animated: true)
        let completeResponse = "isTxnInitiated = \(isTxnInitiated)"
        showAlert(title: "Cancelled", message: "\(completeResponse)")
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
            hashValue = PayUDontUseThisClass.hmacSHA256(hashStringWithoutSalt, withKey: saltTextField.text ?? "")
        } else if commandName == HashConstant.mcpLookup {
            hashValue = Utils.hmacsha1(of: hashStringWithoutSalt, secret: (merchantSecretKeyTextField.text ?? ""))
        } else if let postSalt = postSalt {
            let hashString = hashStringWithoutSalt + (saltTextField.text ?? "") + postSalt
            hashValue = Utils.sha512Hex(string: hashString)
        } else {
            hashValue = Utils.sha512Hex(string: (hashStringWithoutSalt + (saltTextField.text ?? "")))
        }
        onCompletion([commandName : hashValue])
    }
    
    func showAlert(title: String, message: String) {
        txnIDTextField.text = Utils.txnId()
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func refundTransactions() {
        var txnIds:[String] = []
        var payuIds:[String] = []
        for id in 0 ..< txnIds.count {
            let param = PayUModelPaymentParams()
            param.transactionID = txnIds[id]
            param.key = keyTextField.text
            param.paymentId = payuIds[id]
            param.amount = "1"
            PayUWebServiceResponse().refundTransaction(param) { response, error, any in
                print(response)
            }
        }
        
    }
}

extension MerchantViewController: UIGestureRecognizerDelegate {
    // MARK: - Dismiss Keyboard On Tap Outside TextField
    func dismissKeyboardOnTapOutsideTextField(addDelegate: Bool = false) {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        if addDelegate {
            tapGesture.delegate = self
        }
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - Keyboard Handling -
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    func unRegisterKeyboardNotification() {
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillChangeFrameNotification)
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        let info = notification.userInfo!
        let endFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let timeFrame = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let screenHeight = UIScreen.main.bounds.height
        
        let keyboardVisibleHeight = max(screenHeight - endFrame.minY, 0)
        
        for constraint in self.view.constraints {
            if constraint.firstAttribute == .bottom {
                // If first item is self's view then constant should be positive else it should be negative
                let multiplier = constraint.firstItem as? UIView == self.view ? 1 : -1
                constraint.constant =  CGFloat(multiplier) * keyboardVisibleHeight
            }
        }
        
        UIView.animate(withDuration: timeFrame) {
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: - Textfield Tapped Methods -
extension MerchantViewController {
    @objc func primaryColorTextFieldTapped() {
        updateButtonColor()
    }
    
    @objc func secondaryColorTextFieldTapped() {
        updateButtonColor()
    }
}

// MARK: - Button Tapped Next -
extension MerchantViewController {
    @IBAction func nextBtnTapped(_ sender: Any) {
        dismissKeyboard()
        let payUConfig = PayUCheckoutProConfig()
        addCheckoutProConfigurations(config: payUConfig)
        PayUCheckoutPro.open(on: self, paymentParam: getPaymentParam(), config: payUConfig, delegate: self)
        //PayUCheckoutPro.open(on: self, params: getPaymentParamDict(), delegate: self)
    }
}

