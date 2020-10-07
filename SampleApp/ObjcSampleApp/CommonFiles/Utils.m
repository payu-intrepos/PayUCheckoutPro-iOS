//
//  Utils.m
//  CheckoutProObjCWithoutFrameworkSampleApp
//
//  Created by Umang Arya on 09/07/20.
//  Copyright © 2020 PayU Payments Pvt Ltd. All rights reserved.
//

#import "Utils.h"
#include <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation Utils

+ (NSString *) getTransactionID {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = @"yyMMddHHmmss";
    NSString *txnID = [NSString stringWithFormat:@"iOS%@",[formatter stringFromDate:[NSDate date]]];
    return  txnID;
}

+ (void)presentAlertOn:(UIViewController *)controller title:(NSString *)title message:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
        [alertController addAction:actionOk];
        
        [controller presentViewController:alertController animated:YES completion:nil];
    });
}


@end
