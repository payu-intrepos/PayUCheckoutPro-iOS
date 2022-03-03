//
//  ViewController.m
//  CheckoutProObjCSampleApp
//
//  Created by Umang Arya on 08/07/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import <PayUCheckoutProKit/PayUCheckoutProKit.h>
#import <PayUCheckoutProBaseKit/PayUCheckoutProBaseKit.h>
#import <PayUParamsKit/PayUParamsKit.h>
#import "Utils.h"

@interface ViewController () <PayUCheckoutProDelegate>

@end

@implementation ViewController

#pragma mark Overridden Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark Helper Methods

- (PayUPaymentParam *) paymentParam {
    PayUPaymentParam *paymentParam = [[PayUPaymentParam alloc] initWithKey:@"gtKFFx"
                                                             transactionId:[Utils getTransactionID]
                                                                    amount:@"1"
                                                               productInfo:@"Nokia"
                                                                 firstName:@"Umang"
                                                                     email:@"umang@arya.com"
                                                                     phone:@"9876543210"
                                                                      surl:@"https://payu.herokuapp.com/ios_success"
                                                                      furl:@"https://payu.herokuapp.com/ios_failure"
                                                               environment:EnvironmentTest];
    paymentParam.userCredential = @"umang:arya";
    
    paymentParam.siParam = [self siParams];
    return paymentParam;
}

- (PayUSIParams *) siParams {
    PayUSIParams *siParams = [[PayUSIParams alloc] initWithBillingAmount:@"123"
                                                        paymentStartDate:[[NSDate date] dateByAddingTimeInterval:123111]
                                                          paymentEndDate:[[NSDate date] dateByAddingTimeInterval:42312312]
                                                            billingCycle:PayUBillingCycleDaily
                                                         billingInterval: [NSNumber numberWithInt:12]];
    return siParams;
}

- (NSMutableArray *) enforcePaymentList {
    NSMutableArray * array = [NSMutableArray new];

    NSDictionary *nbEnforcement = @{PaymentParamConstant.paymentType: PaymentParamConstant.nb};
    NSDictionary *ccdcEnforcement = @{PaymentParamConstant.paymentType: PaymentParamConstant.card, PaymentParamConstant.cardType: PaymentParamConstant.cc}; //CardType : PaymentParamConstant.cc or PaymentParamConstant.dc
    NSDictionary *upiEnforcement = @{PaymentParamConstant.paymentType: PaymentParamConstant.upi};
    NSDictionary *walletEnforcement = @{PaymentParamConstant.paymentType: PaymentParamConstant.wallet};
    NSDictionary *emiEnforcement = @{PaymentParamConstant.paymentType: PaymentParamConstant.emi};
    NSDictionary *neftEnforcement = @{PaymentParamConstant.paymentType: PaymentParamConstant.neftrtgs};
    NSDictionary *sodexoEnforcement = @{PaymentParamConstant.paymentType: PaymentParamConstant.sodexo};
    NSDictionary *otherEnforcement = @{PaymentParamConstant.paymentType: PaymentParamConstant.lazypay};
    
    [array addObject:nbEnforcement];
    [array addObject:ccdcEnforcement];
    [array addObject:upiEnforcement];
    [array addObject:walletEnforcement];
    [array addObject:emiEnforcement];
    [array addObject:neftEnforcement];
    [array addObject:sodexoEnforcement];
    [array addObject:otherEnforcement];
    return array;
}

- (NSArray<PaymentMode *> *) getPreferredPaymentMode {
    return @[
        [[PaymentMode alloc] initWithPaymentType:PaymentTypeNetBanking paymentOptionID:nil],
        [[PaymentMode alloc] initWithPaymentType:PaymentTypeWallet paymentOptionID: BankCodes.gPayUPI],
        [[PaymentMode alloc] initWithPaymentType:PaymentTypeWallet paymentOptionID: BankCodes.phonePeWallet],
    ];
}

- (NSArray<PayUOfferDetails *> *) getOfferDetails {
    return @[
        [[PayUOfferDetails alloc] initWithTitle:@"20% off on cards"
                               offerDescription:@"Get 20% instant discount on all cards. Max 100"
                                       offerKey:@"card@20"
                                   paymentTypes:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:PaymentTypeCcdc], nil]],
        [[PayUOfferDetails alloc] initWithTitle:@"10% off on netbanking"
                               offerDescription:@"Get 10% instant discount on all netbanking. Max 100"
                                       offerKey:@"nb@10"
                                   paymentTypes:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:PaymentTypeNetBanking], nil]],
        [[PayUOfferDetails alloc] initWithTitle:@"5% off on cards and netbanking"
                               offerDescription:@"Get 5% instant discount on all cards and nb. Max 100"
                                       offerKey:@"cardnb@5"
                                   paymentTypes:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:PaymentTypeNetBanking],
                                                 [NSNumber numberWithInt:PaymentTypeCcdc], nil]],
        [[PayUOfferDetails alloc] initWithTitle:@"20% off on cards"
                               offerDescription:@"Get 20% instant discount on all cards. Max 100"
                                       offerKey:@"card@20"
                                   paymentTypes:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:PaymentTypeCcdc], nil]],
        [[PayUOfferDetails alloc] initWithTitle:@"10% off on netbanking"
                               offerDescription:@"Get 10% instant discount on all netbanking. Max 100"
                                       offerKey:@"nb@10"
                                   paymentTypes:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:PaymentTypeNetBanking], nil]],
        [[PayUOfferDetails alloc] initWithTitle:@"5% off on cards and netbanking"
                               offerDescription:@"Get 5% instant discount on all cards and nb. Max 100"
                                       offerKey:@"cardnb@5"
                                   paymentTypes:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:PaymentTypeNetBanking],
                                                 [NSNumber numberWithInt:PaymentTypeCcdc], nil]],
        [[PayUOfferDetails alloc] initWithTitle:@"20% off on cards"
                               offerDescription:@"Get 20% instant discount on all cards. Max 100"
                                       offerKey:@"card@20"
                                   paymentTypes:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:PaymentTypeCcdc], nil]],
        [[PayUOfferDetails alloc] initWithTitle:@"10% off on netbanking"
                               offerDescription:@"Get 10% instant discount on all netbanking. Max 100"
                                       offerKey:@"nb@10"
                                   paymentTypes:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:PaymentTypeNetBanking], nil]],
        [[PayUOfferDetails alloc] initWithTitle:@"5% off on cards and netbanking"
                               offerDescription:@"Get 5% instant discount on all cards and nb. Max 100"
                                       offerKey:@"cardnb@5"
                                   paymentTypes:[[NSArray alloc] initWithObjects:[NSNumber numberWithInt:PaymentTypeNetBanking],
                                                 [NSNumber numberWithInt:PaymentTypeCcdc], nil]],
    ];
}

#pragma mark IBAction methods

- (IBAction)nextButtonTapped:(id)sender {
    PayUCheckoutProConfig *config = [PayUCheckoutProConfig new];
    config.merchantName = @"Umang Enterprises";
    config.paymentModesOrder = [self getPreferredPaymentMode];
    config.autoSelectOtp = true;
    config.merchantResponseTimeout = 8;
    config.offerDetails = [self getOfferDetails];
   
    // Enforce Payment Configurations

    /* // Uncomment below code to set enforcement on other payment modes
     config.enforcePaymentList = [self enforcePaymentList];
     */
    
    // CB Configurations
    config.autoSubmitOtp = YES;
    
    [PayUCheckoutPro openOn:self paymentParam:[self paymentParam] config:config delegate:self];
}

#pragma mark PayUCheckoutProDelegate methods

- (void)generateHashFor:(NSDictionary<NSString *,NSString *> * _Nonnull)param onCompletion:(void (^ _Nonnull)(NSDictionary<NSString *,NSString *> * _Nonnull))onCompletion {
    NSString *commandName = [param objectForKey:HashConstant.hashName];
    NSString *hashStringWithoutSalt = [param objectForKey:HashConstant.hashString];
    // get hash for "commandName" from server
    // get hash for "hashStringWithoutSalt" from server
    
    
    // After fetching hash set its value in below variable "hashValue"
    NSString *hashValue = [Utils getHash:[NSString stringWithFormat:@"%@%@",hashStringWithoutSalt,@"<Please_add_test_salt_here>"]];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:hashValue, commandName, nil];
    onCompletion(dict);
}

- (void)onPaymentSuccessWithResponse:(id _Nullable)response {
    // handle success scenario
    [Utils presentAlertOn:self title:@"Success" message:[NSString stringWithFormat:@"%@",response]];
}

- (void)onPaymentFailureWithResponse:(id _Nullable)response {
    // handle failure scenario
    [Utils presentAlertOn:self title:@"Failure" message:[NSString stringWithFormat:@"%@",response]];
}

- (void)onError:(NSError * _Nullable)error {
    // handle error scenario
    [Utils presentAlertOn:self title:@"Error" message:[NSString stringWithFormat:@"%@",error.localizedDescription]];
}

- (void)onPaymentCancelWithIsTxnInitiated:(BOOL)isTxnInitiated {
    // handle txn cancelled scenario
    // isTxnInitiated == YES, means user cancelled the txn when on reaching bankPage
    // isTxnInitiated == NO, means user cancelled the txn before reaching the bankPage
    [Utils presentAlertOn:self title:@"Cancel" message:[NSString stringWithFormat:@"%d",isTxnInitiated]];
}

@end
