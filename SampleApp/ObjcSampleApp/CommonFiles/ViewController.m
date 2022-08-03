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
#import <PayUBizCoreKit/PayUBizCoreKit.h>
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
    PayUPaymentParam *paymentParam = [[PayUPaymentParam alloc] initWithKey:@"<key>"
                                                             transactionId:[Utils getTransactionID]
                                                                    amount:@"10000"
                                                               productInfo:@"Nokia"
                                                                 firstName:@"Umang"
                                                                     email:@"umang@arya.com"
                                                                     phone:@"9876543210"
                                                                      surl:@"https://payu.herokuapp.com/ios_success"
                                                                      furl:@"https://payu.herokuapp.com/ios_failure"
                                                               environment:EnvironmentProduction];
    paymentParam.userCredential = @"umang:arya";
    paymentParam.userToken = @"test";
    return paymentParam;
}

- (NSArray<PaymentMode *> *) getPreferredPaymentMode {
    return @[
        [[PaymentMode alloc] initWithPaymentType:PaymentTypeNetBanking paymentOptionID:nil],
        [[PaymentMode alloc] initWithPaymentType:PaymentTypeWallet paymentOptionID: BankCodes.gPayUPI],
        [[PaymentMode alloc] initWithPaymentType:PaymentTypeWallet paymentOptionID: BankCodes.phonePeWallet],
    ];
}

#pragma mark IBAction methods

- (IBAction)nextButtonTapped:(id)sender {
    PayUCheckoutProConfig *config = [PayUCheckoutProConfig new];
    config.merchantName = @"Umang Enterprises";

    config.paymentModesOrder = [self getPreferredPaymentMode];
    config.autoSelectOtp = true;
    config.merchantResponseTimeout = 8;
    config.surePayCount = 2;
    [PayUCheckoutPro openOn:self paymentParam:[self paymentParam] config:config delegate:self];
}

#pragma mark PayUCheckoutProDelegate methods

- (void)generateHashFor:(NSDictionary<NSString *,NSString *> * _Nonnull)param onCompletion:(void (^ _Nonnull)(NSDictionary<NSString *,NSString *> * _Nonnull))onCompletion {
    NSString *commandName = [param objectForKey:HashConstant.hashName];
    NSString *hashStringWithoutSalt = [param objectForKey:HashConstant.hashString];
    NSString *postSalt = [param objectForKey:HashConstant.postSalt];
    NSString *hashType = [param objectForKey:HashConstant.hashType];
    NSString *salt = @"<salt>";
    NSString *secret = @"<merchant_secret>";
    NSString *hashValue;
    // get hash for "commandName" from server
    // get hash for "hashStringWithoutSalt" from server
    // After fetching hash set its value in below variable "hashValue"
    // NSString *hashValue = @"hashValue";

    if ([hashType isEqualToString:@"V2"]) {
        hashValue = @"<hmacSHA256 hash for hashStringWithoutSalt with salt>";
    }
    else if ([commandName isEqualToString:HashConstant.mcpLookup]) {
        hashValue = @"<hmacsha1 hash for hashStringWithoutSalt and secret>";
    }
    else if (postSalt && ![postSalt isEqualToString:@""]) {
        NSString *hashString = [NSString stringWithFormat:@"%@%@|%@",hashStringWithoutSalt,salt,postSalt];
        hashValue = @"<hmacsha512 hash for hashString and salt>";
    }
    else {
        hashValue = @"<hmacsha512 hash for hashStringWithoutSalt and salt>";
    }
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
