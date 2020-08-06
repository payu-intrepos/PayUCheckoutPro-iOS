//
//  ViewController.m
//  CheckoutProObjCSampleApp
//
//  Created by Umang Arya on 08/07/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

#import "ViewController.h"
#import <PayUCheckoutPro/PayUCheckoutPro-Swift.h>
#import <PayUCheckoutProBase/PayUCheckoutProBase-Swift.h>

@interface ViewController () <PayUCheckoutProDelegate>

@end

@implementation ViewController

#pragma mark Overridden Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark Helper Methods

- (PayUPaymentParams *) paymentParam {
    PayUPaymentParams *paymentParam = [[PayUPaymentParams alloc] initWithKey:@"3TnMpV"
                                                               transactionId:@"txnID"
                                                                      amount:@"43"
                                                                 productInfo:@"Nokia"
                                                                   firstName:@"Umang"
                                                                       email:@"umang@arya.com"
                                                                       phone:@"9876543210"
                                                                        surl:@"https://payu.herokuapp.com/success"
                                                                        furl:@"https://payu.herokuapp.com/failure"
                                                                 environment:EnvironmentProduction];
    paymentParam.userCredential = @"umang:arya";
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

    [PayUCheckoutPro openOn:self paymentParam:[self paymentParam] config:config delegate:self];
}

#pragma mark PayUCheckoutProDelegate methods

- (void)generateHashFor:(NSDictionary<NSString *,NSString *> * _Nonnull)param onCompletion:(void (^ _Nonnull)(NSDictionary<NSString *,NSString *> * _Nonnull))onCompletion {
    NSString *commandName = [param objectForKey:HashConstant.hashName];
    NSString *hashStringWithoutSalt = [param objectForKey:HashConstant.hashString];
    // get hash for "commandName" from server
    // get hash for "hashStringWithoutSalt" from server
    
    
    // After fetching hash set its value in below variable "hashValue"
    NSString *hashValue = @"hashValue";
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:hashValue, commandName, nil];
    onCompletion(dict);
}

- (void)onPaymentSuccessWithResponse:(id _Nullable)response {
    // handle success scenario
}

- (void)onPaymentFailureWithResponse:(id _Nullable)response {
    // handle failure scenario
}

- (void)onError:(NSError * _Nullable)error {
    // handle error scenario
}

- (void)onPaymentCancelWithIsTxnInitiated:(BOOL)isTxnInitiated {
    // handle txn cancelled scenario
    // isTxnInitiated == YES, means user cancelled the txn when on reaching bankPage
    // isTxnInitiated == NO, means user cancelled the txn before reaching the bankPage
}

@end
