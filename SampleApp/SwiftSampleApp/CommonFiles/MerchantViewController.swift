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
    @IBOutlet weak var userCredentialTextField: UITextField!
    @IBOutlet weak var txnIDTextField: UITextField!
    @IBOutlet weak var merchantAccessKeyTextField: UITextField!
    @IBOutlet weak var merchantSecretKeyTextField: UITextField!

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
    @IBOutlet weak var orderDetailTextView: UITextView!
    @IBOutlet weak var l1OptionTextView: UITextView!
    @IBOutlet weak var offerDetailTextView: UITextView!
    
    
    // CB Configuration
    @IBOutlet weak var autoOTPSelectSwitch: UISwitch!
    @IBOutlet weak var surePayCountTextField: UITextField!
    @IBOutlet weak var merchantResponseTimeoutTextField: UITextField!
    
    // MARK: - Variables -
    // Please add your salt here. Check salts from https://payumobile.gitbook.io/sdk-integration/test-merchant-list
    let keySalt = [["3TnMpV", "<Please_add_test_salt_here>", Environment.production],
                   ["gtKFFx", "<Please_add_test_salt_here>", Environment.test]]

    let indexKeySalt = 0
    var amount: String = "1"

    var productInfo: String = "Nokia"
    var surl: String = "https://payu.herokuapp.com/ios_success"
    var furl: String = "https://payu.herokuapp.com/ios_failure"
    var firstName: String = "Umang"
    var email: String = "umang@arya.com"
    var phoneNumber: String = "9876543210"
    var userCredential: String = "umang:arya123"
    var primaryColor: String = "#053ac1"
    var secondaryColor: String = "#ffffff"
    var merchantName: String = "Gabbar"
    var logoName: String = "Logo"
    var showCancelDialogOnCheckoutScreen: Bool = true
    var showCancelDialogOnPaymentScreen: Bool = true
    var orderDetail: String = "[{\"GST\":\"5%\"},{\"Delivery Date\":\"25 Dec\"},{\"Status\":\"In Progress\"}]"
    var l1Option: String = "[{\"NetBanking\":\"\"},{\"emi\":\"\"},{\"UPI\":\"TEZ\"},{\"Wallet\":\"PHONEPE\"}]"
    var offerDetail: String = "[[\"5% off on cards and netbanking\",\"Get 5% instant discount on all cards and nb. Max 100\",\"cardnb@5\",\"Cards,NetBanking\",],[\"Cashback on cards and netbanking\",\"Cashback on cards and netbanking\",\"CASHBACK@8405\",\"Cards,NetBanking\"],[\"offer on cards and netbanking\",\"offer on cards and netbanking\",\"cardNBOfferKey@8645\",\"Cards,NetBanking\"],[\"Cashback on cards and netbanking\",\"Cashback on cards and netbanking\",\"cardOfferKey@8643\",\"Cards,NetBanking\"],]"
    var autoOTPSelect: Bool = true
    var surePayCount: String = "2"
    var merchantResponseTimeout: String = "4"
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
        offerDetailTextView.text = offerDetail
        autoOTPSelectSwitch.isOn = autoOTPSelect
        surePayCountTextField.text = surePayCount
        merchantResponseTimeoutTextField.text = merchantResponseTimeout
        recurringAmountTf.text = recurringAmount
        recurringPeriodTf.text = PPKUtils.billingCycleToString(recurringPeriod)
        billingIntervalTf.text = billingInterval
        remarksTextField.text = remarksText
        freeTrialSwitch.isOn = isFreeTrial
        primaryColorTextFieldTapped()
        secondaryColorTextFieldTapped()
        merchantAccessKeyTextField.text = merchantAccessKey
        merchantSecretKeyTextField.text = merchantSecretKey
    }
    
    private func getPaymentParam() -> PayUPaymentParam{
        let paymentParam = PayUPaymentParam(key: keyTextField.text ?? "",
                                             transactionId: txnIDTextField.text ?? "",
                                             amount: amountTextField.text ?? "",
                                             productInfo: productInfoTextField.text ?? "",
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
            paymentParam.siParam = siInfo
        }
        paymentParam.userCredential = userCredentialTextField.text
        paymentParam.enableNativeOTP = true
        paymentParam.additionalParam[PaymentParamConstant.udf1] = "udf11"
        paymentParam.additionalParam[PaymentParamConstant.udf2] = "udf22"
        paymentParam.additionalParam[PaymentParamConstant.udf3] = "udf33"
        paymentParam.additionalParam[PaymentParamConstant.udf4] = "udf44"
        paymentParam.additionalParam[PaymentParamConstant.udf5] = "udf55"
        paymentParam.additionalParam[PaymentParamConstant.merchantAccessKey] = merchantAccessKeyTextField.text ?? ""

//        paymentParam.environment = .test
//        paymentParam.additionalParam[HashConstant.paymentRelatedDetailForMobileSDK] = "0b497efc50edf4f5927890d50825916c3f6ec1a1a7d6b2f27cc273bd91f508624e1fd2ecc51f050f9a0ae9d1bbd48e0021fa3dd390d44b6afdf9ea6eb957492c"
//        paymentParam.additionalParam[HashConstant.vasForMobileSDK] = "6a71a10f33e61ca88307b2e0f97d6ed94cc1a7daf7ba8883dda1bd1079ec3f8c526354e1f9b4ef0f59c90248d91c30fbb58971fcc291e0a7beddf7cc3783966b"
//        paymentParam.additionalParam[HashConstant.payment] = "f43bd495b110ebe63038bb8152b0083cb3bd227e9db8dab6d3fb8c2cb38c3fece787bba76adf755405b549f00b3264d996233ec02fce973f8ff24ba1e7751cbe"
        return paymentParam
    }
    
    @IBAction open func appCrash(){
        let array = [Int]()
        print(array[1])
    }
    
    @IBAction open func sdkCrash(){
        PayUCheckoutPro.sdkCrash()
    }
    
    private func addCheckoutProConfigurations(config: PayUCheckoutProConfig) {
        config.merchantName = merchantNameTextField.text
        config.merchantLogo = UIImage(named: logoNameTextField.text ?? "")
        config.paymentModesOrder = getPreferredPaymentMode()
        config.cartDetails = cartDetails()
        config.offerDetails = offerDetails()
        if let primary = Utils.hexStringToUIColor(hex: primaryColorTextField.text ?? ""), let secondary = Utils.hexStringToUIColor(hex: secondaryColorTextField.text ?? "") {
            config.customiseUI(primaryColor: primary, secondaryColor: secondary)
        }
        config.showExitConfirmationOnPaymentScreen = showCancelDialogOnPaymentScreenSwitch.isOn
        config.showExitConfirmationOnCheckoutScreen = showCancelDialogOnCheckoutScreenSwitch.isOn
        
        // CB Configurations
        config.autoSelectOtp = autoOTPSelectSwitch.isOn
        if let surePayCountStr = surePayCountTextField.text,
            let surePayCount = UInt(surePayCountStr) {
            config.surePayCount = surePayCount
        }
        if let merchantResponseTimeoutStr = merchantResponseTimeoutTextField.text,
            let merchantResponseTimeout = TimeInterval(merchantResponseTimeoutStr) {
            config.merchantResponseTimeout = merchantResponseTimeout
        }
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
    
    func offerDetails() -> [PayUOfferDetails]? {
        if let offerJSON = Utils.JSONFrom(string: offerDetailTextView.text) as? [[String]] {
            var offerDetails = [PayUOfferDetails]()
            for eachOfferJSON in offerJSON {
                let paymentTypesStringArray = eachOfferJSON[3].components(separatedBy: ",")
                let paymentTypesArray = paymentTypesStringArray.compactMap{Utils.paymentTypeFrom(paymentType: $0)}
                if let offerDetailObj = PayUOfferDetails(title: eachOfferJSON[0],
                                                         offerDescription:eachOfferJSON[1],
                                                         offerKey: eachOfferJSON[2],
                                                         paymentTypes: paymentTypesArray) {
                    offerDetails.append(offerDetailObj)
                }
            }
            return offerDetails
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
        // get hash for "commandName" from server
        // get hash for "hashStringWithoutSalt" from server
        
        
        
        // After fetching hash set its value in below variable "hashValue"
        var hashValue = ""
        if commandName == HashConstant.mcpLookup {
            hashValue = Utils.hmacsha1(of: hashStringWithoutSalt, secret: (merchantSecretKeyTextField.text ?? ""))
        } else {
            hashValue = Utils.sha512Hex(string: (hashStringWithoutSalt + (saltTextField.text ?? "")))
        }
        onCompletion([commandName : hashValue])
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
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
    }
}
